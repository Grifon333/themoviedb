import 'package:equatable/equatable.dart';

final class Movie extends Equatable {
  final int id;
  final String title;
  final String overview;
  final String releaseDate;
  final String? posterPath;

  const Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.releaseDate,
    this.posterPath,
  });

  @override
  List<Object> get props =>
      [id, title, override, releaseDate, posterPath ?? ''];
}
