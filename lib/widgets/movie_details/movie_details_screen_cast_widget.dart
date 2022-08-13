import 'package:flutter/material.dart';
import 'package:themoviedb/Theme/app_colors.dart';
import 'package:themoviedb/resources/resources.dart';

class MovieDetailsScreenCastWidget extends StatefulWidget {
  const MovieDetailsScreenCastWidget({Key? key}) : super(key: key);

  @override
  State<MovieDetailsScreenCastWidget> createState() =>
      _MovieDetailsScreenCastWidgetState();
}

class _MovieDetailsScreenCastWidgetState
    extends State<MovieDetailsScreenCastWidget> {
  final List<_PersonInfo> _people = [
    _PersonInfo(
        image: AppImages.chrisHemsworth,
        name: 'Chris Hemsworth',
        role: 'Thor Odinson'),
    _PersonInfo(
        image: AppImages.christianBale,
        name: 'Christian Bale',
        role: 'Gorr'),
    _PersonInfo(
        image: AppImages.tessaThompson,
        name: 'Tessa Thompson',
        role: 'King Valkyrie'),
    _PersonInfo(
        image: AppImages.taikaWaititi,
        name: 'Taika Waititi',
        role: 'Korg / Old Kronan God (voice)'),
    _PersonInfo(
        image: AppImages.nataliePortman,
        name: 'Natalie Portman',
        role: 'Jane Foster / The Mighty Thor'),
    _PersonInfo(
        image: AppImages.jaimieAlexander,
        name: 'Jaimie Alexander',
        role: 'Sif'),
    _PersonInfo(
        image: AppImages.russellCrowe,
        name: 'Russell Crowe',
        role: 'Zeus'),
    _PersonInfo(
        image: AppImages.chrisPratt,
        name: 'Chris Pratt',
        role: 'Peter Quill / Star-Lord'),
    _PersonInfo(
        image: AppImages.karenGillan,
        name: 'Karen Gillan',
        role: 'Nebula'),
  ];

  @override
  Widget build(BuildContext context) {
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
          height: 260,
          child: Scrollbar(
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 14),
              itemCount: _people.length,
              itemExtent: 134,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 4, top: 10, bottom: 10),
                  child: _PersonCardWidget(person: _people[index]),
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
    Key? key,
    required this.person,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        color: Colors.white,
        border: Border.all(
          color: AppColors.lightGrey
        )
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        child: Column(
          children: [
            Image(image: AssetImage(person.image)),
            Padding(
              padding: EdgeInsets.all(10),
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
  final String image;
  final String name;
  final String role;

  _PersonInfo({
    required this.image,
    required this.name,
    required this.role,
  });
}
