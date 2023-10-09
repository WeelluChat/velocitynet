import 'package:flutter/material.dart';
import 'package:velocity_net/components/appbar/app_bar_component.dart';
import 'package:velocity_net/components/appbar/app_bar_component_resize.dart';
import 'package:velocity_net/helpers/url.dart';
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

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: mobile == true
            ? const Size.fromHeight(80)
            : const Size.fromHeight(140),
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
          ? Drawer(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 15),
                    child: InkWell(
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        scrollController.animateTo(
                            scrollController.position.minScrollExtent,
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.easeInQuad);
                        // print('meu botão aqui');
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "INÍCIO",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: InkWell(
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        scrollController.animateTo(
                            scrollController.position.minScrollExtent + 600,
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.easeInQuad);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "PLANOS",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: InkWell(
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        scrollController.animateTo(
                            scrollController.position.minScrollExtent + 1400,
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.easeInQuad);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "SOBRE NÓS",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: InkWell(
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        scrollController.animateTo(
                            scrollController.position.minScrollExtent + 3350,
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.easeInQuad);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "OFERTA",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: InkWell(
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        scrollController.animateTo(
                            scrollController.position.minScrollExtent + 3850,
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.easeInQuad);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "BENEFÍCIOS",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0XFF13294E),
                      ),
                      onPressed: () {
                        Url().urlWhatsApp();
                      },
                      child: const Text(
                        "ASSINE JÁ",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: const Color(0XFF13294E)),
                      onPressed: () {},
                      child: const Text(
                        "CENTRAL DO ASSINANTE",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : null,
      body: Main(scrollController: scrollController),
    );
  }
}
