import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umdb/cubits/top_rated_movie_list_ui_state.dart';

import 'package:http/http.dart' as http;
import 'package:umdb/models/top_rated_movie_response.dart';

class TopRatedMovieCubit extends Cubit<TopRatedMovieListUiState> {
  TopRatedMovieCubit() : super(Initial());

  void fetchTopRatedMoviesFromUrl() async {
    emit(Loading());
    final topRatedMovies = await _fetchDataFromUrl();
    if (topRatedMovies is List<TopRatedMovie>) {
      emit(Success(topRatedMovies));
    } else {
      emit(Error());
    }
}

  Future<List<TopRatedMovie>> _fetchDataFromUrl() async {
    const topRatedMoviesUrl = "https://movie-api-rish.onrender.com/top-rated";
    final topRatedMoviesUri = Uri.parse(topRatedMoviesUrl);

    try {
      final response = await http.get(topRatedMoviesUri);
      final responseJson = jsonDecode(response.body);

      final topRatedMoviesList = (responseJson['items'] as List<dynamic>).map(
              (topRatedMovie) => TopRatedMovie.fromJson(topRatedMovie)).toList();
      return topRatedMoviesList;
    }catch(e) {
      throw Exception(e);
    }
  }

}