import 'package:flutter/material.dart';
import 'package:moviemaze_flutter/screens/details_screen.dart';
import 'package:moviemaze_flutter/screens/home_screen.dart';
import 'package:moviemaze_flutter/screens/search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: HomeScreen(),
      routes: {
        '/details': (context) => const DetailsScreen(),
        '/search': (context) => const SearchScreen(),
      },
    );
  }
}
