import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/Library/Widgets/Inherited/provider.dart'
    as old_provider;
import 'package:themoviedb/ui/widgets/auth/auth_view_model.dart';
import 'package:themoviedb/ui/widgets/auth/auth_widget.dart';
import 'package:themoviedb/ui/widgets/loader/loader_view_model.dart';
import 'package:themoviedb/ui/widgets/loader/loader_widget.dart';
import 'package:themoviedb/ui/widgets/main_screen/main_screen_widget.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_model.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_widget.dart';
import 'package:themoviedb/ui/widgets/movie_list/movie_list_view_model.dart';
import 'package:themoviedb/ui/widgets/movie_list/movie_list_widget.dart';

class ScreenFactory {
  Widget makeLoaderScreen() {
    return Provider(
      create: (context) => LoaderViewModel(context),
      lazy: false,
      child: const LoaderWidget(),
    );
  }

  Widget makeAuthScreen() {
    return ChangeNotifierProvider(
      create: (context) => AuthViewModel(context),
      child: const AuthWidget(),
    );
  }

  Widget makeMainScreen() {
    return const MainScreenWidget();
  }

  Widget makeMovieDetailsScreen(int movieId) {
    return old_provider.NotifierProvider(
      child: const MovieDetailsWidget(),
      create: () => MovieDetailsModel(movieId: movieId),
    );
  }

  Widget makeMovieListScreen() {
    return ChangeNotifierProvider(
      create: (context) => MovieListViewModel(),
      child: const MovieListWidget(),
    );
  }
}
