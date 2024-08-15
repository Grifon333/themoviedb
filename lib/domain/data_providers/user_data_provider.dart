import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:themoviedb/domain/entity/user.dart';

class _Keys {
  static const user = 'user';
}

class UserDataProvider {
  static const _storage = FlutterSecureStorage();

  Future<User?> getUser() async {
    String? jsonUser = await _storage.read(key: _Keys.user);
    if (jsonUser == null) return null;
    return User.fromMap(jsonDecode(jsonUser));
  }

  Future<void> setUser(User user) async {
    await _storage.write(
      key: _Keys.user,
      value: jsonEncode(user.toMap()),
    );
  }

  Future<void> setSessionId(String sessionId) async {
    User user = await getUser() ?? const User(sessionId: '', accountId: 0)
      ..copyWith(sessionId: sessionId);
    await setUser(user);
  }

  Future<void> setAccountId(int accountId) async {
    User user = await getUser() ?? const User(sessionId: '', accountId: 0)
      ..copyWith(accountId: accountId);
    await setUser(user);
  }

  Future<void> deleteUser() async {
    await _storage.delete(key: _Keys.user);
  }
}
