part of 'movie_details_bloc.dart';

enum MovieDetailsStatus { initial, success, failure }

final class MovieDetailsState extends Equatable {
  final MovieDetailsStatus status;
  final String title;
  final bool isFavorite;
  final MovieDetails movieDetails;

  const MovieDetailsState({
    this.status = MovieDetailsStatus.initial,
    this.title = 'Loading...',
    this.isFavorite = false,
    this.movieDetails = const MovieDetails(),
  });

  @override
  String toString() {
    return 'MovieDetailsState{status: $status, isFavorite: $isFavorite, movieDetails: $movieDetails}';
  }

  MovieDetailsState copyWith({
    MovieDetailsStatus? status,
    String? title,
    bool? isFavorite,
    MovieDetails? movieDetails,
  }) {
    return MovieDetailsState(
      status: status ?? this.status,
      title: title ?? this.title,
      isFavorite: isFavorite ?? this.isFavorite,
      movieDetails: movieDetails ?? this.movieDetails,
    );
  }

  @override
  List<Object> get props => [status, title, isFavorite, movieDetails];
}
