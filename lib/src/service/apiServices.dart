import 'package:dio/dio.dart' show Dio;

import '../model/gender.dart';
import '../model/movieDetail.dart';
import '../model/movieReview.dart';
import '../model/movies.dart';
class ApiService {
  final Dio _dio = Dio();

  final String baseUrl = 'https://api.themoviedb.org/3';
  final String apiKey = 'api_key=47a59cbbdef0568a8312226f53867dcc';

  Future<List<Movies>> getNowPlayingMovie() async {
    try {
      final url = '$baseUrl/movie/now_playing?$apiKey';
      final response = await _dio.get(url);
      var movies = response.data['results'] as List;
      List<Movies> movieList = movies.map((m) => Movies.fromJson(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }
  Future<List<Gender>> getGenderList() async {
    try {
      final response = await _dio.get('$baseUrl/genre/movie/list?$apiKey');
      var gender = response.data['genres'] as List;
      List<Gender> genderList = gender.map((g) => Gender.fromJson(g)).toList();
      return genderList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }
  Future<List<Movies>> getMovieByGender(int movieId) async {
    try {
      final url = '$baseUrl/discover/movie?with_genres=$movieId&$apiKey';
      final response = await _dio.get(url);
      var movies = response.data['results'] as List;
      List<Movies> movieList = movies.map((m) => Movies.fromJson(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }
  Future<MovieDetail> getMovieDetail(int movieId) async {
    try {
      final response = await _dio.get('$baseUrl/movie/$movieId?$apiKey');
      MovieDetail movieDetail = MovieDetail.fromJson(response.data);
      return movieDetail;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<MovieReview>> getMovieReviews(int movieId) async {
    try {
      final response = await _dio.get('$baseUrl/movie/$movieId/reviews?$apiKey');
      var movies = response.data['results'] as List;
      List<MovieReview> movieList = movies.map((m) => MovieReview.fromJson(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }
}
