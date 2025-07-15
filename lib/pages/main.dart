import 'package:flutter/material.dart';
import 'package:velocity_net/modules/benefits/tv.dart';
import 'package:velocity_net/modules/description/description.dart';
import 'package:velocity_net/modules/footer/footer.dart';
import 'package:velocity_net/modules/plans/plans.dart';
import 'package:velocity_net/modules/questions/questions.dart';
import 'package:velocity_net/modules/slider/slider.dart';

class Main extends StatelessWidget {
  final ScrollController scrollController;
  const Main({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      child: const Column(
        children: [
          SliderComponent(),
          PlansComponent(),
          Descrption(),
          Tv(),
          Questions(),
          Footer(),
        ],
      ),
    );
  }
}
