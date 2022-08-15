import 'package:flutter/material.dart';
import 'package:themoviedb/Theme/app_colors.dart';
import 'package:themoviedb/widgets/auth/auth_widget.dart';
import 'package:themoviedb/widgets/auth/auth_widget_model.dart';
import 'package:themoviedb/widgets/main_screen/main_screen_widget.dart';
import 'package:themoviedb/widgets/movie_details/movie_details_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.darkBlue,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.darkBlue,
          selectedItemColor: AppColors.selectedTab,
          unselectedItemColor: AppColors.unselectedTab,
        ),
      ),
      routes: {
        '/': (context) => AuthWidgetProvider(
              model: AuthWidgetModel(),
              child: const AuthWidget(),
            ),
        '/main_screen': (context) => const MainScreenWidget(),
        // '/main_screen/movie_details': (context) => const MovieDetailsWidget(),
      },
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/main_screen/movie_details':
            final movieId = settings.arguments as int;
            return MaterialPageRoute<Object>(
                builder: (context) => MovieDetailsWidget(movieId: movieId));
          default:
            return MaterialPageRoute<Object>(
                builder: (context) => const Text('error'));
        }
      },
      initialRoute: '/',
    );
  }
}
