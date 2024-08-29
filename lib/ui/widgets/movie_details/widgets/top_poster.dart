import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themoviedb/domain/api_client/image_downloader.dart';
import 'package:themoviedb/ui/widgets/movie_details/bloc/movie_details_bloc.dart';

class TopPoster extends StatelessWidget {
  const TopPoster({super.key});

  @override
  Widget build(BuildContext context) {
    final data =
        context.select((MovieDetailsBloc bloc) => bloc.state.movieDetails);
    final backdropPath = data.backdropPath;
    final posterPath = data.posterPath;
    if (backdropPath == null || posterPath == null) {
      return const SizedBox.shrink();
    }

    return AspectRatio(
      aspectRatio: 392.7 / 220.7,
      child: Stack(
        children: [
          Image.network(
            ImageDownloader.makeImage(backdropPath),
            fit: BoxFit.fitWidth,
          ),
          Positioned(
            top: 20,
            bottom: 20,
            left: 20,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              child: Image.network(
                ImageDownloader.makeImage(posterPath),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
