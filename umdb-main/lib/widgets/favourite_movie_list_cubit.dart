import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:umdb/cubits/movie_list_ui_state.dart';
import 'package:umdb/cubits/favourite_movie_cubit.dart';
import 'package:umdb/models/popular_movie_response.dart';

import '../models/popular_movie_hive.dart';

class FavouriteMovieListCubit extends StatefulWidget {
  const FavouriteMovieListCubit({super.key});

  @override
  State<FavouriteMovieListCubit> createState() => _FavouriteMovieListCubitState();
}

class _FavouriteMovieListCubitState extends State<FavouriteMovieListCubit> {

  late Box<PopularMovieHive> _movieBox;
  late List<PopularMovie> _favoriteMovieList;

  @override
  void initState() {
    super.initState();
    context.read<FavouriteMovieCubit>().getFavouriteMovies();
    // _movieBox = Hive.box('popular-movies');
    // fetchFavouriteMovies();
  }
  //
  // void _saveMovie(PopularMovieHive movie) {
  //   _movieBox.add(movie);
  //   fetchFavouriteMovies();
  //   print('Favourite list = $_favoriteMovieList');
  //   setState(() {});
  // }


  // void fetchFavouriteMovies() async {
  //   final favouriteMovieHiveList = _movieBox.values.toList();
  //   _favoriteMovieList = favouriteMovieHiveList.map((movieHive) =>
  //       PopularMovie(title: movieHive.title, year: movieHive.year)).toList();
  // }

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
    return BlocBuilder<FavouriteMovieCubit, UiState>(
        builder: (context, state) {
          return switch (state){
            Initial() => const Center(child: CircularProgressIndicator(),),
            Loading() => const Center(child: CircularProgressIndicator(),),
            Success() => ListView.builder(
              itemCount: state.movieList.length,
              itemBuilder: ( context, index){
                final movie = state.movieList[index];
                return ListTile(
                  title: Text(movie.title ?? "No title"),
                  subtitle: Text(movie.year ?? "1999"),
                );
              },
            ),
            Error() => const Center(child: Text('Something went wrong!'),),
          };
        }
    );

  }
}
