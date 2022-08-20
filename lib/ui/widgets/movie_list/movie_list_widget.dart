import 'package:flutter/material.dart';
import 'package:themoviedb/Library/Widgets/Inherited/provider.dart';
import 'package:themoviedb/Theme/app_colors.dart';
import 'package:themoviedb/Theme/app_text_style.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/ui/widgets/movie_list/movie_list_model.dart';

class MovieListWidget extends StatelessWidget {
  const MovieListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieListModel>(context);
    if (model == null) return const SizedBox.shrink();

    return Scaffold(
      // delete Scaffold ???
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: [
            ListView.builder(
              padding: const EdgeInsets.only(top: 70),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: model.movies.length,
              itemExtent: 161,
              itemBuilder: (BuildContext context, int index) {
                final movie = model.movies[index];
                final posterPath = movie.posterPath;
                model.showMovieAtIndex(index);
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Stack(
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(7)),
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(7)),
                          child: Row(
                            children: [
                              // Image(
                              //   image: AssetImage(movie.imageName),
                              // ),
                              posterPath != null
                                  ? Image.network(
                                      ApiClient.makeImage(posterPath),
                                      width: 94,
                                    )
                                  : const SizedBox.shrink(),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        movie.title,
                                        style: AppTextStyle.titleFilmInCard,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        model.stringFromData(movie.releaseDate),
                                        style: AppTextStyle.dataFilmInCard,
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        movie.overview,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style:
                                            AppTextStyle.descriptionFilmInCard,
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
              },
            ),
            TextField(
              onChanged: model.searchMovies,
              decoration: InputDecoration(
                labelText: 'Search',
                filled: true,
                fillColor: Colors.white.withOpacity(0.9),
                suffixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
