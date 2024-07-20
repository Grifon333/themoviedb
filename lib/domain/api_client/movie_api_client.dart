import 'package:themoviedb/domain/api_client/network_client.dart';
import 'package:themoviedb/domain/configuration/configuration.dart';
import 'package:themoviedb/domain/entity/popular_movie_response.dart';
import 'package:themoviedb/domain/entity/movie_details.dart';

class MovieApiClient {
  final _networkClient = NetworkClient();

  Future<PopularMovieResponse> popularMovie({
    String language = 'en_US',
    int page = 1,
  }) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponse.fromJson(jsonMap);
      return response;
    }

    final parameters = <String, dynamic>{
      'api_key': Configuration.apiKey,
      'language': language,
      'page': page.toString(),
    };

    final result = _networkClient.get(
      '/movie/popular',
      parser,
      parameters,
    );
    return result;
  }

  Future<PopularMovieResponse> searchMovie({
    String language = 'en_US',
    required String query,
    int page = 1,
    bool includeAdult = false,
  }) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponse.fromJson(jsonMap);
      return response;
    }

    final parameters = <String, dynamic>{
      'api_key': Configuration.apiKey,
      'language': language,
      'query': query,
      'page': page.toString(),
      'include_adult': includeAdult.toString(),
    };

    final result = await _networkClient.get(
      '/search/movie',
      parser,
      parameters,
    );
    return result;
  }

  Future<MovieDetails> movieDetails(
    String language,
    int movieId,
  ) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = MovieDetails.fromJson(jsonMap);
      return response;
    }

    final parameters = {
      'api_key': Configuration.apiKey,
      'language': language,
      'append_to_response': 'credits,videos',
    };

    final result = _networkClient.get(
      '/movie/$movieId',
      parser,
      parameters,
    );
    return result;
  }

  Future<String> certification(int movieId, String iso) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final results = jsonMap['results'] as List<dynamic>;
      var certification = '';
      for (var element in results) {
        if (element['iso_3166_1'] == iso) {
          final releaseDate = element['release_dates'] as List<dynamic>;
          certification = releaseDate.first['certification'] as String;
          break;
        }
      }
      return certification;
    }

    final parameters = {
      'api_key': Configuration.apiKey,
    };

    final result = _networkClient.get(
      '/movie/$movieId/release_dates',
      parser,
      parameters,
    );
    return result;
  }
}
