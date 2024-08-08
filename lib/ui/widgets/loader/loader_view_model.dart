import 'package:flutter/material.dart';
import 'package:themoviedb/domain/repositories/auth_repository.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

class LoaderViewModel {
  final BuildContext context;
  final _authRepository = AuthRepository();

  LoaderViewModel(this.context) {
    _init();
  }

  void _init() async {
    await _checkAuth();
  }

  Future<void> _checkAuth() async {
    final authStatus = await _authRepository.status.first;
    final isAuth = (authStatus == AuthStatus.authenticated);
    final routeName = isAuth
        ? MainNavigationRouteNames.mainScreen
        : MainNavigationRouteNames.authScreen;
    if (!context.mounted) return;
    Navigator.of(context).pushReplacementNamed(routeName);
  }
}
