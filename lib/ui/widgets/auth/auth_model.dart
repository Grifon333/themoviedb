import 'package:flutter/material.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

class AuthModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _sessionDataProvider = SessionDataProvider();
  final controllerUsername = TextEditingController(text: 'jonfir');
  final controllerPassword = TextEditingController(text: 'P61{fSf?E{_u');

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  bool _isAuthProgress = false;

  bool get canStartAuth => !_isAuthProgress;

  // We couldn\'t validate your information.\n   Want to try again?
  // We couldn\'t find your username

  Future<void> auth(BuildContext context) async {
    // jonfir
    // P61{fSf?E{_u
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
    try {
      sessionId = await _apiClient.auth(
          username: username, password: password);
    } catch (e) {
      _errorMessage = 'Invalid';
    }
    _isAuthProgress = false;

    if (_errorMessage != null) {
      notifyListeners();
      return;
    }
    if (sessionId == null) {
      _errorMessage = 'Error';
      notifyListeners();
      return;
    }

    await _sessionDataProvider.setSessionId(sessionId);
    Navigator.of(context).pushReplacementNamed(MainNavigationRouteNames.mainScreen);
  }
}