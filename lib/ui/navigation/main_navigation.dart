import 'package:flutter/material.dart';
import 'package:themoviedb/domain/factories/screen_factory.dart';

abstract class MainNavigationRouteNames {
  static const loaderScreen = '/';
  static const authScreen = '/auth';
  static const mainScreen = '/main_screen';
  static const movieDetails = '/main_screen/movie_details';
}

class MainNavigation {
  static final _screenFactory = ScreenFactory();

  final routes = <String, WidgetBuilder>{
    MainNavigationRouteNames.loaderScreen: (_) =>
        _screenFactory.makeLoaderScreen(),
    MainNavigationRouteNames.authScreen: (_) => _screenFactory.makeAuthScreen(),
    MainNavigationRouteNames.mainScreen: (_) => _screenFactory.makeMainScreen(),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.movieDetails:
        final arguments = settings.arguments;
        final movieId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
          builder: (context) => _screenFactory.makeMovieDetailsScreen(movieId),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('Navigation error'),
            ),
          ),
        );
    }
  }
}
