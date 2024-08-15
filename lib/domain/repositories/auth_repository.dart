import 'dart:async';

import 'package:themoviedb/domain/api_client/account_api_client.dart';
import 'package:themoviedb/domain/api_client/auth_api_client.dart';
import 'package:themoviedb/domain/data_providers/user_data_provider.dart';
import 'package:themoviedb/domain/entity/user.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _userDataProvider = UserDataProvider();
  final _authApiClient = AuthApiClient();
  final _accountApiClient = AccountApiClient();
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    final user = await _userDataProvider.getUser();
    final sessionId = user?.sessionId;
    yield sessionId == null
        ? AuthenticationStatus.unauthenticated
        : AuthenticationStatus.authenticated;
    yield* _controller.stream;
  }

  Future<void> logIn(String username, String password) async {
    final sessionId = await _authApiClient.auth(
      username: username,
      password: password,
    );
    final accountId = await _accountApiClient.getAccountId(sessionId);
    await _userDataProvider.setUser(User(
      sessionId: sessionId,
      accountId: accountId,
    ));
    _controller.add(AuthenticationStatus.authenticated);
  }

  Future<void> logOut() async {
    await _userDataProvider.deleteUser();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
