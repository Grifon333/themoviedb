import 'package:flutter/material.dart';
import 'package:themoviedb/Theme/app_colors.dart';
import 'package:themoviedb/Theme/app_text_style.dart';
import 'package:themoviedb/resources/resources.dart';
import 'package:themoviedb/widgets/elements/radial_percent_widget.dart';

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
    return Stack(
      children: const [
        Image(
          image: AssetImage(AppImages.thorLoveAndThunderBg),
          fit: BoxFit.fitWidth,
        ),
        Positioned(
          top: 20,
          bottom: 20,
          left: 20,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            child: Image(
              image: AssetImage(AppImages.thorLoveAndThunder),
            ),
          ),
        ),
      ],
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        children: [
          TextSpan(
            text: 'Thor: Love and Thunder ',
            style: AppTextStyle.titleMovie,
          ),
          TextSpan(
            text: '(2022)',
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: const [
            RadialPercentWidget(score: 68),
            SizedBox(width: 10),
            Text(
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
        const Text(
          'Play Trailer',
          style: AppTextStyle.playTrailer,
        ),
      ],
    );
  }
}

class _FactsWidget extends StatelessWidget {
  const _FactsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          child: const ColoredBox(
            color: AppColors.facts,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'PG-13  07/08/2022 (US) • 1h 59m \nAction, Adventure, Fantasy',
                style: AppTextStyle.facts,
                textAlign: TextAlign.center,
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
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: double.infinity),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Overview',
            style: AppTextStyle.overviewTitle,
          ),
          SizedBox(height: 8),
          Text(
            'After his retirement is interrupted by Gorr the God Butcher, a '
            'galactic killer who seeks the extinction of the gods, Thor '
            'enlists the help of King Valkyrie, Korg, and ex-girlfriend '
            'Jane Foster, who now inexplicably wields Mjolnir as the Mighty '
            'Thor. Together they embark upon a harrowing cosmic adventure '
            'to uncover the mystery of the God Butcher’s vengeance and stop '
            'him before it’s too late.',
            style: AppTextStyle.overviewBody,
          ),
          SizedBox(height: 30),
          _PeopleWidget(),
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
