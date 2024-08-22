part of 'movie_list_bloc.dart';

enum MovieListStatus { initial, success, failure }

final class MovieListState extends Equatable {
  final MovieListStatus status;
  final int currentPage;
  final int totalPages;
  final List<Movie> movies;
  final SearchQuery searchQuery;

  bool get hasReachedMax => currentPage == totalPages;

  bool get isSearchQueryValid => searchQuery.isValid;

  const MovieListState({
    this.status = MovieListStatus.initial,
    this.currentPage = 0,
    this.totalPages = 1,
    this.movies = const <Movie>[],
    this.searchQuery = const SearchQuery.pure(),
  });

  @override
  List<Object> get props =>
      [status, currentPage, totalPages, movies, searchQuery];

  @override
  String toString() {
    return 'MovieListState{status: $status, currentPage: $currentPage, totalPages: $totalPages, moviesLength: ${movies.length}, searchQuery: ${searchQuery}';
  }

  MovieListState copyWith({
    MovieListStatus? status,
    int? currentPage,
    int? totalPages,
    List<Movie>? movies,
    SearchQuery? searchQuery,
  }) {
    return MovieListState(
      status: status ?? this.status,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      movies: movies ?? this.movies,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
