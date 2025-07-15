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
  final ScrollController scrollController = ScrollController();
  bool mobile = false;
  bool _scrollHandled = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final route = ModalRoute.of(context)?.settings.name;
    final arg = ModalRoute.of(context)?.settings.arguments;

    if (!_scrollHandled && route == '/' && arg is double) {
      _scrollHandled = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.animateTo(
            arg,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOutCubic,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    mobile = MediaQuery.of(context).size.width <= 1200;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            mobile ? const Size.fromHeight(80) : const Size.fromHeight(90),
        child: Container(
          margin: mobile ? const EdgeInsets.only(top: 15) : EdgeInsets.zero,
          child: mobile
              ? const AppBarComponentResize()
              : AppBarComponent(scrollController: scrollController),
        ),
      ),
      endDrawer: mobile ? EndDrawer(scrollController: scrollController) : null,
      body: kIsWeb
          ? Homepagemobile(scrollController: scrollController,)
          : Main(scrollController: scrollController),
    );
  }
}
