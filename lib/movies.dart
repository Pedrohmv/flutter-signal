import 'package:flutter/material.dart';
import 'package:signal/di.dart';
import 'package:signal/fetch_movies.dart';
import 'package:signal/movie_card.dart';
import 'package:signal/movie_model.dart';
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
        final (movies, setMovies) =
            (ctx as SignalElement).createSignal<List<MovieModel>>([]);
        ctx.createEffect(() {
          fetchMovies.bindChanges((movies) {
            setMovies(movies);
          });
          fetchMovies.fetch();
        });

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 9 / 16),
          itemBuilder: (_, index) {
            final movie = movies()[index];
            return MovieCard(
              title: movie.title,
              posterPath: movie.posterPath,
            );
          },
          itemCount: movies().length,
        );
      }),
    );
  }
}
