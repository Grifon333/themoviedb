import 'package:flutter/material.dart';
import 'package:themoviedb/domain/factories/screen_factory.dart';

abstract class MainNavigationRouteNames {
  static const loaderScreen = '/';
  static const loginScreen = '/auth';
  static const mainScreen = '/main_screen';
  static const movieDetails = '/main_screen/movie_details';
}

class MainNavigation {
  static final _screenFactory = ScreenFactory();
  final GlobalKey<NavigatorState> _navigatorKey;

  NavigatorState get _navigator => _navigatorKey.currentState!;

  MainNavigation({
    required GlobalKey<NavigatorState> navigatorKey,
  }) : _navigatorKey = navigatorKey;

  final routes = <String, WidgetBuilder>{
    MainNavigationRouteNames.loaderScreen: (context) =>
        _screenFactory.makeLoaderScreen(context),
    MainNavigationRouteNames.loginScreen: (context) =>
        _screenFactory.makeLoginScreen(context),
    MainNavigationRouteNames.mainScreen: (_) => _screenFactory.makeMainScreen(),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.movieDetails:
        final arguments = settings.arguments;
        final movieId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeMovieDetailsScreen(movieId),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => _screenFactory.makeLoaderScreen(context),
        );
    }
  }

  static void goToMovieDetails(BuildContext context, int id) {
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.movieDetails,
      arguments: id,
    );
  }

  void goToLogin(BuildContext context) {
    _navigator.pushNamedAndRemoveUntil(
      MainNavigationRouteNames.loginScreen,
      (route) => false,
    );
  }

  void goToMainScreen(BuildContext context) {
    _navigator.pushNamedAndRemoveUntil(
      MainNavigationRouteNames.mainScreen,
      (route) => false,
    );
  }
}
