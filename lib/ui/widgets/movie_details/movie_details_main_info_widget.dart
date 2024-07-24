import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/Theme/app_colors.dart';
import 'package:themoviedb/Theme/app_text_style.dart';
import 'package:themoviedb/domain/api_client/image_downloader.dart';
import 'package:themoviedb/ui/widgets/elements/radial_percent_widget.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailsMainInfoWidget extends StatelessWidget {
  const MovieDetailsMainInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: AppColors.movie_info_background,
      child: Column(
        children: [
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
  const _TopPosterWidget();

  @override
  Widget build(BuildContext context) {
    final posterData =
        context.select((MovieDetailsModel model) => model.data.posterData);
    final backdropPath = posterData.backdropPath;
    final posterPath = posterData.posterPath;
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

class _TitleWidget extends StatelessWidget {
  const _TitleWidget();

  @override
  Widget build(BuildContext context) {
    final data = context.select((MovieDetailsModel model) => model.data);
    final year = data.year;
    final title = data.title;

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
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
  const _SecondHeaderWidget();

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
        return OrientationBuilder(
          builder: (context, orientation) {
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
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final scoreMovieData =
        context.select((MovieDetailsModel model) => model.data.scoreMovieData);
    final score = scoreMovieData.score;
    final scoreStr = scoreMovieData.scoreStr;
    final youtubeKey = scoreMovieData.youtubeKey;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            RadialPercentWidget(
              score: score,
              child: Text(
                scoreStr,
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
        ColoredBox(
          color: AppColors.verticalDivider,
          child: const SizedBox(
            width: 1,
            height: 24,
          ),
        ),
        TextButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
          ),
          onPressed: () => youtubeKey != null ? _showDialog(youtubeKey) : null,
          child: const Row(
            children: [
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
  const _GenreWrapperWidget();

  @override
  Widget build(BuildContext context) {
    final genresData =
        context.select((MovieDetailsModel model) => model.data.genreData);
    final certification = genresData.certification;
    final date = genresData.date;
    final productionCountry = genresData.productionCountry;
    final runtime = genresData.runtime;
    final genres = genresData.genres;

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
                      text: '  $date ($productionCountry) • $runtime \n$genres',
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
  const _TagLineWidget();

  @override
  Widget build(BuildContext context) {
    final tagLine =
        context.select((MovieDetailsModel model) => model.data.tagline);
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

class _OverviewWidget extends StatelessWidget {
  const _OverviewWidget();

  @override
  Widget build(BuildContext context) {
    final overview =
        context.select((MovieDetailsModel model) => model.data.overview);

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
  const _PeopleWidget();

  @override
  Widget build(BuildContext context) {
    final crewDataMatrix =
        context.select((MovieDetailsModel model) => model.data.crewDatMatrix);
    if (crewDataMatrix.isEmpty) return const SizedBox.shrink();
    List<_RowOfPersonCardWidget> listCrew = crewDataMatrix
        .map((row) => _RowOfPersonCardWidget(
            row.map((el) => _PersonCardWidget(data: el)).toList()))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: listCrew,
    );
  }
}

class _RowOfPersonCardWidget extends StatelessWidget {
  final List<_PersonCardWidget> list;

  const _RowOfPersonCardWidget(this.list);

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

class _PersonCardWidget extends StatelessWidget {
  final MovieDetailsCrewData data;

  const _PersonCardWidget({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.name,
            style: AppTextStyle.personCardName,
          ),
          Text(
            data.job,
            style: AppTextStyle.personCardJob,
          )
        ],
      ),
    );
  }
}
