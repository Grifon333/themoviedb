import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themoviedb/theme/app_colors.dart';
import 'package:themoviedb/theme/app_text_style.dart';
import 'package:themoviedb/ui/widgets/elements/radial_percent_widget.dart';
import 'package:themoviedb/ui/widgets/movie_details/bloc/movie_details_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SecondHeader extends StatefulWidget {
  const SecondHeader({super.key});

  @override
  State<SecondHeader> createState() => _SecondHeaderState();
}

class _SecondHeaderState extends State<SecondHeader> {
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
    final data =
        context.select((MovieDetailsBloc bloc) => bloc.state.movieDetails);
    final score = data.score;
    final youtubeKey = data.youtubeKey;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            RadialPercentWidget(
              score: score,
              child: Text(
                (score * 100).toStringAsFixed(0),
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
