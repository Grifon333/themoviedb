import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themoviedb/ui/widgets/movie_details/bloc/movie_details_bloc.dart';

class AppbarTitle extends StatelessWidget {
  const AppbarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(context.select((MovieDetailsBloc bloc) => bloc.state.title));
  }
}
