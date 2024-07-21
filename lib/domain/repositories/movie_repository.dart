import 'package:themoviedb/domain/api_client/movie_api_client.dart';
import 'package:themoviedb/domain/configuration/configuration.dart';
import 'package:themoviedb/domain/entity/popular_movie_response.dart';

class MovieRepository {
  final _movieApiClient = MovieApiClient();

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
}
