import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

class PlansComponent extends StatefulWidget {
  const PlansComponent({super.key});

  @override
  State<PlansComponent> createState() => _PlansComponentState();
}

class _PlansComponentState extends State<PlansComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      child: Column(
        children: [
          const Text(
            'Escolha o melhor plano para você!',
            style: TextStyle(color: Colors.black, fontSize: 40),
          ),
          SizedBox(
            width: 1200,
            height: 500,
            child: ListView(
              children: [
                Container(
                  width: 300,
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 20, left: 40, right: 40),
                  child: Column(
                    children: [
                      Container(
                        width: 300,
                        decoration: const BoxDecoration(
                          color: Color(0XFFF0C708),
                        ),
                        child: const Column(
                          children: [
                            Text(
                              "PLANO START",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "500 MEGA",
                              style: TextStyle(
                                  fontSize: 45, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 300,
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text("apenas"),
                                Text("R\$"),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
