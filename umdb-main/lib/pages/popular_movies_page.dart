import 'package:flutter/material.dart';
import 'package:umdb/widgets/popular_movie_list_cubit.dart';
import 'package:umdb/widgets/popular_movie_list_json.dart';

class PopularMoviesPage extends StatelessWidget {
  const PopularMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PopularMovieListCubit();
  }
}
