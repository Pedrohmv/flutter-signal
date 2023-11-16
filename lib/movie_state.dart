import 'package:signal/movie_model.dart';

sealed class MovieState {}

class EmptyState extends MovieState {}

class LoadingState extends MovieState {}

class SuccessState extends MovieState {
  final List<MovieModel> movieList;

  SuccessState(this.movieList);
}
