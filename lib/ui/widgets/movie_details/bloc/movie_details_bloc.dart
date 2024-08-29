import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/api_client/api_client_exception.dart';
import 'package:themoviedb/domain/data_providers/locale_data_provider.dart';
import 'package:themoviedb/domain/repositories/auth_repository.dart';
import 'package:themoviedb/domain/repositories/movie_repository.dart';
import 'package:themoviedb/ui/widgets/movie_details/models/models.dart';
import 'package:themoviedb/domain/entity/movie_details.dart' as entity;

part 'movie_details_event.dart';

part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final AuthenticationRepository _authRepository;
  final MovieRepository _movieRepository;
  final LocaleDataProvider _localeDataProvider;
  final int _movieId;
  late final DateFormat _dateFormat;

  MovieDetailsBloc({
    required AuthenticationRepository authRepository,
    required MovieRepository movieRepository,
    required LocaleDataProvider localeDataProvider,
    required int movieId,
  })  : _authRepository = authRepository,
        _movieRepository = movieRepository,
        _localeDataProvider = localeDataProvider,
        _movieId = movieId,
        super(const MovieDetailsState()) {
    _init();
    on<MovieDetailsFetched>(_onFetched);
    on<MovieDetailsUpdateFavoriteStatus>(_onUpdateFavoriteStatus);
  }

  Future<void> _init() async {
    _dateFormat = DateFormat.yMd(await _localeDataProvider.localeTag);
  }

  Future<void> _onFetched(
    MovieDetailsFetched event,
    Emitter<MovieDetailsState> emit,
  ) async {
    try {
      // TODO: Data = (movieDetails, isFavorite, certification)
      final data = await _movieRepository.loadDetails(
        await _localeDataProvider.localeTag,
        _movieId,
        await _localeDataProvider.countryCode,
      );
      final movieDetails = mapMovieDetailsFromEntity(data.$1)
        ..copyWith(certification: data.$3);
      emit(state.copyWith(
        status: MovieDetailsStatus.success,
        title: movieDetails.title,
        isFavorite: data.$2,
        movieDetails: movieDetails,
      ));
    } on ApiClientException catch (e) {
      _handleApiClientException(e);
    }
  }

  Future<void> _onUpdateFavoriteStatus(
    MovieDetailsUpdateFavoriteStatus event,
    Emitter<MovieDetailsState> emit,
  ) async {
    try {
      await _movieRepository.updateFavorite(_movieId, state.isFavorite ^ true);
      emit(state.copyWith(isFavorite: state.isFavorite ^ true));
    } on ApiClientException catch (e) {
      _handleApiClientException(e);
    }
  }

  void _handleApiClientException(ApiClientException exception) {
    switch (exception.type) {
      case ApiClientExceptionType.sessionExpired:
        _authRepository.logOut();
        break;
      default:
        log(exception.toString());
    }
  }

  MovieDetails mapMovieDetailsFromEntity(entity.MovieDetails entity) {
    return MovieDetails(
      backdropPath: entity.backdropPath,
      posterPath: entity.posterPath,
      title: entity.title,
      year: entity.releaseDate != null ? ' (${entity.releaseDate!.year})' : '',
      score: entity.voteAverage / 10,
      youtubeKey: MovieDetails.mapYoutubeKey(entity.videos),
      releaseDate: entity.releaseDate != null
          ? _dateFormat.format(entity.releaseDate!)
          : '',
      productionCountry: entity.productionCountries.isNotEmpty
          ? entity.productionCountries[0].iso
          : '',
      runtime: MovieDetails.mapTime(entity.runtime ?? 0),
      genres: entity.genres.map((e) => e.name).join(', '),
      tagLine: entity.tagline,
      overview: entity.overview ?? '',
      crew: Crewman.mapCrew(entity.credits.crew),
      cast: Actor.mapCast(entity.credits.cast),
    );
  }
}
