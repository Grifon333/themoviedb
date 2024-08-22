import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themoviedb/Theme/app_colors.dart';
import 'package:themoviedb/Theme/app_text_style.dart';
import 'package:themoviedb/domain/api_client/image_downloader.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';
import 'package:themoviedb/ui/widgets/movie_list/bloc/movie_list_bloc.dart';

class MovieListWidget extends StatelessWidget {
  const MovieListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(10.0),
      child: Stack(
        children: [
          _MovieListWidget(),
          _SearchWidget(),
        ],
      ),
    );
  }
}

class _MovieListWidget extends StatefulWidget {
  const _MovieListWidget();

  @override
  State<_MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<_MovieListWidget> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieListBloc, MovieListState>(
      builder: (context, state) {
        switch (state.status) {
          case MovieListStatus.initial:
            return const Center(child: CircularProgressIndicator());
          case MovieListStatus.success:
            if (state.movies.isEmpty) {
              return const Center(child: Text('List is empty'));
            }
            return ListView.builder(
              padding: const EdgeInsets.only(top: 70),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemExtent: 161,
              itemBuilder: (BuildContext context, int index) {
                return index >= state.movies.length
                    ? const _BottomLoader()
                    : _MovieListRowWidget(index: index);
              },
              itemCount: state.hasReachedMax
                  ? state.movies.length
                  : state.movies.length + 1,
              controller: _scrollController,
            );
          case MovieListStatus.failure:
            return const Center(child: Text('Failed to fetch movies'));
        }
      },
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

class _BottomLoader extends StatelessWidget {
  const _BottomLoader();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(strokeWidth: 1.5),
      ),
    );
  }
}

class _MovieListRowWidget extends StatelessWidget {
  final int index;

  const _MovieListRowWidget({required this.index});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MovieListBloc>();
    final movie = bloc.state.movies[index];
    final posterPath = movie.posterPath;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(7)),
              color: AppColors.white,
              border: Border.all(
                width: 1,
                color: AppColors.lightGrey,
              ),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 2),
                  blurRadius: 8,
                  color: AppColors.lightGrey,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(7)),
              child: Row(
                children: [
                  if (posterPath != null)
                    Image.network(
                      ImageDownloader.makeImage(posterPath),
                      width: 94,
                    ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: AppTextStyle.titleFilmInCard,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            movie.releaseDate,
                            style: AppTextStyle.dateFilmInCard,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            movie.overview,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: AppTextStyle.descriptionFilmInCard,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(
                Radius.circular(7),
              ),
              onTap: () => MainNavigation.goToMovieDetails(context, movie.id),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchWidget extends StatelessWidget {
  const _SearchWidget();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MovieListBloc>();
    return TextField(
      onChanged: (value) => bloc.add(
        MovieListSearchQueryChanged(searchQuery: value),
      ),
      decoration: InputDecoration(
        labelText: 'Search',
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
        suffixIcon: const Icon(Icons.search),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
