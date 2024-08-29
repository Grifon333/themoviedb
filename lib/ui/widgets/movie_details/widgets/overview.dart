import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themoviedb/theme/app_text_style.dart';
import 'package:themoviedb/ui/widgets/movie_details/bloc/movie_details_bloc.dart';

class Overview extends StatelessWidget {
  const Overview({super.key});

  @override
  Widget build(BuildContext context) {
    final overview = context
        .select((MovieDetailsBloc bloc) => bloc.state.movieDetails.overview);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Tagline(),
        const SizedBox(height: 10),
        const Text(
          'Overview',
          style: AppTextStyle.overviewTitle,
        ),
        const SizedBox(height: 8),
        Text(
          overview,
          style: AppTextStyle.overviewBody,
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}

class _Tagline extends StatelessWidget {
  const _Tagline();

  @override
  Widget build(BuildContext context) {
    final tagLine = context
        .select((MovieDetailsBloc bloc) => bloc.state.movieDetails.tagLine);
    if (tagLine == null) return const SizedBox.shrink();

    return Text(
      tagLine,
      style: TextStyle(
        fontSize: 17,
        fontStyle: FontStyle.italic,
        color: Colors.white.withOpacity(0.6),
      ),
    );
  }
}