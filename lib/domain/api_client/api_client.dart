import 'dart:convert';
import 'dart:io';

class ApiClient {
  final _client = HttpClient();
  final _host = 'https://api.themoviedb.org/3';
  final _apiKey = '0a2a46b5593a0978cc8e87ba34037430';

  Uri makeUri(String path, [Map<String, dynamic>? parametrs]) {
    final url = Uri.parse('$_host$path');
    if (parametrs != null) {
      return url.replace(queryParameters: parametrs);
    } else {
      return url;
    }
  }

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
    final url = makeUri(
      '/authentication/token/new',
      <String, dynamic>{'api_key': _apiKey},
    );
    final request = await _client.getUrl(url);
    final response = await request.close();
    final json = (await response.jsonDecode()) as Map<String, dynamic>;

    final token = json['request_token'] as String;
    return token;
  }

  Future<String> _createSessionWithLogin({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    final url = makeUri(
      '/authentication/token/validate_with_login',
      <String, dynamic>{'api_key': _apiKey},
    );
    final parameters = <String, dynamic>{
      'username': username,
      'password': password,
      'request_token': requestToken,
    };
    final request = await _client.postUrl(url);

    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(parameters));
    final response = await request.close();
    final json = (await response.jsonDecode()) as Map<String, dynamic>;

    final token = json['request_token'] as String;
    return token;
  }

  Future<String> _createSession({required String requestToken}) async {
    final url = makeUri(
      '/authentication/session/new',
      <String, dynamic>{'api_key': _apiKey},
    );
    final parameters = <String, dynamic>{
      'request_token': requestToken,
    };
    final request = await _client.postUrl(url);

    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(parameters));
    final response = await request.close();
    final json = (await response.jsonDecode()) as Map<String, dynamic>;

    final sessionId = json['session_id'] as String;
    return sessionId;
  }
}

extension HttpClientResponseJsonDecode on HttpClientResponse {
  Future<void> jsonDecode() async {
    return transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then<dynamic>((value) => json.decode(value));
  }
}
