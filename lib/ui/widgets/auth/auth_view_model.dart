import 'package:flutter/material.dart';
import 'package:themoviedb/domain/api_client/api_client_exception.dart';
import 'package:themoviedb/domain/repositories/auth_repository.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

class AuthViewModelState {
  String username = '';
  String password = '';
  String? errorMessage;
  bool isAuthProgress = false;
}

class AuthViewModel extends ChangeNotifier {
  final BuildContext context;
  final _authRepository = AuthRepository();
  final AuthViewModelState _state = AuthViewModelState();

  AuthViewModelState get state => _state;

  AuthViewModel(this.context);

  void onChangeUsername(String value) {
    _state.username = value;
  }

  void onChangePassword(String value) {
    _state.password = value;
  }

  Future<void> auth() async {
    final username = _state.username;
    final password = _state.password;

    if (username.isEmpty || password.isEmpty) {
      _updateState('Fill all fields', false);
      return;
    }
    _updateState(null, true);

    _updateState(await _login(username, password), false);
    if (_state.errorMessage != null) return;

    if (!context.mounted) return;
    MainNavigation.goLoader(context);
  }

  Future<String?> _login(String username, String password) async {
    try {
      await _authRepository.login(username, password);
      return null;
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.network:
          return 'Server isn\'t available. Check your Internet connection';
        case ApiClientExceptionType.auth:
          return 'Enter the correct password and/or login';
        case ApiClientExceptionType.other:
          return 'There was an error. Try again';
        case ApiClientExceptionType.sessionExpired:
          return 'Try later.';
      }
    } catch (e) {
      return 'Try later.';
    }
  }

  void _updateState(
    String? errorMessage,
    bool isAuthProgress,
  ) {
    if (errorMessage == _state.errorMessage &&
        isAuthProgress == _state.isAuthProgress) return;
    _state.errorMessage = errorMessage;
    _state.isAuthProgress = isAuthProgress;
    notifyListeners();
  }
}
