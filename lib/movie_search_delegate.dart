// Interface for the user to input their search term
import 'package:flutter/material.dart';

class MovieSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, ''); // Close the search delegate
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    close(context, query);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListTile(
      title: Text('Search for "$query"'),
      onTap: () {
        showResults(context);
      },
    );
  }
}
