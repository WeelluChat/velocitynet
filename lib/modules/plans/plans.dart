import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:velocity_net/constants/api_constants.dart';
import 'package:velocity_net/helpers/url.dart';
import 'package:velocity_net/service/api.dart';

class PlansComponent extends StatefulWidget {
  const PlansComponent({super.key});

  @override
  State<PlansComponent> createState() => _PlansComponentState();
}

class _PlansComponentState extends State<PlansComponent> {
  List<String> plansList = [];

  plans() async {
    final plansData = await Api().getPlans();
    final List<dynamic> jsonData = json.decode(plansData);
    for (final item in jsonData) {
      if (item is Map<String, dynamic> && item.containsKey('name')) {
        plansList.add("${ApiConstants.baseUrlUploads}/${item['name']}");
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    plans();
  }

  bool isVisibleConnect = true;
  bool isVisibleStart = false;
  bool isVisiblePrime = false;
  bool isVisibleFamily = false;
  bool isVisibleConnectPlus = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      // margin: const EdgeInsets.only(top: 45),
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
          SizedBox(
            width: 1120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      isVisibleConnect = !isVisibleConnect;
                      isVisibleFamily = false;
                      isVisibleConnectPlus = false;
                      isVisibleStart = false;
                      isVisiblePrime = false;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: isVisibleConnect == true
                            ? const Color(0xffF1F1F1)
                            : Colors.white,
                        border: Border(
                          top: BorderSide(
                            color: isVisibleConnect == true
                                ? Colors.white
                                : const Color(0xffF1F1F1),
                          ),
                          left: BorderSide(
                            color: isVisibleConnect == true
                                ? Colors.white
                                : const Color(0xffF1F1F1),
                          ),
                          right: BorderSide(
                            color: isVisibleConnect == true
                                ? Colors.white
                                : const Color(0xffF1F1F1),
                          ),
                        ),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    padding: const EdgeInsets.only(
                        left: 70, right: 70, top: 15, bottom: 10),
                    child: const Text(
                      'Connect',
                      style: TextStyle(
                          fontSize: 22,
                          color: Color(0xff00244E),
                          fontWeight: FontWeight.bold),
                      // style: GoogleFonts.getFont('Poppins',
                      //     color: isVisibleHoje == true
                      //         ? ColorsDashboard().white
                      //         : ColorsDashboard().grey,
                      //     fontSize: 15,
                      //     fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isVisibleStart = !isVisibleStart;
                      isVisibleFamily = false;
                      isVisibleConnectPlus = false;
                      isVisibleConnect = false;
                      isVisiblePrime = false;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isVisibleStart == true
                          ? const Color(0xffF1F1F1)
                          : Colors.white,
                      border: Border(
                        top: BorderSide(
                          color: isVisibleStart == true
                              ? Colors.white
                              : const Color(0xffF1F1F1),
                        ),
                        left: BorderSide(
                          color: isVisibleStart == true
                              ? Colors.white
                              : const Color(0xffF1F1F1),
                        ),
                        right: BorderSide(
                          color: isVisibleStart == true
                              ? Colors.white
                              : const Color(0xffF1F1F1),
                        ),
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    padding: const EdgeInsets.only(
                        left: 70, right: 70, top: 15, bottom: 10),
                    child: const Text(
                      'Start',
                      style: TextStyle(
                          fontSize: 22,
                          color: Color(0xff00244E),
                          fontWeight: FontWeight.bold),
                      // style: GoogleFonts.getFont('Poppins',
                      //     color: isVisibleMensal == true
                      //         ? ColorsDashboard().white
                      //         : ColorsDashboard().grey,
                      //     fontSize: 15,
                      //     fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isVisiblePrime = !isVisiblePrime;
                      isVisibleFamily = false;
                      isVisibleConnectPlus = false;
                      isVisibleConnect = false;
                      isVisibleStart = false;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: isVisiblePrime == true
                            ? const Color(0xffF1F1F1)
                            : Colors.white,
                        border: Border(
                          top: BorderSide(
                            color: isVisiblePrime == true
                                ? Colors.white
                                : const Color(0xffF1F1F1),
                          ),
                          left: BorderSide(
                            color: isVisiblePrime == true
                                ? Colors.white
                                : const Color(0xffF1F1F1),
                          ),
                          right: BorderSide(
                            color: isVisiblePrime == true
                                ? Colors.white
                                : const Color(0xffF1F1F1),
                          ),
                        ),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    padding: const EdgeInsets.only(
                        left: 70, right: 70, top: 15, bottom: 10),
                    child: const Text(
                      'Prime',
                      style: TextStyle(
                          fontSize: 22,
                          color: Color(0xff00244E),
                          fontWeight: FontWeight.bold),
                      // style: GoogleFonts.getFont('Poppins',
                      //     color: isVisibleAnual == true
                      //         ? ColorsDashboard().white
                      //         : ColorsDashboard().grey,
                      //     fontSize: 15,
                      //     fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isVisibleFamily = !isVisibleFamily;
                      isVisiblePrime = false;
                      isVisibleConnectPlus = false;
                      isVisibleConnect = false;
                      isVisibleStart = false;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: isVisibleFamily == true
                            ? const Color(0xffF1F1F1)
                            : Colors.white,
                        border: Border(
                          top: BorderSide(
                            color: isVisibleFamily == true
                                ? Colors.white
                                : const Color(0xffF1F1F1),
                          ),
                          left: BorderSide(
                            color: isVisibleFamily == true
                                ? Colors.white
                                : const Color(0xffF1F1F1),
                          ),
                          right: BorderSide(
                            color: isVisibleFamily == true
                                ? Colors.white
                                : const Color(0xffF1F1F1),
                          ),
                        ),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    padding: const EdgeInsets.only(
                        left: 70, right: 70, top: 15, bottom: 10),
                    child: const Text(
                      'Family',
                      style: TextStyle(
                          fontSize: 22,
                          color: Color(0xff00244E),
                          fontWeight: FontWeight.bold),
                      //   style: GoogleFonts.getFont('Poppins',
                      //       color: isVisibleTotal == true
                      //           ? ColorsDashboard().white
                      //           : ColorsDashboard().grey,
                      //       fontSize: 15,
                      //       fontWeight: FontWeight.w500),
                      // ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isVisibleConnectPlus = !isVisibleConnectPlus;
                      isVisiblePrime = false;
                      isVisibleFamily = false;
                      isVisibleConnect = false;
                      isVisibleStart = false;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isVisibleConnectPlus == true
                          ? const Color(0xffF1F1F1)
                          : Colors.white,
                      border: Border(
                        top: BorderSide(
                          color: isVisibleConnectPlus == true
                              ? Colors.white
                              : const Color(0xffF1F1F1),
                        ),
                        left: BorderSide(
                          color: isVisibleConnectPlus == true
                              ? Colors.white
                              : const Color(0xffF1F1F1),
                        ),
                        right: BorderSide(
                          color: isVisibleConnectPlus == true
                              ? Colors.white
                              : const Color(0xffF1F1F1),
                        ),
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    padding: const EdgeInsets.only(
                        left: 70, right: 70, top: 15, bottom: 10),
                    child: const Text(
                      'Connect Plus',
                      style: TextStyle(
                          fontSize: 22,
                          color: Color(0xff00244E),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: const Color(0xffF1F1F1),
            width: 1120,
            height: 600,
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: plansList.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  width: 300,
                  child: Column(
                    children: [
                      Image.network(
                        plansList[index],
                        height: 500,
                      ),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
