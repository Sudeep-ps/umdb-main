import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:umdb/cubits/movie_list_ui_state.dart';
import 'package:umdb/cubits/popular_movie_cubit.dart';
import 'package:umdb/models/popular_movie_response.dart';

import '../models/popular_movie_hive.dart';

class PopularMovieListCubit extends StatefulWidget {
  const PopularMovieListCubit({super.key});

  @override
  State<PopularMovieListCubit> createState() => _PopularMovieListCubitState();
}

class _PopularMovieListCubitState extends State<PopularMovieListCubit> {

  late Box<PopularMovieHive> _movieBox;
  late List<PopularMovieHive> _favoriteMovieHiveList;

  @override
  void initState() {
    super.initState();
    context.read<PopularMovieCubit>().getPopularMovies();
    _movieBox = Hive.box('popular-movies');
    fetchFavouriteMovies();
  }

  void _saveMovie(PopularMovieHive movie) {
    _movieBox.add(movie);
    fetchFavouriteMovies();
    print('Favourite list = $_favoriteMovieHiveList');
    setState(() {});
  }

  void _deleteMovie(PopularMovieHive movie) {
    movie.delete();
    fetchFavouriteMovies();
    setState(() {});
  }

  void fetchFavouriteMovies() async {
    _favoriteMovieHiveList = _movieBox.values.toList();
  }


  @override
  Widget build(BuildContext context) {
    // return ListView.builder(
    //     itemCount: _popularMovieList.length,
    //     itemBuilder: ( context, index){
    //       return ListTile(
    //         title: Text(_popularMovieList[index].title ?? "No title"),
    //         subtitle: Text(_popularMovieList[index].year ?? "1999"),
    //       );
    //     }
    // );
    return BlocBuilder<PopularMovieCubit, UiState>(
        builder: (context, state) {
          return switch (state){
            Initial() => const Center(child: CircularProgressIndicator(),),
            Loading() => const Center(child: CircularProgressIndicator(),),
            Success() => ListView.builder(
                itemCount: state.movieList.length,
                itemBuilder: ( context, index){
                  final movie = state.movieList[index];
                  var isFavourite = _favoriteMovieHiveList.any(
                          (favMovie) => favMovie.title == movie.title);
                  late PopularMovieHive? favoriteMovieHive;
                  if (isFavourite) {
                    favoriteMovieHive = _favoriteMovieHiveList.firstWhere(
                            (favMovie) => favMovie.title == movie.title);
                  }
                  return ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(movie.title ?? "No title",style: TextStyle(fontFamily: GoogleFonts.spectral().fontFamily,fontWeight: FontWeight.w500)),
                        const Icon(Icons.favorite_border, size: 20,)
                      ],
                    ),
                    subtitle: Text(movie.year ?? "1999"),
                    onTap: () {
                      final movieHive = PopularMovieHive(title: movie.title, year: movie.year);
                      isFavourite ? _deleteMovie(favoriteMovieHive!) : _saveMovie(movieHive);
                    },
                    tileColor: isFavourite? const Color.fromARGB(255, 110, 163, 255) : Colors.white,
                  );
                },
            ),
            Error() => const Center(child: Text('Something went wrong!'),),
          };
        }
    );

  }
}
