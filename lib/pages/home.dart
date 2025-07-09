import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:velocity_net/modules/appbar/app_bar_component.dart';
import 'package:velocity_net/modules/appbar/app_bar_component_resize.dart';
import 'package:velocity_net/modules/endDrawer/end_drawer.dart';
import 'package:velocity_net/pages/homepagemobile.dart';
import 'package:velocity_net/pages/main.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool mobile = false;
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    mobile = MediaQuery.of(context).size.width > 1200 ? false : true;
    // final currentRoute = ModalRoute.of(context)?.settings.name;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: mobile == true
            ? const Size.fromHeight(80)
            : const Size.fromHeight(90),
        child: Container(
          margin: mobile == true
              ? const EdgeInsets.only(top: 15)
              : const EdgeInsets.only(top: 0),
          child: (mobile == true)
              ? const AppBarComponentResize()
              : AppBarComponent(scrollController: scrollController),
        ),
      ),
      endDrawer: mobile
          ? EndDrawer(
              scrollController: scrollController,
            )
          : null,
      body: kIsWeb ? Homepagemobile() : Main(scrollController: scrollController),
    );
  }
}
