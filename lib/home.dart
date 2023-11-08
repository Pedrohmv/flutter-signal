import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('State Management Library'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/states');
            },
            child: const Text('State sample'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/movies');
            },
            child: const Text('Movies'),
          ),
        ],
      )),
    );
  }
}
