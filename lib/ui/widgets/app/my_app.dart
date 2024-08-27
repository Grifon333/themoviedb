import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themoviedb/domain/configuration/app_locale.dart';
import 'package:themoviedb/domain/repositories/auth_repository.dart';
import 'package:themoviedb/theme/main_theme_data.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';
import 'package:themoviedb/ui/widgets/authentication/authentication.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final MainNavigation _mainNavigation;
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    _mainNavigation = MainNavigation(navigatorKey: _navigatorKey);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: _navigatorKey,
      theme: mainThemeData,
      routes: _mainNavigation.routes,
      onGenerateRoute: _mainNavigation.onGenerateRoute,
      localizationsDelegates: AppLocale.localizationsDelegates,
      supportedLocales: AppLocale.supportedLocales,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _mainNavigation.goToMainScreen(context);
              case AuthenticationStatus.unauthenticated:
                _mainNavigation.goToLogin(context);
              case AuthenticationStatus.unknown:
                break;
            }
          },
          child: child,
        );
      },
    );
  }
}
