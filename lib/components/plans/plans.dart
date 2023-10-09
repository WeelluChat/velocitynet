import 'package:flutter/material.dart';
import 'package:velocity_net/helpers/url.dart';

class PlansComponent extends StatefulWidget {
  const PlansComponent({super.key});

  @override
  State<PlansComponent> createState() => _PlansComponentState();
}

class _PlansComponentState extends State<PlansComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1550,
      // margin: const EdgeInsets.only(top: 45),
      padding: const EdgeInsets.only(top: 50, bottom: 50, left: 20, right: 20),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 45),
            child: Text(
              'Escolha o melhor plano para você!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: MediaQuery.of(context).size.width < 600 ? 30 : 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            height: 578,
            child: ListView(
              padding: const EdgeInsets.only(left: 20, right: 20),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  width: 300,
                  child: Column(
                    children: [
                      Image.asset("plans/plano1.png"),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xffFFB000)),
                          ),
                          onPressed: () {
                            Url().urlWhatsApp();
                          },
                          child: const Text(
                            "ASSINE AGORA",
                            style: TextStyle(
                                color: Color(0XFF13294E),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  width: 300,
                  height: 550,
                  child: Column(
                    children: [
                      Image.asset("plans/plano1.png"),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xffFFB000)),
                          ),
                          onPressed: () {
                            Url().urlWhatsApp();
                          },
                          child: const Text(
                            "ASSINE AGORA",
                            style: TextStyle(
                                color: Color(0XFF13294E),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  width: 300,
                  child: Column(
                    children: [
                      Image.asset("plans/plano1.png"),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xffFFB000)),
                          ),
                          onPressed: () {
                            Url().urlWhatsApp();
                          },
                          child: const Text(
                            "ASSINE AGORA",
                            style: TextStyle(
                                color: Color(0XFF13294E),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  width: 300,
                  child: Column(
                    children: [
                      Image.asset("plans/plano1.png"),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xffFFB000)),
                          ),
                          onPressed: () {
                            Url().urlWhatsApp();
                          },
                          child: const Text(
                            "ASSINE AGORA",
                            style: TextStyle(
                                color: Color(0XFF13294E),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  width: 300,
                  child: Column(
                    children: [
                      Image.asset("plans/plano1.png"),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xffFFB000)),
                          ),
                          onPressed: () {
                            Url().urlWhatsApp();
                          },
                          child: const Text(
                            "ASSINE AGORA",
                            style: TextStyle(
                                color: Color(0XFF13294E),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
