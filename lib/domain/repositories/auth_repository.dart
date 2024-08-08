import 'dart:async';

import 'package:themoviedb/domain/api_client/account_api_client.dart';
import 'package:themoviedb/domain/api_client/auth_api_client.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthRepository {
  final _sessionDataProvider = SessionDataProvider();
  final _authApiClient = AuthApiClient();
  final _accountApiClient = AccountApiClient();
  final _controller = StreamController<AuthStatus>();

  Stream<AuthStatus> get status async* {
    await Future.delayed(const Duration(seconds: 1));
    final sessionId = await _sessionDataProvider.getSessionId();
    yield sessionId == null
        ? AuthStatus.unauthenticated
        : AuthStatus.authenticated;
    yield* _controller.stream;
  }

  Future<void> logIn(String username, String password) async {
    final sessionId = await _authApiClient.auth(
      username: username,
      password: password,
    );
    final accountId = await _accountApiClient.getAccountId(sessionId);
    await _sessionDataProvider.setSessionId(sessionId);
    await _sessionDataProvider.setAccountId(accountId);
    _controller.add(AuthStatus.authenticated);
  }

  Future<void> logOut() async {
    await _sessionDataProvider.deleteAccountId();
    await _sessionDataProvider.deleteSessionId();
    _controller.add(AuthStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
