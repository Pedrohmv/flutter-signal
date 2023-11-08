import 'package:dio/dio.dart';
import 'package:signal/movie_model.dart';

class MovieRepository {
  final Dio dio;
  MovieRepository(this.dio);

  Future<MoviePagination> fetchMovies() async {
    final response = await dio.get('movie/popular?page=1');
    return MoviePagination.fromJson(response.data);
  }
}
