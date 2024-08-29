import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/theme/app_text_style.dart';
import 'package:themoviedb/ui/widgets/movie_details/bloc/movie_details_bloc.dart';

class MovieTitle extends StatelessWidget {
  const MovieTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final data =
    context.select((MovieDetailsBloc bloc) => bloc.state.movieDetails);
    final year = data.year;
    final title = data.title;

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: AppTextStyle.titleMovie,
          ),
          TextSpan(
            text: year,
            style: AppTextStyle.foundationYear,
          ),
        ],
      ),
    );
  }
}