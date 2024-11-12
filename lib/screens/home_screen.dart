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
          : ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index]['show'];
                final name = movie != null && movie['name'] != null
                    ? movie['name']
                    : 'No Title';
                final imageUrl = movie != null && movie['image'] != null
                    ? movie['image']['medium']
                    : 'No Image';
                final summary = movie != null && movie['summary'] != null
                    ? movie['summary']
                    : 'No summary available';

                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  leading: Container(
                    width: 60.0,
                    height: 90.0,
                    decoration: BoxDecoration(
                      image: imageUrl != null
                          ? DecorationImage(
                              image: NetworkImage(imageUrl),
                              fit: BoxFit.cover,
                            )
                          : null,
                      color: Colors.grey[300],
                    ),
                    child: imageUrl == null
                        ? const Icon(Icons.movie, color: Colors.white)
                        : null,
                  ),
                  title: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/details', arguments: name);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                summary,
                                style: TextStyle(
                                    color: Colors.grey[600], fontSize: 12.0),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
