import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umdb/cubits/movie_list_ui_state.dart';
import '../models/popular_movie_response.dart';

class PopularMovieCubit extends Cubit<UiState> {
  PopularMovieCubit() : super(Initial());

  void getPopularMovies() async {
    emit(Loading());
    final popularMovieList = await fetchDataFromJson();
    if (popularMovieList is List<PopularMovie>) {
      emit(Success(popularMovieList));
    } else {
      emit(Error());
    }
  }

  Future<List<PopularMovie>> fetchDataFromJson() async {
    final jsonString = await rootBundle.loadString('assets/popular_movies.json');
    final popularMoviesResponse = jsonDecode(jsonString);
    final moviieList = (popularMoviesResponse['items'] as List<dynamic>).map((movieJson) => PopularMovie.fromJson(movieJson));
    return moviieList.toList();
  }

}