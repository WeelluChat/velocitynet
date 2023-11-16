import 'package:flutter/material.dart';
import 'package:velocity_net/helpers/url.dart';

class EndDrawer extends StatefulWidget {
  final ScrollController scrollController;
  const EndDrawer({super.key, required this.scrollController});

  @override
  State<EndDrawer> createState() => _EndDrawerState();
}

class _EndDrawerState extends State<EndDrawer> {
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = widget.scrollController;
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;

    return Drawer(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 15),
            child: InkWell(
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                if (currentRoute != "/") {
                  Navigator.pushNamed(context, '/');
                }
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
                if (currentRoute != "/") {
                  Navigator.pushNamed(context, '/');
                }
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
                if (currentRoute != "/") {
                  Navigator.pushNamed(context, '/');
                }
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
                if (currentRoute != "/") {
                  Navigator.pushNamed(context, '/');
                }
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
                if (currentRoute == '/tvplanos') {
                  return;
                }
                Navigator.pushNamed(context, '/tvplanos');
              },
              child: const Text(
                "TV",
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
                if (currentRoute != "/") {
                  Navigator.pushNamed(context, '/');
                }
                Navigator.pushNamed(context, '/contatos');
              },
              child: const Text(
                "CONTATOS",
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
              onPressed: () {
                Url().urlCentralAssinante();
              },
              child: const Text(
                "CENTRAL DO ASSINANTE",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
