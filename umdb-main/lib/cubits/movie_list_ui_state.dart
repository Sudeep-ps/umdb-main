import '../models/popular_movie_response.dart';

sealed class UiState {}

class Initial extends UiState {}
class Loading extends UiState {}
class Success extends UiState {
  Success(this.movieList);
  final List<PopularMovie> movieList;
}
class Error extends UiState {}