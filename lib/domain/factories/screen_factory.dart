import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/domain/repositories/auth_repository.dart';
import 'package:themoviedb/domain/repositories/user_repository.dart';
import 'package:themoviedb/ui/widgets/authentication/authentication.dart';
import 'package:themoviedb/ui/widgets/loader/loader_widget.dart';
import 'package:themoviedb/ui/widgets/login/login.dart';
import 'package:themoviedb/ui/widgets/main_screen/main_screen_widget.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_model.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_widget.dart';
import 'package:themoviedb/ui/widgets/movie_list/movie_list_view_model.dart';
import 'package:themoviedb/ui/widgets/movie_list/movie_list_widget.dart';

class ScreenFactory {
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();
  final UserRepository _userRepository = UserRepository();

  Widget makeLoaderScreen() {
    return BlocProvider(
      create: (_) => AuthenticationBloc(
        authenticationRepository: _authenticationRepository,
        userRepository: _userRepository,
      )..add(AuthenticationSubscriptionRequestEvent()),
      lazy: false,
      child: LoaderWidget(
        authenticated: makeMainScreen(),
        unauthenticated: makeLoginScreen(),
      ),
    );
  }

  Widget makeLoginScreen() {
    return BlocProvider(
      create: (_) =>
          LoginBloc(authenticationRepository: _authenticationRepository),
      child: const LoginWidget(),
    );
  }

  Widget makeMainScreen() {
    return const MainScreenWidget();
  }

  Widget makeMovieDetailsScreen(int movieId) {
    return ChangeNotifierProvider(
      child: const MovieDetailsWidget(),
      create: (context) => MovieDetailsModel(context, movieId: movieId),
    );
  }

  Widget makeMovieListScreen() {
    return ChangeNotifierProvider(
      create: (context) => MovieListViewModel(),
      child: const MovieListWidget(),
    );
  }
}
