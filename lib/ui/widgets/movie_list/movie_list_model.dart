import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/entity/movie.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

class MovieListModel extends ChangeNotifier {
  final _client = ApiClient();
  final _movies = <Movie>[];
  late DateFormat _dateFormat;
  String _locale = '';
  late int _currentPage;
  late int _totalPage;
  var _isLoadingInProgres = false;

  List<Movie> get movies => List.unmodifiable(_movies);

  void setupLocale(BuildContext context) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    _movies.clear();
    _currentPage = 0;
    _totalPage = 1;
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    if (_isLoadingInProgres || _currentPage >= _totalPage) return;
    _isLoadingInProgres = true;
    final nextPage = _currentPage + 1;
    try {
      final moviesResponse = await _client.popularMovie(
        page: nextPage,
        language: _locale,
      );
      _movies.addAll(moviesResponse.movies);
      _currentPage = moviesResponse.page;
      _totalPage = moviesResponse.totalPages;
      _isLoadingInProgres = false;
      notifyListeners();
    } catch (e) {
      _isLoadingInProgres = false;
    }
  }

  void viewMovieInfo(BuildContext context, int index) {
    final id = _movies[index].id;
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.movieDetails,
      arguments: id,
    );
  }

  String stringFromData(DateTime date) => _dateFormat.format(date);

  void showMovieAtIndex(int index) {
    if (index < _movies.length - 1) return;
    _loadMovies();
  }
}
