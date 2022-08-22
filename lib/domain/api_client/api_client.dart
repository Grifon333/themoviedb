import 'dart:convert';
import 'dart:io';

import 'package:themoviedb/domain/entity/popular_movie_response.dart';
import 'package:themoviedb/domain/entity/movie_details.dart';

enum ApiClientExceptionType { Network, Auth, Other }

class ApiClientException implements Exception {
  final ApiClientExceptionType type;

  ApiClientException(this.type);
}

/*
Status code:
7 - Invalid API key: You must be granted a valid key
30 - Invalid username and/or password: You did not provide a valid login.
33 - Invalid request token: The request token is either expired or invalid
34 - The resource you requested could not be found
*/

class ApiClient {
  final _client = HttpClient();
  final _host = 'https://api.themoviedb.org/3';
  static const _imageUrl = 'https://image.tmdb.org/t/p/w500';
  final _apiKey = '0a2a46b5593a0978cc8e87ba34037430';

  Uri makeUri(String path, [Map<String, dynamic>? parameters]) {
    final url = Uri.parse('$_host$path');
    if (parameters != null) {
      return url.replace(queryParameters: parameters);
    } else {
      return url;
    }
  }

  static String makeImage(String path) => _imageUrl + path;

  Future<String> auth({
    required String username,
    required String password,
  }) async {
    final token = await _getCreateToken();
    final validateToken = await _createSessionWithLogin(
      username: username,
      password: password,
      requestToken: token,
    );
    final sessionId = await _createSession(requestToken: validateToken);
    return sessionId;
  }

  Future<T> _get<T>(
    String path,
    T Function(dynamic json) parser, [
    Map<String, dynamic>? parameters,
  ]) async {
    final url = makeUri(path, parameters);
    try {
      final request = await _client.getUrl(url);
      final response = await request.close();
      final dynamic json = (await response.jsonDecode());
      _validateResponse(response, json);
      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.Network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.Other);
    }
  }

  Future<T> _post<T>(
    String path,
    Map<String, dynamic> bodyParameters,
    T Function(dynamic json) parser, [
    Map<String, dynamic>? urlParameters,
  ]) async {
    try {
      final url = makeUri(path, urlParameters);
      final request = await _client.postUrl(url);
      request.headers.contentType = ContentType.json;
      request.write(jsonEncode(bodyParameters));
      final response = await request.close();
      final dynamic json = (await response.jsonDecode());
      _validateResponse(response, json);
      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.Network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.Other);
    }
  }

  Future<String> _getCreateToken() async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    }

    final result = _get(
      '/authentication/token/new',
      parser,
      <String, dynamic>{'api_key': _apiKey},
    );
    return result;
  }

  Future<String> _createSessionWithLogin({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    final parameters = <String, dynamic>{
      'username': username,
      'password': password,
      'request_token': requestToken,
    };
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    }

    final result = _post(
      '/authentication/token/validate_with_login',
      parameters,
      parser,
      <String, dynamic>{'api_key': _apiKey},
    );
    return result;
  }

  Future<String> _createSession({required String requestToken}) async {
    final parameters = <String, dynamic>{
      'request_token': requestToken,
    };
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final sessionId = jsonMap['session_id'] as String;
      return sessionId;
    }

    final result = _post(
      '/authentication/session/new',
      parameters,
      parser,
      <String, dynamic>{'api_key': _apiKey},
    );
    return result;
  }

  void _validateResponse(HttpClientResponse response, dynamic json) {
    if (response.statusCode == 401) {
      final dynamic status = json['status_code'];
      final code = status is int ? status : 0;
      if (code == 30) {
        throw ApiClientException(ApiClientExceptionType.Auth);
      } else {
        throw ApiClientException(ApiClientExceptionType.Other);
      }
    }
  }

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
      'api_key': _apiKey,
      'language': language,
      'page': page.toString(),
    };

    final result = _get(
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
      'api_key': _apiKey,
      'language': language,
      'query': query,
      'page': page.toString(),
      'include_adult': includeAdult.toString(),
    };

    final result = await _get(
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
      'api_key': _apiKey,
      'language': language,
    };

    final result = _get(
      '/movie/$movieId',
      parser,
      parameters,
    );
    return result;
  }
}

extension HttpClientResponseJsonDecode on HttpClientResponse {
  Future<dynamic> jsonDecode() async {
    return transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then<dynamic>((value) => json.decode(value));
  }
}
