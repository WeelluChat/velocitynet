import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:velocity_net/constants/api_constants.dart';
import 'package:velocity_net/helpers/url.dart';
import 'package:velocity_net/modules/plans/mount_your_card.dart';
import 'package:velocity_net/modules/plans/mounted_card.dart';
import 'package:velocity_net/modules/plans/preview_card.dart';
import 'package:velocity_net/service/api.dart';

class PlansComponent extends StatefulWidget {
  const PlansComponent({super.key});

  @override
  State<PlansComponent> createState() => _PlansComponentState();
}

class _PlansComponentState extends State<PlansComponent>
    with SingleTickerProviderStateMixin {
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

  bool isVisibleConnect = true;
  bool isVisibleStart = false;
  bool isVisiblePrime = false;
  bool isVisibleFamily = false;
  bool isVisibleConnectPlus = false;

  // void _handlePageViewChanged(int currentPageIndex) {
  //   _tabController.index = currentPageIndex;
  //   setState(() {
  //     _currentPageIndex = currentPageIndex;
  //   });
  // }

  // void _updateCurrentPageIndex(int index) {
  //   _tabController.index = index;
  //   _pageViewController.animateToPage(
  //     index,
  //     duration: const Duration(milliseconds: 400),
  //     curve: Curves.easeInOut,
  //   );
  // }

  // late PageController _pageViewController;
  late TabController _tabController;
  // int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    plans();
    // _pageViewController = PageController();
    _tabController = TabController(length: 5, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      // margin: const EdgeInsets.only(top: 45),
      child: Column(children: [
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
          color: Colors.white,
          width: 1100,
          child: TabBar(
            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            controller: _tabController,
            indicatorColor: Colors.transparent,
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(
              fontSize: 16,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 16,
            ),
            indicator: const BoxDecoration(
              color: Color(0xffF1F1F1),
            ),
            tabs: <Widget>[
              Tab(
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 70,
                    right: 70,
                  ),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Color(0xFFf1f1f1), width: 1),
                      left: BorderSide(color: Color(0xFFf1f1f1), width: 1),
                      right: BorderSide(color: Color(0xFFf1f1f1), width: 1),
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'Monte seu plano',
                    style: TextStyle(
                        fontSize: 15,
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
              Tab(
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 70,
                    right: 70,
                  ),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Color(0xFFf1f1f1), width: 1),
                      left: BorderSide(color: Color(0xFFf1f1f1), width: 1),
                      right: BorderSide(color: Color(0xFFf1f1f1), width: 1),
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'Connect',
                    style: TextStyle(
                        fontSize: 15,
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
              Tab(
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 70,
                    right: 70,
                  ),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Color(0xFFf1f1f1), width: 1),
                      left: BorderSide(color: Color(0xFFf1f1f1), width: 1),
                      right: BorderSide(color: Color(0xFFf1f1f1), width: 1),
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'Start',
                    style: TextStyle(
                        fontSize: 15,
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
              Tab(
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 70,
                    right: 70,
                  ),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Color(0xFFf1f1f1), width: 1),
                      left: BorderSide(color: Color(0xFFf1f1f1), width: 1),
                      right: BorderSide(color: Color(0xFFf1f1f1), width: 1),
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'Prime',
                    style: TextStyle(
                        fontSize: 15,
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
              Tab(
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 70,
                    right: 70,
                  ),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Color(0xFFf1f1f1), width: 1),
                      left: BorderSide(color: Color(0xFFf1f1f1), width: 1),
                      right: BorderSide(color: Color(0xFFf1f1f1), width: 1),
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'Family',
                    style: TextStyle(
                        fontSize: 15,
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
              Tab(
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 70,
                    right: 70,
                  ),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Color(0xFFf1f1f1), width: 1),
                      left: BorderSide(color: Color(0xFFf1f1f1), width: 1),
                      right: BorderSide(color: Color(0xFFf1f1f1), width: 1),
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'Connect Plus',
                    style: TextStyle(
                        fontSize: 15,
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
          width: 1070,
          height: 700,
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(
                    left: 60, right: 40, top: 20, bottom: 20),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    MountYourCard(),
                    SizedBox(
                      width: 40,
                    ),
                    MountedCard(),
                    SizedBox(
                      width: 40,
                    ),
                    PreviewCard(),
                  ],
                ),
              ),
              Container(
                  width: double.infinity,
                  color: const Color(0xffF1F1F1),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        width: 300,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "assets/plans/novo_card.png",
                                width: 300,
                                // height: 600,
                                fit: BoxFit.cover,
                              ),
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
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        width: 300,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "assets/plans/novo_card.png",
                                width: 300,
                                // height: 600,
                                fit: BoxFit.cover,
                              ),
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
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        width: 300,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "assets/plans/novo_card.png",
                                width: 300,
                                // height: 600,
                                fit: BoxFit.cover,
                              ),
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
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        width: 300,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "assets/plans/novo_card.png",
                                width: 300,
                                // height: 600,
                                fit: BoxFit.cover,
                              ),
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
                      ),
                    ],
                  )),
              Container(color: Colors.green),
              Container(color: Colors.red),
              Container(color: Colors.orange),
              Container(color: Colors.deepOrangeAccent),
            ],
          ),
          // ListView.builder(
          //   padding: const EdgeInsets.only(left: 30, right: 30, top: 15),
          //   shrinkWrap: true,
          //   scrollDirection: Axis.horizontal,
          //   itemCount: plansList.length,
          //   itemBuilder: (context, index) {
          //     return Container(
          //       padding: const EdgeInsets.only(left: 10, right: 10),
          //       width: 300,
          //       child: Column(
          //         children: [
          //           Image.network(
          //             plansList[index],
          //             height: 500,
          //           ),
          //           SizedBox(
          //             height: 50,
          //             width: double.infinity,
          //             child: ElevatedButton(
          //               style: ButtonStyle(
          //                 shape: MaterialStateProperty.all<
          //                     RoundedRectangleBorder>(
          //                   RoundedRectangleBorder(
          //                     borderRadius: BorderRadius.circular(5),
          //                   ),
          //                 ),
          //                 backgroundColor: MaterialStateProperty.all(
          //                     const Color(0xffFFB000)),
          //               ),
          //               onPressed: () {
          //                 Url().urlWhatsApp();
          //               },
          //               child: const Text(
          //                 "ASSINE AGORA",
          //                 style: TextStyle(
          //                     color: Color(0XFF13294E),
          //                     fontWeight: FontWeight.bold),
          //               ),
          //             ),
          //           )
          //         ],
          //       ),
          //     );
          //   },
          // ),
        ),
      ]),
    );
  }
}
