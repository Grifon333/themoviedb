import 'package:flutter/material.dart';
import 'package:themoviedb/Library/Widgets/Inherited/provider.dart';
import 'package:themoviedb/Theme/app_colors.dart';
import 'package:themoviedb/domain/api_client/image_downloader.dart';
import 'package:themoviedb/resources/resources.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_model.dart';

class MovieDetailsScreenCastWidget extends StatelessWidget {
  const MovieDetailsScreenCastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final cast = model?.movieDetails?.credits.cast;
    if (cast == null) return const SizedBox.shrink();

    List<_PersonInfo> people = [];
    people = cast.map((e) {
      final profilePath = e.profilePath != null
          ? Image.network(
              ImageDownloader.makeImage(e.profilePath ?? ''),
              width: 120,
              height: 133,
              fit: BoxFit.fitWidth,
              alignment: Alignment.center,
            )
          : const Image(
              image: AssetImage(AppImages.userGrey),
              height: 133,
              width: 120,
            );
      return _PersonInfo(
        image: profilePath,
        name: e.name,
        role: e.character,
      );
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'Top Billed Cast',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          height: 300,
          child: Scrollbar(
            thickness: 7,
            radius: const Radius.circular(4),
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 14),
              itemCount: people.length > 9 ? 9 : people.length,
              itemExtent: 136,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 4, top: 10, bottom: 10),
                  child: _PersonCardWidget(person: people[index]),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}

class _PersonCardWidget extends StatelessWidget {
  final _PersonInfo person;

  const _PersonCardWidget({
    required this.person,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          color: Colors.white,
          border: Border.all(color: AppColors.lightGrey)),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        child: Column(
          children: [
            person.image,
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    person.name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    person.role,
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

class _PersonInfo {
  final Image image;
  final String name;
  final String role;

  _PersonInfo({
    required this.image,
    required this.name,
    required this.role,
  });
}
