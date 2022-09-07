import 'package:flutter/material.dart';
import 'package:themoviedb/Library/Widgets/Inherited/provider.dart';
import 'package:themoviedb/Theme/app_colors.dart';
import 'package:themoviedb/Theme/app_text_style.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/entity/movie_details_credits.dart';
import 'package:themoviedb/ui/widgets/elements/radial_percent_widget.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailsMainInfoWidget extends StatelessWidget {
  const MovieDetailsMainInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.thorLoveAndThunderBg,
      child: Column(
        children: const [
          _TopPosterWidget(),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: _TitleWidget(),
          ),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: _SecondHeaderWidget(),
          ),
          SizedBox(height: 16),
          _GenreWrapperWidget(),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: _OverviewWidget(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: _PeopleWidget(),
          ),
        ],
      ),
    );
  }
}

class _TopPosterWidget extends StatelessWidget {
  const _TopPosterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final backdropPath = model?.movieDetails?.backdropPath;
    final posterPath = model?.movieDetails?.posterPath;

    return AspectRatio(
      aspectRatio: 392.7 / 220.7,
      child: Stack(
        children: [
          backdropPath != null
              ? Image.network(
                  ApiClient.makeImage(backdropPath),
                  fit: BoxFit.fitWidth,
                )
              : const SizedBox.shrink(),
          Positioned(
            top: 20,
            bottom: 20,
            left: 20,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              child: posterPath != null
                  ? Image.network(
                      ApiClient.makeImage(posterPath),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    var year = model?.movieDetails?.releaseDate.year.toString();
    if (year != null) {
      year = ' ($year)';
    }

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: model?.movieDetails?.title,
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

class _SecondHeaderWidget extends StatefulWidget {
  const _SecondHeaderWidget({Key? key}) : super(key: key);

  @override
  State<_SecondHeaderWidget> createState() => _SecondHeaderWidgetState();
}

class _SecondHeaderWidgetState extends State<_SecondHeaderWidget> {
  Future<void> _showDialog(
    String youtubeKey,
  ) async {
    final controller = YoutubePlayerController(
      initialVideoId: youtubeKey,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );

    return showDialog<void>(
      context: context,
      useSafeArea: false,
      builder: (BuildContext context) {
        return OrientationBuilder(builder: (context, orientation) {
          return AlertDialog(
            title: const Text(
              'Play Trailer',
              style: TextStyle(color: Colors.white),
            ),
            insetPadding: orientation == Orientation.portrait
                ? const EdgeInsets.all(20)
                : EdgeInsets.zero,
            titlePadding: const EdgeInsets.all(16),
            content: YoutubePlayer(
              controller: controller,
            ),
            contentPadding: EdgeInsets.zero,
            backgroundColor: Colors.black,
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    if (model == null) return const SizedBox.shrink();
    final scale = model.movieDetails?.voteAverage ?? 0;
    final videos = model.movieDetails?.videos;
    if (videos == null) return const SizedBox.shrink();

    String? youtubeKey;
    if (videos.results.isNotEmpty) {
      final list = videos.results.where((video) =>
          video.site == 'YouTube' &&
          video.type == 'Trailer' &&
          video.official == true);
      if (list.isNotEmpty) {
        youtubeKey = list.first.key;
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            RadialPercentWidget(
              score: scale / 10,
              child: Text(
                (scale * 10).toStringAsFixed(0),
                style: AppTextStyle.score,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'User Score',
              style: AppTextStyle.userScore,
            ),
          ],
        ),
        Container(
          width: 1,
          height: 24,
          color: AppColors.verticalDivider,
        ),
        TextButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
          ),
          onPressed: () => youtubeKey != null ? _showDialog(youtubeKey) : null,
          child: Row(
            children: const [
              Icon(
                Icons.play_arrow,
                color: Colors.white,
              ),
              SizedBox(width: 6),
              Text(
                'Play Trailer',
                style: AppTextStyle.playTrailer,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _GenreWrapperWidget extends StatelessWidget {
  const _GenreWrapperWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final releaseDate = model?.movieDetails?.releaseDate;
    final certification = model?.certification ?? '';
    String date = '';
    if (releaseDate != null) {
      date = model?.stringFromDate(releaseDate) ?? ' ';
    }
    final productionCountry =
        model?.movieDetails?.productionCountries[0].iso ?? '';
    final runtime = model?.movieDetails?.runtime ?? 0;
    var hours = (runtime ~/ 60).toString();
    if (hours != '0') {
      hours = '$hours h';
    }
    final minutes = '${(runtime % 60).toStringAsFixed(0)} m';
    final time = '$hours $minutes';
    final genres = model?.movieDetails?.genres
            .map<String>((e) => e.name)
            .toList()
            .join(', ') ??
        '';

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
                      text: '  $date ($productionCountry) • $time \n$genres',
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

class _TagLineWidget extends StatelessWidget {
  const _TagLineWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final tagLine = model?.movieDetails?.tagline;
    if (tagLine == null) {
      return const SizedBox.shrink();
    }

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

class _OverviewWidget extends StatelessWidget {
  const _OverviewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final overview = model?.movieDetails?.overview ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _TagLineWidget(),
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

class _PeopleWidget extends StatelessWidget {
  const _PeopleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final crew = model?.movieDetails?.credits.crew;
    if (crew == null || crew.isEmpty) return const SizedBox.shrink();
    List<_RowOfPersonCardWidget> listCrew = _getListCrew(crew);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: listCrew,
    );
  }

  List<_RowOfPersonCardWidget> _getListCrew(List<Crew> crew) {
    List<_PersonCardWidget> list = _getMainCrew(crew);

    var rowCards = <_RowOfPersonCardWidget>[];
    int chunkSize = 2;
    for (int i = 0; i < list.length; i += chunkSize) {
      rowCards.add(_RowOfPersonCardWidget(
          list: list.sublist(
              i, i + chunkSize > list.length ? list.length : i + chunkSize)));
    }
    return rowCards;
  }

  List<_PersonCardWidget> _getMainCrew(List<Crew> crew) {
    Map<int, _PersonCardWidget> mapMainCrew = {};
    for (var element in crew) {
      final job = element.job;
      if (!(job == 'Author' ||
          job == 'Characters' ||
          job == 'Director' ||
          job == 'Novel' ||
          job == 'Screenplay' ||
          job == 'Story' ||
          job == 'Teleplay' ||
          job == 'Writer')) {
        continue;
      }

      if (mapMainCrew.containsKey(element.id)) {
        mapMainCrew.update(
            element.id,
            (value) => _PersonCardWidget(
                name: value.name, role: '${value.role}, ${element.job}'));
      } else {
        mapMainCrew[element.id] =
            _PersonCardWidget(name: element.name, role: element.job);
      }
    }

    var list = mapMainCrew.values.toList();
    list.sort((a, b) {
      var compare = a.role.compareTo(b.role);
      if (compare == 0) {
        compare = a.name.compareTo(b.name);
      }
      return compare;
    });
    if (list.length % 2 == 1) {
      list.add(const _PersonCardWidget(name: '', role: ''));
    }

    return list;
  }
}

class _PersonCardWidget extends StatelessWidget {
  final String name;
  final String role;

  const _PersonCardWidget({
    Key? key,
    required this.name,
    required this.role,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: AppTextStyle.personCardName,
          ),
          Text(
            role,
            style: AppTextStyle.personCardRole,
          )
        ],
      ),
    );
  }
}

class _RowOfPersonCardWidget extends StatelessWidget {
  final List<_PersonCardWidget> list;

  const _RowOfPersonCardWidget({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: list,
      ),
    );
  }
}
