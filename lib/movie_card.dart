import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final String? posterPath;
  final String? title;

  const MovieCard({Key? key, this.posterPath, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CachedNetworkImage(
          imageUrl: posterPath ?? '',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.white60,
          height: 50,
        ),
        SizedBox(
          height: 50,
          child: Center(
            child: Text(
              title ?? '',
              style: const TextStyle(color: Colors.black),
            ),
          ),
        )
      ],
    );
  }
}
