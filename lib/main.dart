import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:moviemaze_flutter/screens/details_screen.dart';
import 'package:moviemaze_flutter/screens/home_screen.dart';
import 'package:moviemaze_flutter/screens/search_screen.dart';
import 'package:moviemaze_flutter/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Removing the splash screen once the app is fully initialized
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      routes: {
        '/details': (context) => const DetailsScreen(),
        '/search': (context) => const SearchScreen(),
      },
    );
  }
}
