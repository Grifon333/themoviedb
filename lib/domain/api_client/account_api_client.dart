import 'package:themoviedb/domain/api_client/network_client.dart';
import 'package:themoviedb/domain/configuration/configuration.dart';

enum MediaType {
  movie,
  tv,
}

extension MediaTypeAsString on MediaType {
  String asString() {
    switch (this) {
      case MediaType.movie:
        return 'movie';
      case MediaType.tv:
        return 'tv';
    }
  }
}

class AccountApiClient {
  final _networkClient = NetworkClient();

  Future<int> getAccountId(String sessionId) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = jsonMap['id'] as int;
      return result;
    }

    final parameters = {
      'api_key': Configuration.apiKey,
      'session_id': sessionId,
    };

    final result = _networkClient.get('/account', parser, parameters);
    return result;
  }

  Future<bool> isFavoriteMovie(int movieId, String sessionId) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      bool result = jsonMap['favorite'] as bool;
      return result;
    }

    final parameters = {
      'api_key': Configuration.apiKey,
      'session_id': sessionId,
    };

    final result = _networkClient.get(
        '/movie/$movieId/account_states', parser, parameters);
    return result;
  }

  Future<void> markAsFavorite(
    String sessionId,
    int accountId,
    MediaType mediaType,
    int mediaId,
    bool favorite,
  ) async {
    final bodyParameters = {
      'media_type': mediaType.asString(),
      'media_id': mediaId,
      'favorite': favorite,
    };
    parser(dynamic json) {}
    final urlParameters = {
      'api_key': Configuration.apiKey,
      'session_id': sessionId,
    };

    final result = _networkClient.post(
        '/account/$accountId/favorite', bodyParameters, parser, urlParameters);
    return result;
  }
}
