import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget{
  final int movieId;

  DetailsScreen({required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Movie Details')),
      body: Center(
        child: Text('Details for movie ID: $movieId'),
      ),
    );
  }
}