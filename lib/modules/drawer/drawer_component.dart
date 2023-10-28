import 'package:flutter/material.dart';

class DrawerComponent extends StatelessWidget {
  final bool mobile;
  const DrawerComponent({super.key, required this.mobile});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 15),
          child: InkWell(
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              // _scrollController.animateTo(
              //     _scrollController.position.minScrollExtent,
              //     duration: const Duration(milliseconds: 1000),
              //     curve: Curves.easeInQuad);
              // Navigator.pop(context);
            },
            child: const Text(
              "Home",
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
              // _scrollController.animateTo(
              //     _scrollController.position.minScrollExtent +
              //         580,
              //     duration: const Duration(milliseconds: 1000),
              //     curve: Curves.easeInQuad);
              // Navigator.pop(context);
            },
            child: const Text(
              "Novidades",
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
              // _scrollController.animateTo(
              //     _scrollController.position.minScrollExtent +
              //         950,
              //     duration: const Duration(milliseconds: 1000),
              //     curve: Curves.easeInQuad);
              // Navigator.pop(context);
            },
            child: const Text(
              "Recursos",
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
              // _scrollController.animateTo(
              //     _scrollController.position.maxScrollExtent,
              //     duration: const Duration(milliseconds: 1000),
              //     curve: Curves.easeInQuad);
              // Navigator.pop(context);
            },
            // style: TextButton.styleFrom(
            //   side: const BorderSide(
            //     width: 1.0,
            //     color: Color(0xFF05AC90),
            //   ),
            // ),
            child: const Text(
              "Fale Conosco",
              style: TextStyle(color: Color(0xFF05AC90), fontSize: 18),
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
            style:
                TextButton.styleFrom(backgroundColor: const Color(0xFF05AC90)),
            onPressed: () {},
            child: const Text(
              "Weellu Web",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ]),
    );
  }
}
