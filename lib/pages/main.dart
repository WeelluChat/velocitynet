import 'package:flutter/material.dart';
import 'package:velocity_net/components/description/description.dart';
import 'package:velocity_net/components/plans/plans.dart';
import 'package:velocity_net/components/slider/slider.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          SliderComponent(),
          PlansComponent(),
          Descrption(),
        ],
      ),
    );
  }
}
