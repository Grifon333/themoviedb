import 'dart:developer';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:themoviedb/domain/api_client/api_client_exception.dart';
import 'package:themoviedb/domain/data_providers/locale_data_provider.dart';
import 'package:themoviedb/domain/entity/popular_movie_response.dart';
import 'package:themoviedb/domain/repositories/movie_repository.dart';
import 'package:themoviedb/ui/widgets/movie_list/models/models.dart';
import 'package:themoviedb/domain/entity/movie.dart' as entity;

part 'movie_list_event.dart';

part 'movie_list_state.dart';

const throttleDuration = Duration(milliseconds: 100);
const debounceDuration = Duration(milliseconds: 500);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

EventTransformer<E> debounceDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.debounce(duration), mapper);
  };
}

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final MovieRepository _movieRepository;
  final LocaleDataProvider _localeDataProvider;
  late final DateFormat _dateFormat;

  MovieListBloc({
    required MovieRepository movieRepository,
    required LocaleDataProvider localeDataProvider,
  })  : _movieRepository = movieRepository,
        _localeDataProvider = localeDataProvider,
        super(const MovieListState()) {
    _init();
    on<MovieListFetched>(
      _onMovieListFetched,
      transformer: throttleDroppable(throttleDuration),
    );
    on<MovieListSearchQueryChanged>(
      _onMovieListSearchQueryChanged,
      transformer: debounceDroppable(debounceDuration),
    );
  }

  Future<void> _init() async {
    _dateFormat = DateFormat.yMMMMd(await _localeDataProvider.localeTag);
  }

  Future<void> _onMovieListFetched(
    MovieListFetched event,
    Emitter<MovieListState> emit,
  ) async {
    try {
      final PopularMovieResponse data = state.searchQuery.isPure
          ? await _fetchedPopularMovies()
          : await _fetchedSearchMovies(state.searchQuery.value);
      final newMovies = data.movies.map(_movieMapper).toList();
      emit(state.copyWith(
        status: MovieListStatus.success,
        currentPage: data.page,
        totalPages: data.totalPages,
        movies: state.status == MovieListStatus.initial
            ? newMovies
            : (state.movies..addAll(newMovies)),
      ));
    } catch (e) {
      if (e is ApiClientException) {
        log('Api Client Exception: ${e.type}');
      } else {
        log('Exception: $e');
      }
      emit(state.copyWith(status: MovieListStatus.failure));
    }
  }

  Future<PopularMovieResponse> _fetchedPopularMovies() async {
    return await _movieRepository.popularMovie(
      await _localeDataProvider.localeTag,
      state.currentPage + 1,
    );
  }

  Future<PopularMovieResponse> _fetchedSearchMovies(String searchQuery) async {
    return await _movieRepository.searchMovie(
      searchQuery,
      await _localeDataProvider.localeTag,
      state.currentPage + 1,
    );
  }

  Future<void> _onMovieListSearchQueryChanged(
    MovieListSearchQueryChanged event,
    Emitter<MovieListState> emit,
  ) async {
    final searchQuery = SearchQuery.dirty(value: event.searchQuery);
    if (searchQuery == state.searchQuery) return;
    emit(state.copyWith(
      status: MovieListStatus.initial,
      currentPage: 0,
      searchQuery: searchQuery,
      movies: [],
    ));
    add(MovieListFetched());
  }

  Movie _movieMapper(entity.Movie movie) {
    return Movie(
      id: movie.id,
      title: movie.title,
      overview: movie.overview,
      releaseDate: movie.releaseDate != null
          ? _dateFormat.format(movie.releaseDate!)
          : '',
      posterPath: movie.posterPath,
    );
  }
}
