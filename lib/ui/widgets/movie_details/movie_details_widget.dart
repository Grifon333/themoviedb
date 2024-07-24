import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_main_info_widget.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_model.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_screen_cast_widget.dart';

class MovieDetailsWidget extends StatefulWidget {
  const MovieDetailsWidget({
    super.key,
  });

  @override
  State<MovieDetailsWidget> createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  @override
  void didChangeDependencies() {
    Future.microtask(
        () => context.read<MovieDetailsModel>().setupLocale(context));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const _TitleWidget(),
        centerTitle: true,
        actions: const [
          _FavoriteWidget(),
        ],
      ),
      body: const _BodyWidget(),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget();

  @override
  Widget build(BuildContext context) {
    final title = context.select((MovieDetailsModel model) => model.data.title);
    return Text(title);
  }
}

class _FavoriteWidget extends StatelessWidget {
  const _FavoriteWidget();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MovieDetailsModel>();
    final favoriteIcon =
        context.select((MovieDetailsModel model) => model.data.favoriteIcon);

    return IconButton(
      onPressed: () => model.updateFavorite(context),
      icon: Icon(favoriteIcon),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget();

  @override
  Widget build(BuildContext context) {
    final isLoading =
        context.select((MovieDetailsModel model) => model.data.isLoading);
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return ListView(
      children: const [
        MovieDetailsMainInfoWidget(),
        MovieDetailsScreenCastWidget(),
      ],
    );
  }
}
