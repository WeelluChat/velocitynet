import 'package:flutter/material.dart';
import 'package:velocity_net/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VelocityNet - VelocityNet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: const ColorScheme(
              brightness: Brightness.dark,
              primary: Colors.white,
              onPrimary: Colors.white,
              secondary: Colors.white,
              onSecondary: Colors.white,
              error: Colors.white,
              onError: Colors.white,
              background: Colors.white,
              onBackground: Colors.white,
              surface: Colors.white,
              onSurface: Colors.white)),
      home: const Home(),
    );
  }
}
