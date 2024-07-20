import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/api_client/movie_api_client.dart';
import 'package:themoviedb/domain/entity/movie.dart';
import 'package:themoviedb/domain/entity/popular_movie_response.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

class MovieListModel extends ChangeNotifier {
  final _movieApiClient = MovieApiClient();
  final _movies = <Movie>[];

  late DateFormat _dateFormat;
  String _locale = '';

  late int _currentPage;
  late int _totalPage;
  var _isLoadingInProgress = false;

  String? _querySearch;
  Timer? _searchDebounce;

  List<Movie> get movies => List.unmodifiable(_movies);

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    await _resetList();
  }

  Future<void> _resetList() async {
    _movies.clear();
    _currentPage = 0;
    _totalPage = 1;
    await _loadNextPage();
  }

  Future<PopularMovieResponse> _loadMovie(int page) async {
    final query = _querySearch;
    if (query == null) {
      return await _movieApiClient.popularMovie(
        language: _locale,
        page: page,
      );
    } else {
      return await _movieApiClient.searchMovie(
        query: query,
        language: _locale,
        page: page,
      );
    }
  }

  Future<void> _loadNextPage() async {
    if (_isLoadingInProgress || _currentPage >= _totalPage) return;
    _isLoadingInProgress = true;
    final nextPage = _currentPage + 1;
    try {
      final moviesResponse = await _loadMovie(nextPage);
      _movies.addAll(moviesResponse.movies);
      _currentPage = moviesResponse.page;
      _totalPage = moviesResponse.totalPages;
      _isLoadingInProgress = false;
      notifyListeners();
    } catch (e) {
      _isLoadingInProgress = false;
    }
  }

  void viewMovieInfo(BuildContext context, int index) {
    final id = _movies[index].id;
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.movieDetails,
      arguments: id,
    );
  }

  String stringFromDate(DateTime date) => _dateFormat.format(date);

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
      await _resetList();
    });
  }
}
