import 'package:flutter/material.dart';
import 'package:themoviedb/Theme/app_colors.dart';
import 'package:themoviedb/Theme/app_text_style.dart';
import 'package:themoviedb/resources/resources.dart';

class Movie {
  final int id;
  final String imageName;
  final String title;
  final String date;
  final String description;

  Movie({
    required this.id,
    required this.imageName,
    required this.title,
    required this.date,
    required this.description,
  });
}

class MovieListWidget extends StatefulWidget {
  MovieListWidget({Key? key}) : super(key: key);

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  final _movies = [
    Movie(
      id: 1,
      imageName: AppImages.thorLoveAndThunder,
      title: 'Thor: Love and Thunder',
      date: 'July 6, 2022',
      description: 'After his retirement is interrupted by Gorr the God '
          'Butcher, a galactic killer who seeks the extinction of the gods, '
          'Thor enlists the help of King Valkyrie, Korg, and ex-girlfriend '
          'Jane Foster, who now inexplicably wields Mjolnir as the Mighty Thor. '
          'Together they embark upon a harrowing cosmic adventure to uncover '
          'the mystery of the God Butcher’s vengeance and stop him before it’s '
          'too late.',
    ),
    Movie(
      id: 2,
      imageName: AppImages.jurassicWorldDominion,
      title: 'Jurassic World Dominion',
      date: 'June 1, 2022',
      description: 'Four years after Isla Nublar was destroyed, dinosaurs now '
          'live—and hunt—alongside humans all over the world. This fragile '
          'balance will reshape the future and determine, once and for all, '
          'whether human beings are to remain the apex predators on a planet '
          'they now share with history’s most fearsome creatures.',
    ),
    Movie(
      id: 3,
      imageName: AppImages.minionsTheRiseOfGru,
      title: 'Minions: The Rise of Gru',
      date: 'June 29, 2022',
      description: 'A fanboy of a supervillain supergroup known as the Vicious '
          '6, Gru hatches a plan to become evil enough to join them, with the '
          'backup of his followers, the Minions.',
    ),
    Movie(
      id: 4,
      imageName: AppImages.topGunMaverick,
      title: 'Top Gun: Maverick',
      date: 'May 24, 2022',
      description: 'After more than thirty years of service as one of the '
          'Navy’s top aviators, and dodging the advancement in rank that would '
          'ground him, Pete “Maverick” Mitchell finds himself training a '
          'detachment of TOP GUN graduates for a specialized mission the likes '
          'of which no living pilot has ever seen.',
    ),
    Movie(
      id: 5,
      imageName: AppImages.prey,
      title: 'Prey',
      date: 'August 2, 2022',
      description: 'When danger threatens her camp, the fierce and highly '
          'skilled Comanche warrior Naru sets out to protect her people. But '
          'the prey she stalks turns out to be a highly evolved alien predator '
          'with a technically advanced arsenal.',
    ),
    Movie(
      id: 6,
      imageName: AppImages.theBlackPhone,
      title: 'The Black Phone',
      date: 'June 22, 2022',
      description: 'Finney Shaw, a shy but clever 13-year-old boy, is abducted '
          'by a sadistic killer and trapped in a soundproof basement where '
          'screaming is of little use. When a disconnected phone on the wall '
          'begins to ring, Finney discovers that he can hear the voices of the '
          'killer’s previous victims. And they are dead set on making sure that '
          'what happened to them doesn’t happen to Finney.',
    ),
    Movie(
      id: 7,
      imageName: AppImages.lightyear,
      title: 'Lightyear',
      date: 'June 15, 2022',
      description: 'Legendary Space Ranger Buzz Lightyear embarks on an '
          'intergalactic adventure alongside a group of ambitious recruits and '
          'his robot companion Sox.',
    ),
    Movie(
      id: 8,
      imageName: AppImages.doctorStrangeInTheMultiverseOfMadness,
      title: 'Doctor Strange in the Multiverse of Madness',
      date: 'May 4, 2022',
      description: 'Doctor Strange, with the help of mystical allies both old '
          'and new, traverses the mind-bending and dangerous alternate '
          'realities of the Multiverse to confront a mysterious new adversary.',
    ),
    Movie(
      id: 9,
      imageName: AppImages.theGrayMan,
      title: 'The Gray Man',
      date: 'July 13, 2022',
      description: 'Doctor Strange, with the help of mystical allies both old '
          'and new, traverses the mind-bending and dangerous alternate '
          'realities of the Multiverse to confront a mysterious new adversary.',
    ),
    Movie(
      id: 10,
      imageName: AppImages.purpleHearts,
      title: 'Purple Hearts',
      date: 'July 29, 2022',
      description: 'An aspiring musician agrees to a marriage of convenience '
          'with a soon-to-deploy Marine, but a tragedy soon turns their fake '
          'relationship all too real.',
    ),
    Movie(
      id: 11,
      imageName: AppImages.thePrincess,
      title: 'The Princess',
      date: 'June 16, 2022',
      description: 'A beautiful, strong-willed young royal refuses to wed the '
          'cruel sociopath to whom she is betrothed and is kidnapped and '
          'locked in a remote tower of her father’s castle. With her scorned, '
          'vindictive suitor intent on taking her father’s throne, the princess '
          'must protect her family and save the kingdom.',
    ),
    Movie(
      id: 12,
      imageName: AppImages.dragonKnight,
      title: 'Dragoon Knight',
      date: 'March 21, 2022',
      description:
          'Many years after the war has been lost, and all the dragons '
          'slain, a lone knight travels the lands of Agonos seeking to raise an '
          'army against the demon lord Abaddon. When a healer\'s vision reveals '
          'that one dragon still lives, and together with an eager young '
          'squire, the knight sets off in search of the fabled creature. As the '
          'armies of Abaddon descend on the human kingdoms, the dragon is their '
          'last hope of fending off the horde, before it lays waste to the '
          'lands of men. But does the creature even exist? And if it does, will '
          'it fight for them once more?',
    ),
    Movie(
      id: 13,
      imageName: AppImages.theLedge,
      title: 'The ledge',
      date: 'February 18, 2022',
      description: 'A rock climbing adventure between two friends turns into a '
          'terrifying nightmare. After Kelly captures the murder of her best '
          'friend on camera, she becomes the next target of a tight-knit group '
          'of friends who will stop at nothing to destroy the evidence and '
          'anyone in their way. Desperate for her safety, she begins a '
          'treacherous climb up a mountain cliff and her survival instincts are '
          'put to the test when she becomes trapped with the killers just 20 '
          'feet away.',
    ),
    Movie(
      id: 14,
      imageName: AppImages.spiderManNoWayHome,
      title: 'Spider-Man: No Way Home',
      date: 'December 15, 2021',
      description:
          'Peter Parker is unmasked and no longer able to separate his '
          'normal life from the high-stakes of being a super-hero. When he asks '
          'for help from Doctor Strange the stakes become even more dangerous, '
          'forcing him to discover what it truly means to be Spider-Man.',
    ),
    Movie(
      id: 15,
      imageName: AppImages.indemnity,
      title: 'Indemnity',
      date: 'February 11, 2022',
      description: 'An ex-fireman with PTSD goes on the run when accused of a '
          'crime he doesn\'t even remember committing, leading him down a '
          'rabbit hole of conspiracy to the highest degree.',
    ),
    Movie(
      id: 16,
      imageName: AppImages.borrego,
      title: 'Borrego',
      date: 'January 14, 2022',
      description: 'A young botanist relocates to a small desert town to study '
          'an invasive plant species. While out on research, she comes to the '
          'aid of a downed plane only to find herself taken captive by an '
          'inexperienced drug mule who forces her to lead a trek across the '
          'sweltering desert to his drop. A local sheriff is drawn into the '
          'hunt as his rebellious daughter sets out to find the missing '
          'botanist, all the while being pursued by a local drug receiver.',
    ),
    Movie(
      id: 17,
      imageName: AppImages.lastSeenAlive,
      title: 'Last Seen Alive',
      date: 'May 19, 2022',
      description: 'After Will Spann\'s wife suddenly vanishes at a gas '
          'station, his desperate search to find her leads him down a dark path '
          'that forces him to run from authorities and take the law into his '
          'own hands.',
    ),
    Movie(
      id: 18,
      imageName: AppImages.sonicTheHedgehog2,
      title: 'Sonic the Hedgehog 2',
      date: 'March 30, 2022',
      description: 'After settling in Green Hills, Sonic is eager to prove he '
          'has what it takes to be a true hero. His test comes when Dr. '
          'Robotnik returns, this time with a new partner, Knuckles, in search '
          'for an emerald that has the power to destroy civilizations. Sonic '
          'teams up with his own sidekick, Tails, and together they embark on a '
          'globe-trotting journey to find the emerald before it falls into the '
          'wrong hands.',
    ),
    Movie(
      id: 19,
      imageName: AppImages.jujustuKaisen0,
      title: 'Jujutsu Kaisen 0',
      date: 'December 24, 2021',
      description: 'Yuta Okkotsu is a nervous high school student who is '
          'suffering from a serious problem—his childhood friend Rika has '
          'turned into a curse and won\'t leave him alone. Since Rika is no '
          'ordinary curse, his plight is noticed by Satoru Gojo, a teacher at '
          'Jujutsu High, a school where fledgling exorcists learn how to combat '
          'curses. Gojo convinces Yuta to enroll, but can he learn enough in '
          'time to confront the curse that haunts him?',
    ),
    Movie(
      id: 20,
      imageName: AppImages.bulletTrain,
      title: 'Bullet Train',
      date: 'July 3, 2022',
      description: 'Unlucky assassin Ladybug is determined to do his job '
          'peacefully after one too many gigs gone off the rails. Fate, '
          'however, may have other plans, as Ladybug\'s latest mission puts him '
          'on a collision course with lethal adversaries from around the '
          'globe—all with connected, yet conflicting, objectives—on the '
          'world\'s fastest train.',
    ),
  ];

  List<Movie> _filteredMovies = [];

  final _controllerOfSearch = TextEditingController();

  @override
  void initState() {
    _filteredMovies = _movies;
    _controllerOfSearch.addListener(_searchMovies);
    super.initState();
  }

  void _searchMovies() {
    final query = _controllerOfSearch.text;
    if (query.isNotEmpty) {
      _filteredMovies = _movies.where((movie) {
        return movie.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      _filteredMovies = _movies;
    }
    setState(() {});
  }

  void _viewMovieInfo(int index) {
    Navigator.of(context).pushNamed(
      '/main_screen/movie_details',
      arguments: index,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: [
            ListView.builder(
              padding: const EdgeInsets.only(top: 70),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: _filteredMovies.length,
              itemExtent: 161,
              itemBuilder: (BuildContext context, int index) {
                final movie = _filteredMovies[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Stack(
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(7)),
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(7)),
                          child: Row(
                            children: [
                              Image(
                                image: AssetImage(movie.imageName),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        movie.title,
                                        style: AppTextStyle.titleFilmInCard,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        movie.date,
                                        style: AppTextStyle.dataFilmInCard,
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        movie.description,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style:
                                            AppTextStyle.descriptionFilmInCard,
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
                          onTap: () => _viewMovieInfo(movie.id),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            TextField(
              controller: _controllerOfSearch,
              decoration: InputDecoration(
                labelText: 'Search',
                filled: true,
                fillColor: Colors.white.withOpacity(0.9),
                suffixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
