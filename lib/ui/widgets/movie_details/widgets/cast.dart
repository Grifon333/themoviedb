import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themoviedb/domain/api_client/image_downloader.dart';
import 'package:themoviedb/resources/resources.dart';
import 'package:themoviedb/theme/app_colors.dart';
import 'package:themoviedb/ui/widgets/movie_details/bloc/movie_details_bloc.dart';
import 'package:themoviedb/ui/widgets/movie_details/models/actor.dart';
import 'dart:math' show min;

class Cast extends StatelessWidget {
  const Cast({super.key});

  @override
  Widget build(BuildContext context) {
    final cast = context.select(
      (MovieDetailsBloc bloc) => bloc.state.movieDetails.cast,
    );
    return ListView.builder(
      padding: const EdgeInsets.only(left: 14),
      itemCount: min(cast.length, 9),
      itemExtent: 136,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 4,
            top: 10,
            bottom: 10,
          ),
          child: _ActorCard(person: cast[index]),
        );
      },
    );
  }
}

class _ActorCard extends StatelessWidget {
  final Actor person;

  const _ActorCard({
    required this.person,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        color: Colors.white,
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        child: Column(
          children: [
            person.profilePath == null
                ? const Image(
                    image: AssetImage(AppImages.userGrey),
                    width: 120,
                    height: 133,
                  )
                : Image.network(
                    ImageDownloader.makeImage(person.profilePath!),
                    width: 120,
                    height: 133,
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.center,
                  ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    person.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    person.character,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
