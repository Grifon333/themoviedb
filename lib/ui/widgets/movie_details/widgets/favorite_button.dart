import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themoviedb/ui/widgets/movie_details/bloc/movie_details_bloc.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MovieDetailsBloc>();
    final favoriteIcon = Icon(
      context.select((MovieDetailsBloc bloc) => bloc.state.isFavorite)
          ? Icons.favorite
          : Icons.favorite_outline,
    );
    return IconButton(
      onPressed: () => bloc.add(MovieDetailsUpdateFavoriteStatus()),
      icon: favoriteIcon,
    );
  }
}
