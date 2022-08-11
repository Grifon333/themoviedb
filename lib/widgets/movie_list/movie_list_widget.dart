import 'package:flutter/material.dart';
import 'package:themoviedb/Theme/app_colors.dart';
import 'package:themoviedb/resources/resources.dart';

class MovieListWidget extends StatelessWidget {
  const MovieListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: 20,
          itemExtent: 140,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(7)),
                      color: Colors.white,
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
                          const Image(
                            image: AssetImage(AppImages.thorLoveAndThunder),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Thor: Love and Thunder',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'July 6, 2022',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color.fromRGBO(153, 153, 153, 1),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    'After his retirement is interrupted by Gorr the '
                                    'God Butcher, a galactic killer who seeks the '
                                    'extinction of the gods, Thor enlists the help of '
                                    'King Valkyrie, Korg, and ex-girlfriend Jane Foster,'
                                    ' who now inexplicably wields Mjolnir as the Mighty '
                                    'Thor. Together they embark upon a harrowing cosmic '
                                    'adventure to uncover the mystery of the God '
                                    'Butcher’s vengeance and stop him before it’s too '
                                    'late.',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(fontSize: 14),
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
                      onTap: () {
                        print('Tap on Card');
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
