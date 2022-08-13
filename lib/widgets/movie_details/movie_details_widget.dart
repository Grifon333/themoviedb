import 'package:flutter/material.dart';
import 'package:themoviedb/widgets/movie_details/movie_details_main_info_widget.dart';

class MovieDetailsWidget extends StatefulWidget {
  final int movieId;

  const MovieDetailsWidget({
    Key? key,
    required this.movieId,
  }) : super(key: key);

  @override
  State<MovieDetailsWidget> createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Details ${widget.movieId}'),
      ),
      body: ColoredBox(
        color: const Color.fromRGBO(74, 53, 116, 1),
        child: ListView(
          children: const [
            MovieDetailsMainInfoWidget(),
          ],
        ),
      ),
    );
  }
}
