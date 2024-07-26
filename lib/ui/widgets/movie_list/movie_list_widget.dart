import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/Theme/app_colors.dart';
import 'package:themoviedb/Theme/app_text_style.dart';
import 'package:themoviedb/domain/api_client/image_downloader.dart';
import 'package:themoviedb/ui/widgets/movie_list/movie_list_view_model.dart';

class MovieListWidget extends StatefulWidget {
  const MovieListWidget({super.key});

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  @override
  void didChangeDependencies() {
    final locale = Localizations.localeOf(context);
    Future.microtask(
            () => context.read<MovieListViewModel>().setupLocale(locale));
    super.didChangeDependencies();
  }

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

class _MovieListWidget extends StatelessWidget {
  const _MovieListWidget();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MovieListViewModel>();
    return ListView.builder(
      padding: const EdgeInsets.only(top: 70),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: model.movies.length,
      itemExtent: 161,
      itemBuilder: (BuildContext context, int index) {
        model.showMovieAtIndex(index);
        return _MovieListRowWidget(index: index);
      },
    );
  }
}

class _MovieListRowWidget extends StatelessWidget {
  final int index;

  const _MovieListRowWidget({required this.index});

  @override
  Widget build(BuildContext context) {
    final model = context.read<MovieListViewModel>();
    final movie = model.movies[index];
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
              onTap: () => model.viewMovieInfo(context, index),
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
    final model = context.watch<MovieListViewModel>();
    return TextField(
      onChanged: model.searchMovies,
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
