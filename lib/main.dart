import 'package:flutter/material.dart';
import 'package:velocity_net/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VelocityNet - VelocityNet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        // colorScheme: const ColorScheme(
        //     brightness: Brightness.dark,
        //     primary: Colors.black,
        //     onPrimary: Colors.black,
        //     secondary: Colors.black,
        //     onSecondary: Colors.black,
        //     error: Colors.black,
        //     onError: Colors.black,
        //     background: Colors.white,
        //     onBackground: Colors.black,
        //     surface: Colors.black,
        //     onSurface: Colors.black)),
      ),
      home: const Home(),
      // routes: {
      //   '/contatos': (context) => const Contact(),
      // },
    );
  }
}
