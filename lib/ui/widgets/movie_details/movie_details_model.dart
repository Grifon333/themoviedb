import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/domain/entity/movie_details.dart';

class MovieDetailsModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _sessionDataProvider = SessionDataProvider();

  int movieId;
  MovieDetails? _movieDetails;
  String _certification = '';
  String _locale = '';
  String _countryCode = '';
  late DateFormat _dateFormat;
  Future<void>? Function()? onSessionExpired;

  bool _favorite = false;

  MovieDetails? get movieDetails => _movieDetails;

  String get certification => _certification;

  bool isFavorite() => _favorite;

  MovieDetailsModel({
    required this.movieId,
  });

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
    final sessionId = await _sessionDataProvider.getSessionId();
    if (sessionId != null) {
      _favorite = await _apiClient.isFavoriteMovie(movieId, sessionId);
    }
    notifyListeners();
  }

  String stringFromDate(DateTime date) => _dateFormat.format(date);

  Future<void> changeFavorite(BuildContext context) async {
    final accountId = await _sessionDataProvider.getAccountId();
    final sessionId = await _sessionDataProvider.getSessionId();

    _favorite = !_favorite;
    notifyListeners();
    if (accountId == null || sessionId == null) return;

    try {
      await _apiClient.markAsFavorite(
        sessionId,
        accountId,
        MediaType.movie,
        movieId,
        _favorite,
      );
    } on ApiClientException catch (e) {
      if (e.type == ApiClientExceptionType.sessionExpired) {
        await onSessionExpired?.call();
      }
    }
  }
}
