import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:umdb/cubits/movie_list_ui_state.dart';
import 'package:umdb/models/popular_movie_hive.dart';
import '../models/popular_movie_response.dart';

class FavouriteMovieCubit extends Cubit<UiState> {
  late List<PopularMovie> _favoriteMovieList;
  FavouriteMovieCubit() : super(Initial());

  void getFavouriteMovies() async {
    emit(Loading());
    final popularMovieList = fetchFavouriteMovies();
    if (popularMovieList is List<PopularMovie>) {
      emit(Success(popularMovieList));
    } else {
      emit(Error());
    }
  }

  List<PopularMovie> fetchFavouriteMovies() {
    final favouriteMovieHiveList = Hive.box<PopularMovieHive>('popular-movies').values.toList();
    return favouriteMovieHiveList.map((movieHive) =>
        PopularMovie(title: movieHive.title, year: movieHive.year)).toList();
  }

  Future<List<PopularMovie>> fetchDataFromJson() async {
    final jsonString = await rootBundle.loadString('assets/popular_movies.json');
    final popularMoviesResponse = jsonDecode(jsonString);
    final moviieList = (popularMoviesResponse['items'] as List<dynamic>).map((movieJson) => PopularMovie.fromJson(movieJson));
    return moviieList.toList();
  }

}