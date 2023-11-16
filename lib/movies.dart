import 'package:flutter/material.dart';
import 'package:signal/di.dart';
import 'package:signal/fetch_movies.dart';
import 'package:signal/movie_card.dart';
import 'package:signal/movie_model.dart';
import 'package:signal/movie_state.dart';
import 'package:signal/signal.dart';
import 'package:signal/signal_widget.dart';

class Movies extends StatelessWidget {
  const Movies({super.key});

  @override
  Widget build(BuildContext context) {
    final fetchMovies = sl.get<FetchMovies>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Movies'),
      ),
      body: SignalBuilder(builder: (ctx) {
        Widget render(MovieState state) {
          return switch (state) {
            LoadingState() => const Text('Loading'),
            SuccessState success => GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 9 / 16),
                itemBuilder: (_, index) {
                  final movie = success.movieList[index];
                  return MovieCard(
                    title: movie.title,
                    posterPath: movie.posterPath,
                  );
                },
                itemCount: success.movieList.length,
              )
          };
        }

        final (movies, setMovies) =
            (ctx as SignalElement).createSignal<MovieState>(LoadingState());
        ctx.createEffect(() {
          fetchMovies.bindChanges((movies) {
            setMovies(movies);
          });
          fetchMovies.fetch();
        });

        return render(movies());
      }),
    );
  }
}
