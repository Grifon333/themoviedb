import 'package:themoviedb/domain/api_client/network_client.dart';
import 'package:themoviedb/domain/configuration/configuration.dart';

class AuthApiClient {
  final _networkClient = NetworkClient();

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

  Future<String> _getCreateToken() async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    }

    final result = _networkClient.get(
      '/authentication/token/new',
      parser,
      <String, dynamic>{'api_key': Configuration.apiKey},
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

    final result = _networkClient.post(
      '/authentication/token/validate_with_login',
      parameters,
      parser,
      <String, dynamic>{'api_key': Configuration.apiKey},
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

    final result = _networkClient.post(
      '/authentication/session/new',
      parameters,
      parser,
      <String, dynamic>{'api_key': Configuration.apiKey},
    );
    return result;
  }
}
