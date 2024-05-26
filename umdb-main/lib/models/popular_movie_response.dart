class PopularMovieResponse {
  PopularMovieResponse({
      this.items, 
      this.errorMessage,});

  PopularMovieResponse.fromJson(dynamic json) {
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(PopularMovie.fromJson(v));
      });
    }
    errorMessage = json['errorMessage'];
  }
  List<PopularMovie>? items;
  String? errorMessage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    map['errorMessage'] = errorMessage;
    return map;
  }

}

class PopularMovie {
  PopularMovie({
      this.id, 
      this.rank, 
      this.rankUpDown, 
      this.title, 
      this.fullTitle, 
      this.year, 
      this.image, 
      this.crew, 
      this.imDbRating, 
      this.imDbRatingCount,});

  PopularMovie.fromJson(dynamic json) {
    id = json['id'];
    rank = json['rank'];
    rankUpDown = json['rankUpDown'];
    title = json['title'];
    fullTitle = json['fullTitle'];
    year = json['year'];
    image = json['image'];
    crew = json['crew'];
    imDbRating = json['imDbRating'];
    imDbRatingCount = json['imDbRatingCount'];
  }
  String? id;
  String? rank;
  String? rankUpDown;
  String? title;
  String? fullTitle;
  String? year;
  String? image;
  String? crew;
  String? imDbRating;
  String? imDbRatingCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['rank'] = rank;
    map['rankUpDown'] = rankUpDown;
    map['title'] = title;
    map['fullTitle'] = fullTitle;
    map['year'] = year;
    map['image'] = image;
    map['crew'] = crew;
    map['imDbRating'] = imDbRating;
    map['imDbRatingCount'] = imDbRatingCount;
    return map;
  }

}