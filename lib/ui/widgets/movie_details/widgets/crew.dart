import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themoviedb/theme/app_text_style.dart';
import 'package:themoviedb/ui/widgets/movie_details/bloc/movie_details_bloc.dart';
import 'package:themoviedb/ui/widgets/movie_details/models/crewman.dart';

class Crew extends StatelessWidget {
  const Crew({super.key});

  @override
  Widget build(BuildContext context) {
    final crew =
        context.select((MovieDetailsBloc bloc) => bloc.state.movieDetails.crew);
    if (crew.isEmpty) return const SizedBox.shrink();
    List<_RowOfCrewmanCard> listCrew = crew
        .map((row) => _RowOfCrewmanCard(
              row.map((el) => _CrewmanCard(data: el)).toList(),
            ))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: listCrew,
    );
  }
}

class _RowOfCrewmanCard extends StatelessWidget {
  final List<_CrewmanCard> list;

  const _RowOfCrewmanCard(this.list);

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

class _CrewmanCard extends StatelessWidget {
  final Crewman data;

  const _CrewmanCard({
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
