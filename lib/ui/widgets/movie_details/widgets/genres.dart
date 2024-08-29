import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themoviedb/theme/app_colors.dart';
import 'package:themoviedb/theme/app_text_style.dart';
import 'package:themoviedb/ui/widgets/movie_details/bloc/movie_details_bloc.dart';

class Genres extends StatelessWidget {
  const Genres({super.key});

  @override
  Widget build(BuildContext context) {
    final data =
        context.select((MovieDetailsBloc bloc) => bloc.state.movieDetails);
    final certification = data.certification;
    final releaseDate = data.releaseDate;
    final productionCountry = data.productionCountry;
    final runtime = data.runtime;
    final genres = data.genres;

    const divider = Divider(
      height: 0,
      thickness: 1,
      color: AppColors.divider,
    );

    return Column(
      children: [
        divider,
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: double.infinity),
          child: ColoredBox(
            color: AppColors.facts,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: ' $certification ',
                      style: certification != ''
                          ? AppTextStyle.certification
                          : AppTextStyle.facts,
                    ),
                    TextSpan(
                      text:
                          '  $releaseDate ($productionCountry) • $runtime \n$genres',
                      style: AppTextStyle.facts,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        divider,
      ],
    );
  }
}
