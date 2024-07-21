import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/Library/paginator.dart';
import 'package:themoviedb/domain/entity/movie.dart';
import 'package:themoviedb/domain/repositories/movie_repository.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

class MovieListRowData {
  final int id;
  final String title;
  final String overview;
  final String releaseDate;
  final String? posterPath;

  MovieListRowData({
    required this.id,
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.posterPath,
  });
}

class MovieListViewModel extends ChangeNotifier {
  final _movieRepository = MovieRepository();
  late final Paginator<Movie> _popularMoviePaginator;
  late final Paginator<Movie> _searchMoviePaginator;
  List<MovieListRowData> _movies = <MovieListRowData>[];
  late DateFormat _dateFormat;
  String _locale = '';
  String? _querySearch;
  Timer? _searchDebounce;

  List<MovieListRowData> get movies => List.unmodifiable(_movies);

  bool get isSearchMode => _querySearch != null && _querySearch!.isNotEmpty;

  MovieListViewModel() {
    _popularMoviePaginator = Paginator<Movie>((page) async {
      final result = await _movieRepository.popularMovie(_locale, page);
      return PaginatorLoadResult(
        data: result.movies,
        currentPage: result.page,
        totalPage: result.totalPages,
      );
    });
    _searchMoviePaginator = Paginator<Movie>((page) async {
      final result = await _movieRepository.searchMovie(
        _querySearch ?? '',
        _locale,
        page,
      );
      return PaginatorLoadResult(
        data: result.movies,
        currentPage: result.page,
        totalPage: result.totalPages,
      );
    });
  }

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    await _resetList();
  }

  Future<void> _resetList() async {
    await _popularMoviePaginator.reset();
    await _searchMoviePaginator.reset();
    _movies.clear();
    await _loadNextPage();
  }

  Future<void> _loadNextPage() async {
    if (isSearchMode) {
      await _searchMoviePaginator.loadNextPage();
      _movies = _searchMoviePaginator.data.map(_makeRowData).toList();
    } else {
      await _popularMoviePaginator.loadNextPage();
      _movies = _popularMoviePaginator.data.map(_makeRowData).toList();
    }
    notifyListeners();
  }

  void viewMovieInfo(BuildContext context, int index) {
    final id = _movies[index].id;
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.movieDetails,
      arguments: id,
    );
  }

  void showMovieAtIndex(int index) {
    if (index < _movies.length - 1) return;
    _loadNextPage();
  }

  Future<void> searchMovies(String value) async {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 300), () async {
      final querySearch = value.isNotEmpty ? value : null;
      if (_querySearch == querySearch) return;
      _querySearch = querySearch;
      _movies.clear();
      if (isSearchMode) {
        await _searchMoviePaginator.reset();
      }
      await _loadNextPage();
    });
  }

  MovieListRowData _makeRowData(Movie movie) {
    return MovieListRowData(
      id: movie.id,
      title: movie.title,
      overview: movie.overview,
      releaseDate: _dateFormat.format(movie.releaseDate),
      posterPath: movie.posterPath,
    );
  }
}
