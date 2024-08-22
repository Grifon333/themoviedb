import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themoviedb/domain/api_client/image_downloader.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';
import 'package:themoviedb/ui/widgets/movie_list/bloc/movie_list_bloc.dart';
import 'package:themoviedb/ui/widgets/movie_list/widgets/widgets.dart';

class MovieListWidget extends StatelessWidget {
  const MovieListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        children: [
          BlocBuilder<MovieListBloc, MovieListState>(
            builder: (context, state) {
              switch (state.status) {
                case MovieListStatus.initial:
                  return const Center(child: CircularProgressIndicator());
                case MovieListStatus.success:
                  if (state.movies.isEmpty) {
                    return const Center(child: Text('List is empty'));
                  }
                  return _MovieList(state);
                case MovieListStatus.failure:
                  return const Center(child: Text('Failed to fetch movies'));
              }
            },
          ),
          SearchQueryField(
            onChanged: (value) => context.read<MovieListBloc>().add(
                  MovieListSearchQueryChanged(searchQuery: value),
                ),
          ),
        ],
      ),
    );
  }
}

class _MovieList extends StatefulWidget {
  final MovieListState state;
  const _MovieList(this.state);

  @override
  State<_MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<_MovieList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    return ListView.builder(
      padding: const EdgeInsets.only(top: 70),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemExtent: 161,
      itemBuilder: (BuildContext context, int index) =>
      index >= state.movies.length
          ? const BottomLoader()
          : MovieListItem(
        movie: state.movies[index],
        makeImageURL: ImageDownloader.makeImage,
        onTap: () => MainNavigation.goToMovieDetails(
          context,
          state.movies[index].id,
        ),
      ),
      itemCount: state.hasReachedMax
          ? state.movies.length
          : state.movies.length + 1,
      controller: _scrollController,
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (isBottom) context.read<MovieListBloc>().add(MovieListFetched());
  }

  bool get isBottom {
    if (!_scrollController.hasClients) return false;
    final currentScroll = _scrollController.offset;
    final maxScroll = _scrollController.position.maxScrollExtent;
    return currentScroll >= (maxScroll * 0.9);
  }
}
