import 'package:flutter/material.dart';
import 'package:themoviedb/Theme/app_colors.dart';
import 'package:themoviedb/Theme/app_text_style.dart';

import 'package:themoviedb/ui/widgets/movie_list/models/models.dart';

class MovieListItem extends StatelessWidget {
  final Movie movie;
  final String Function(String) makeImageURL;
  final void Function() onTap;

  const MovieListItem({
    super.key,
    required this.movie,
    required this.makeImageURL,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final posterPath = movie.posterPath;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(7)),
              color: AppColors.white,
              border: Border.all(
                width: 1,
                color: AppColors.lightGrey,
              ),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 2),
                  blurRadius: 8,
                  color: AppColors.lightGrey,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(7)),
              child: Row(
                children: [
                  if (posterPath != null)
                    Image.network(
                      makeImageURL(posterPath),
                      // ImageDownloader.makeImage(posterPath),
                      width: 94,
                    ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: AppTextStyle.titleFilmInCard,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            movie.releaseDate,
                            style: AppTextStyle.dateFilmInCard,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            movie.overview,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: AppTextStyle.descriptionFilmInCard,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(
                Radius.circular(7),
              ),
              onTap: onTap,
              // MainNavigation.goToMovieDetails(context, movie.id),
            ),
          ),
        ],
      ),
    );
  }
}