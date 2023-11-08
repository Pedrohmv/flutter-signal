import 'package:flutter/material.dart';
import 'package:signal/di.dart';
import 'package:signal/home.dart';
import 'package:signal/movies.dart';
import 'package:signal/signal_widget.dart';
import 'package:signal/state_sample.dart';

void main() async {
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (_) => const Home(),
        '/movies': (_) => const Movies(),
        '/states': (_) => const StateSample(),
      },
    );
  }
}
