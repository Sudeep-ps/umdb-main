import 'package:umdb/models/top_rated_movie_response.dart';

import '../models/popular_movie_response.dart';

sealed class TopRatedMovieListUiState {}

class Initial extends TopRatedMovieListUiState {}
class Loading extends TopRatedMovieListUiState {}
class Success extends TopRatedMovieListUiState {
  Success(this.movieList);
  final List<TopRatedMovie> movieList;
}
class Error extends TopRatedMovieListUiState {}