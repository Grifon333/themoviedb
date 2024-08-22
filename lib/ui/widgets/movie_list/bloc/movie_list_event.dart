part of 'movie_list_bloc.dart';

sealed class MovieListEvent extends Equatable {
  const MovieListEvent();

  @override
  List<Object> get props => [];
}

final class MovieListFetched extends MovieListEvent {}

final class MovieListSearchQueryChanged extends MovieListEvent {
  final String searchQuery;

  const MovieListSearchQueryChanged({
    required this.searchQuery,
  });

  @override
  List<Object> get props => [searchQuery];
}
