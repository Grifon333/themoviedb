import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/domain/data_providers/locale_data_provider.dart';
import 'package:themoviedb/domain/repositories/repositories.dart';
import 'package:themoviedb/ui/widgets/app/my_app.dart';
import 'package:themoviedb/ui/widgets/authentication/authentication.dart';
import 'package:themoviedb/ui/widgets/loader/loader_widget.dart';
import 'package:themoviedb/ui/widgets/locale/bloc/locale_bloc.dart';
import 'package:themoviedb/ui/widgets/login/login.dart';
import 'package:themoviedb/ui/widgets/main_screen/main_screen_widget.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_model.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_widget.dart';
import 'package:themoviedb/ui/widgets/movie_list/movie_list.dart';

class ScreenFactory {
  final MovieRepository _movieRepository = MovieRepository();
  final UserRepository _userRepository = UserRepository();
  final LocaleDataProvider _localeDataProvider = LocaleDataProvider();

  Widget makeAppScreen() {
    final authenticationRepository = AuthenticationRepository();
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        lazy: false,
        create: (_) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
          userRepository: _userRepository,
        )..add(AuthenticationSubscriptionRequestEvent()),
        child: const MyApp(),
      ),
    );
  }

  Widget makeLoaderScreen(BuildContext context) {
    final Locale locale = Localizations.localeOf(context);
    return BlocProvider(
      lazy: false,
      create: (_) => LocaleBloc(
        localeDataProvider: _localeDataProvider,
      )..add(LocaleSetupLocale(
          localeTag: locale.toLanguageTag(),
          countryCode: locale.countryCode ?? 'US',
        )),
      child: const LoaderWidget(),
    );
  }

  Widget makeLoginScreen(BuildContext context) {
    final authenticationRepository =
        RepositoryProvider.of<AuthenticationRepository>(context);
    return BlocProvider(
      create: (_) => LoginBloc(
        authenticationRepository: authenticationRepository,
      ),
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
    return BlocProvider(
      create: (_) => MovieListBloc(
        movieRepository: _movieRepository,
        localeDataProvider: _localeDataProvider,
      )..add(MovieListFetched()),
      child: const MovieListWidget(),
    );
  }
}
