import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<dynamic> searchResults = [];

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  void fetchSearchResults(String searchTerm) async {
    final url = 'https://api.tvmaze.com/search/shows?q={Uri.encodeComponent(searchTerm)}';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final json = jsonDecode(body);

    setState(() {
      searchResults = json;
    });
  }
}