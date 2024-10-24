import 'package:movie_search_imdb/utils/constants.dart';

class Movie {
  final String title;
  final String poster;
  final List<String> genres;
  final String imdbRating;

  Movie({
    required this.title,
    required this.poster,
    required this.genres,
    required this.imdbRating,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    String imagePath = 'http://image.tmdb.org/t/p/w500';
    List<int> genreList = [-1];
    if (json['genre_ids'] != null) {
      genreList = json['genre_ids'].length > 0 ? List<int>.from(json['genre_ids']) : [-1];
    }
    num ratingNum = (json['vote_average'] != null) ? json['vote_average'] ?? 0.0 : 0.0;

    return Movie(
      title: json['original_title'] ?? '',
      poster: imagePath + (json['poster_path'] ?? ''),
      genres: List.generate(genreList.length, (i) => genresMap[genreList[i]] ?? 'Unknown'),
      imdbRating: ratingNum.toStringAsFixed(1),
    );
  }
}