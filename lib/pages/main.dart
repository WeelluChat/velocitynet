import 'package:flutter/material.dart';
import 'package:velocity_net/components/benefits/benefits_components.dart';
import 'package:velocity_net/components/description/description.dart';
import 'package:velocity_net/components/footer/footer.dart';
import 'package:velocity_net/components/plans/plans.dart';
import 'package:velocity_net/components/questions/questions.dart';
import 'package:velocity_net/components/slider/slider.dart';
import 'package:velocity_net/components/specialOffer/special_offer.dart';

class Main extends StatefulWidget {
  final ScrollController scrollController;
  const Main({super.key, required this.scrollController});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = widget.scrollController;
  }

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
          SpecialOffer(),
          Benefits(),
          Questions(),
          Footer(),
          // Copyright()
        ],
      ),
    );
  }
}
