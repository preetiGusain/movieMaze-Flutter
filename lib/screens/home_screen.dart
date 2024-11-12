import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> movies = [];

  @override
  void initState() {
    super.initState();
    fetchMovies();
    print('FetchMovies called');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('MovieMaze'),
        ),
        body: movies.isEmpty
            ? const Center(child: CircularProgressIndicator()) 
            :ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index]['show'];
                final name = movie['name'];
                return ListTile(
                  title: Text(name),
                );
              },
            ),
    );
  }

  void fetchMovies() async {
    const url = 'https://api.tvmaze.com/search/shows?q=all';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);

    setState(() {
      movies = json;
    });
    print('FetchMovies completed');
  }
}
