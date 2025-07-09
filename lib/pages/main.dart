import 'package:flutter/material.dart';
import 'package:velocity_net/modules/benefits/tv.dart';
import 'package:velocity_net/modules/description/description.dart';
import 'package:velocity_net/modules/footer/footer.dart';
import 'package:velocity_net/modules/plans/plans.dart';
import 'package:velocity_net/modules/plans/repository/monteseucombo.dart';
import 'package:velocity_net/modules/questions/questions.dart';
import 'package:velocity_net/modules/slider/slider.dart';
import 'package:velocity_net/modules/specialOffer/special_offer.dart';

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
          Tv(),
          Questions(),
          Footer(),
        ],
      ),
    );
  }
}
