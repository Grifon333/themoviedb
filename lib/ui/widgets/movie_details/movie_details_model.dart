import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/entity/movie_details.dart';

class MovieDetailsModel extends ChangeNotifier {
  final _apiClient = ApiClient();

  int movieId;
  MovieDetails? _movieDetails;
  String _locale = '';
  late DateFormat _dateFormat;

  MovieDetails? get movieDetails => _movieDetails;

  MovieDetailsModel({required this.movieId,});

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (locale == _locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    await _loadDetails();
  }

  Future<void> _loadDetails() async {
    _movieDetails = await _apiClient.movieDetails(_locale, movieId);
    notifyListeners();
  }
}