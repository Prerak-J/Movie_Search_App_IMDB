import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movie_search_imdb/models/movie_model.dart';
import 'package:movie_search_imdb/utils/keys.dart';

class MovieProvider with ChangeNotifier {
  List<Movie> _movies = [];
  bool _isLoading = false;
  String _error = '';
  String searchApi =
      'https://api.themoviedb.org/3/search/movie?query={searchTerm}&include_adult=false&language=en-US&page=1&api_key=$apiKey';

  List<Movie> get movies => _movies;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> searchMovies(String query) async {
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      final response = await http.get(
        Uri.parse(
          searchApi.replaceFirst(RegExp(r'{searchTerm}'), query.isNotEmpty ? query : 'Harry Potter'),
        ),
      );

      if (response.statusCode == 200) {
        final searchData = json.decode(response.body);
        _movies = (searchData['results'] as List).map((movie) => Movie.fromJson(movie)).toList();
      } else {
        _error = 'Failed to fetch movies';
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
