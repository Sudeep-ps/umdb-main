class Movie {
  final String title;
  final String year;

  Movie({required this.title, required this.year});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      year: json['year'],
    );
  }
}

class MovieList {
  final List<Movie> items;

  MovieList({required this.items});

  factory MovieList.fromJson(Map<String, dynamic> json) {
    var list = json['items'] as List;
    List<Movie> movieList = list.map((i) => Movie.fromJson(i)).toList();
    return MovieList(items: movieList);
  }
}
