import 'package:flutter/material.dart';

class AppBarComponentResize extends StatefulWidget {
  const AppBarComponentResize({super.key});

  @override
  State<AppBarComponentResize> createState() => _AppBarComponentResizeState();
}

class _AppBarComponentResizeState extends State<AppBarComponentResize> {
  bool mobile = false;

  @override
  Widget build(BuildContext context) {
    mobile = MediaQuery.of(context).size.width > 1200 ? false : true;

    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      width: double.maxFinite,
      child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          title: SizedBox(
            width: 150,
            child: Image.asset(
              'assets/logo.png',
              fit: BoxFit.fill,
            ),
          ),
          actions: mobile ? null : null),
    );
  }
}
