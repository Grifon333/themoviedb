part of 'movie_details_bloc.dart';

sealed class MovieDetailsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class MovieDetailsFetched extends MovieDetailsEvent {}

final class MovieDetailsUpdateFavoriteStatus extends MovieDetailsEvent {}
