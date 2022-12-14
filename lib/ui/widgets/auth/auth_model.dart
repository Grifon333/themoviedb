import 'package:flutter/material.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

class AuthModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _sessionDataProvider = SessionDataProvider();
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();

  String? _errorMessage;
  bool _isAuthProgress = false;

  String? get errorMessage => _errorMessage;
  bool get canStartAuth => !_isAuthProgress;

  // We couldn\'t validate your information.\n   Want to try again?
  // We couldn\'t find your username

  Future<void> auth(BuildContext context) async {
    final username = controllerUsername.text;
    final password = controllerPassword.text;
    if (username.isEmpty || password.isEmpty) {
      _errorMessage = 'Fill all fields';
      notifyListeners();
      return;
    }
    _errorMessage = null;
    _isAuthProgress = true;
    notifyListeners();

    String? sessionId;
    int? accountId;
    try {
      sessionId = await _apiClient.auth(
        username: username,
        password: password,
      );
      accountId = await _apiClient.getAccountId(sessionId);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.network:
          _errorMessage =
              'Server isn\'t available. Check your Internet connection';
          break;
        case ApiClientExceptionType.auth:
          _errorMessage = 'Enter the correct password and/or login';
          break;
        case ApiClientExceptionType.other:
          _errorMessage = 'There was an error. Try again';
          break;
      }
    }
    _isAuthProgress = false;

    if (_errorMessage != null) {
      notifyListeners();
      return;
    }
    if (sessionId == null || accountId == null) {
      _errorMessage = 'Error';
      notifyListeners();
      return;
    }

    await _sessionDataProvider.setSessionId(sessionId);
    await _sessionDataProvider.setAccountId(accountId);
    Navigator.of(context)
        .pushReplacementNamed(MainNavigationRouteNames.mainScreen);
  }
}
