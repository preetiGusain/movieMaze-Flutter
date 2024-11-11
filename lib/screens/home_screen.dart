import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<dynamic> movies = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    final response =
        await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=all'));

    if (response.statusCode == 200) {
      List<dynamic> movieList = json.decode(response.body);
      setState(() {
        movies = movieList;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load the movies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MovieMaze'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(
                  context, '/search'); // Navigate to Search Screen
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator
          : ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                var movie = movies[index]['show']; // Movie details
                var title = movie['name'];
                var summary = movie['summary'] ?? 'No summary available';
                var imageUrl =
                    movie['image'] != null ? movie['image']['medium'] : '';

                return ListTile(
                  leading: imageUrl != ''
                      ? CachedNetworkImage(
                          imageUrl: imageUrl,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        )
                      : Icon(Icons.image), // Default icon if image is missing
                  title: Text(title),
                  subtitle: Text(summary,
                      maxLines: 2, overflow: TextOverflow.ellipsis),
                  onTap: () {
                    // Navigate to the details screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailsScreen(movieId: movie['id']),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
