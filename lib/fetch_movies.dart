import 'package:signal/movie_model.dart';
import 'package:signal/movie_repository.dart';

class FetchMovies {
  final MovieRepository repository;
  void Function(List<MovieModel>) onChange = (_) {};

  FetchMovies(this.repository);

  void bindChanges(void Function(List<MovieModel>) onChange) {
    this.onChange = onChange;
  }

  void fetch() async {
    final movies = await repository.fetchMovies();
    onChange(movies.results ?? []);
  }
}
