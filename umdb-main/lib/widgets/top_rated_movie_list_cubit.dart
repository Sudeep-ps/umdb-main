import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:umdb/cubits/top_rated_movie_list_ui_state.dart';

import '../cubits/top_rated_movie_cubit.dart';

class TopRatedMovieListCubit extends StatefulWidget {
  const TopRatedMovieListCubit({super.key});

  @override
  State<TopRatedMovieListCubit> createState() => _TopRatedMovieListCubitState();
}

class _TopRatedMovieListCubitState extends State<TopRatedMovieListCubit> {

  @override
  void initState() {
    super.initState();
    context.read<TopRatedMovieCubit>().fetchTopRatedMoviesFromUrl();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopRatedMovieCubit, TopRatedMovieListUiState>(
        builder: (context,state) {
          return switch (state) {
            Initial() => const Center(child: CircularProgressIndicator(),),
            Loading() => const Center(child: CircularProgressIndicator(),),
            Success() => ListView.builder(itemBuilder: (context, index) {
              final movie = state.movieList[index];
              return ListTile(
                title: Text(movie.title ?? 'No Title',style: TextStyle(fontFamily: GoogleFonts.spectral().fontFamily,fontWeight: FontWeight.w300)),
                subtitle: Text(movie.year ?? 'No Title'),
              );
            }),
            Error() => const Center(child: Text("Some error occured!")),
          };

    },);
  }
}
