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

  List<Movie> get movies => List.unmodifiable(_movies);

  void setupLocale(BuildContext context) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    _movies.clear();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    final moviesResponse =
        await _client.popularMovie(language: _locale); // page: 1, language: en-US
    _movies.addAll(moviesResponse.movies);
    notifyListeners();
  }

  void viewMovieInfo(BuildContext context, int index) {
    final id = _movies[index].id;
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.movieDetails,
      arguments: id,
    );
  }

  String stringFromData(DateTime date) => _dateFormat.format(date);
}
