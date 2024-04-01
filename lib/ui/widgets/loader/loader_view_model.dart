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
    final isAuth = await _authRepository.isAuth();
    if (!context.mounted) return;
    final routeName = isAuth
        ? MainNavigationRouteNames.mainScreen
        : MainNavigationRouteNames.authScreen;
    Navigator.of(context).pushReplacementNamed(routeName);
  }
}
