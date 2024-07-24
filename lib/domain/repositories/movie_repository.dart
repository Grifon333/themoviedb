import 'package:themoviedb/domain/api_client/account_api_client.dart';
import 'package:themoviedb/domain/api_client/movie_api_client.dart';
import 'package:themoviedb/domain/configuration/configuration.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/domain/entity/movie_details.dart';
import 'package:themoviedb/domain/entity/popular_movie_response.dart';

class MovieRepository {
  final _movieApiClient = MovieApiClient();
  final SessionDataProvider _sessionDataProvider = SessionDataProvider();
  final AccountApiClient _accountApiClient = AccountApiClient();

  Future<PopularMovieResponse> popularMovie(String locale, int page) async =>
      await _movieApiClient.popularMovie(
        language: locale,
        page: page,
        apiKey: Configuration.apiKey,
      );

  Future<PopularMovieResponse> searchMovie(
    String query,
    String locale,
    int page,
  ) async =>
      await _movieApiClient.searchMovie(
        query: query,
        language: locale,
        page: page,
        apiKey: Configuration.apiKey,
      );

  Future<(MovieDetails, bool, String)> loadDetails(
    String locale,
    int movieId,
    countryCode,
  ) async {
    final MovieDetails movieDetails =
        await _movieApiClient.movieDetails(locale, movieId);
    final sessionId = await _sessionDataProvider.getSessionId();
    bool isFavorite = false;
    if (sessionId != null) {
      isFavorite = await _accountApiClient.isFavoriteMovie(movieId, sessionId);
    }
    final String certification = await _movieApiClient.certification(
      movieId,
      countryCode,
    );
    return (movieDetails, isFavorite, certification);
  }

  Future<void> updateFavorite(int movieId, bool isFavorite) async {
    final accountId = await _sessionDataProvider.getAccountId();
    final sessionId = await _sessionDataProvider.getSessionId();
    if (accountId == null || sessionId == null) return;
    await _accountApiClient.markAsFavorite(
      sessionId,
      accountId,
      MediaType.movie,
      movieId,
      isFavorite,
    );
  }
}
