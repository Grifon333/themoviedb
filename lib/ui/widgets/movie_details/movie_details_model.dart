import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/entity/movie_details.dart';

class MovieDetailsModel extends ChangeNotifier {
  final _apiClient = ApiClient();

  int movieId;
  MovieDetails? _movieDetails;
  String _certification = '';
  String _locale = '';
  String _countryCode = '';
  late DateFormat _dateFormat;

  MovieDetails? get movieDetails => _movieDetails;
  String get certification => _certification;

  MovieDetailsModel({required this.movieId,});

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    final countryCode = Localizations.localeOf(context).countryCode ?? 'US';
    if (locale == _locale || countryCode == _countryCode) return;
    _locale = locale;
    _countryCode = countryCode;
    _dateFormat = DateFormat.yMd(locale);
    await _loadDetails();
  }

  Future<void> _loadDetails() async {
    _movieDetails = await _apiClient.movieDetails(_locale, movieId);
    _certification = await _apiClient.certification(movieId, _countryCode);
    notifyListeners();
  }

  String stringFromDate(DateTime date) => _dateFormat.format(date);
}