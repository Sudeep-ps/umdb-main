import 'package:flutter/material.dart';

import '../widgets/favourite_movie_list_cubit.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourites Page"),
      ),
        body: const FavouriteMovieListCubit()
    );
  }
}
