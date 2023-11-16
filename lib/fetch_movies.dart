import 'package:signal/movie_repository.dart';
import 'package:signal/movie_state.dart';

class FetchMovies {
  final MovieRepository repository;
  void Function(MovieState) onChange = (_) {};

  FetchMovies(this.repository);

  void bindChanges(void Function(MovieState) onChange) {
    this.onChange = onChange;
  }

  void fetch() async {
    final movies = await repository.fetchMovies();
    onChange(SuccessState(movies.results ?? []));
  }
}
