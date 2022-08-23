import 'package:flutter/material.dart';
import 'package:themoviedb/Library/Widgets/Inherited/provider.dart';
import 'package:themoviedb/Theme/app_colors.dart';
import 'package:themoviedb/Theme/app_text_style.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/ui/widgets/elements/radial_percent_widget.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_model.dart';

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
          _FactsWidget(),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: _OverviewWidget(),
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

class _SecondHeaderWidget extends StatelessWidget {
  const _SecondHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final scale = model?.movieDetails?.voteAverage ?? 0;

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
            padding: MaterialStateProperty.all(EdgeInsets.all(0)),
          ),
          onPressed: () {},
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

class _FactsWidget extends StatelessWidget {
  const _FactsWidget({Key? key}) : super(key: key);

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
              // child: Text(
              //   '$certification $date ($productionCountry) • $time \n$genres',
              //   style: AppTextStyle.facts,
              //   textAlign: TextAlign.center,
              // ),
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

class _OverviewWidget extends StatelessWidget {
  const _OverviewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final overview = model?.movieDetails?.overview ?? '';

    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: double.infinity),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          const _PeopleWidget(),
        ],
      ),
    );
  }
}

class _PeopleWidget extends StatelessWidget {
  const _PeopleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Expanded(
                child: _PersonCardWidget(
                    name: 'Taika Waititi', role: 'Director, Writer')),
            Expanded(
                child:
                    _PersonCardWidget(name: 'Jim Starlin', role: 'Characters')),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: const [
            Expanded(
                child: _PersonCardWidget(
                    name: 'Streve Englehart', role: 'Characters')),
            Expanded(
                child:
                    _PersonCardWidget(name: 'Bill Mantlo', role: 'Characters')),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: const [
            Expanded(
                child:
                    _PersonCardWidget(name: 'Steve Gan', role: 'Characters')),
            Expanded(
                child: _PersonCardWidget(
                    name: 'Larry Lieber', role: 'Characters')),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: const [
            Expanded(
                child: _PersonCardWidget(name: 'Stan Lee', role: 'Characters')),
            Expanded(
                child: _PersonCardWidget(name: 'Don Heck', role: 'Characters')),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: const [
            Expanded(
                child:
                    _PersonCardWidget(name: 'Jack Kirby', role: 'Characters')),
            Expanded(
                child: _PersonCardWidget(
                    name: 'Keith Giffen', role: 'Characters')),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: const [
            Expanded(
                child: _PersonCardWidget(
                    name: 'Jennifer Kaytin Robinson', role: 'Writer')),
            Expanded(child: _PersonCardWidget(name: '', role: '')),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
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
    return Column(
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
    );
  }
}
