import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:velocity_net/constants/api_constants.dart';
import 'package:velocity_net/helpers/url.dart';

class PlansComponent extends StatefulWidget {
  const PlansComponent({super.key});

  @override
  State<PlansComponent> createState() => _PlansComponentState();
}

class _PlansComponentState extends State<PlansComponent>
    with SingleTickerProviderStateMixin {
  List<String> plansList = [];

  bool isVisibleConnect = true;
  bool isVisibleStart = false;
  bool isVisiblePrime = false;
  bool isVisibleFamily = false;
  bool isVisibleConnectPlus = false;

  List<dynamic> jsonDate = [];

  int lengtDate = 0;

  late TabController _tabController;

  getCategoryPlans() async {
    final Uri uri = Uri.parse("${ApiConstants.baseApi}/category-plan");

    var dados = await http.get(uri
        // headers: {
        //   "Content-Type": "application/json",
        //   "Authorization":
        //       "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1ZTYwZWRkY2ExZWI5MzM0NzYyZDdlOCIsImVtYWlsIjoidmVsb2NpdHluZXRmaW5hbmNlaXJvQGdtYWlsLmNvbSIsImlhdCI6MTcxNTg4NjQzOH0.2zY2kHTrf2KTWKgH0JyL24BNDcSqxiyXYRJ_fmuzBoA",
        // },
        );
    setState(() {
      jsonDate = json.decode(dados.body);
      lengtDate = jsonDate.length;
      _tabController =
          TabController(length: lengtDate, vsync: this, initialIndex: 0);
    });
  }

  @override
  void initState() {
    super.initState();
    getCategoryPlans();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (jsonDate.isEmpty) {
      return const CircularProgressIndicator();
    }

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(15),
        width: double.infinity,
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
              color: Colors.white,
              width: 1100,
              child: TabBar(
                dividerColor: Colors.transparent,
                overlayColor: const WidgetStatePropertyAll(Colors.transparent),
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
                  // Tab(
                  //   child: Container(
                  //     padding: const EdgeInsets.only(
                  //       left: 70,
                  //       right: 70,
                  //     ),
                  //     alignment: Alignment.center,
                  //     decoration: const BoxDecoration(
                  //       border: Border(
                  //         top: BorderSide(color: Color(0xFFf1f1f1), width: 1),
                  //         left: BorderSide(color: Color(0xFFf1f1f1), width: 1),
                  //         right: BorderSide(color: Color(0xFFf1f1f1), width: 1),
                  //       ),
                  //       borderRadius: BorderRadius.only(
                  //         topLeft: Radius.circular(5),
                  //         topRight: Radius.circular(5),
                  //       ),
                  //     ),
                  //     child: const Text(
                  //       'Monte seu plano',
                  //       style: TextStyle(
                  //           fontSize: 15,
                  //           color: Color(0xff00244E),
                  //           fontWeight: FontWeight.bold),
                  //       // style: GoogleFonts.getFont('Poppins',
                  //       //     color: isVisibleHoje == true
                  //       //         ? ColorsDashboard().white
                  //       //         : ColorsDashboard().grey,
                  //       //     fontSize: 15,
                  //       //     fontWeight: FontWeight.w500),
                  //     ),
                  //   ),
                  // ),
                  ...jsonDate.map((e) {
                    setState(() {});

                    return Tab(
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: 70,
                          right: 70,
                        ),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Color(0xFFf1f1f1), width: 1),
                            left:
                                BorderSide(color: Color(0xFFf1f1f1), width: 1),
                            right:
                                BorderSide(color: Color(0xFFf1f1f1), width: 1),
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                          ),
                        ),
                        child: Text(
                          e['nome'],
                          style: const TextStyle(
                              fontSize: 15,
                              color: Color(0xff00244E),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  })
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
                  // const GroupMontedPlan(),
                  ...jsonDate.map((e) {
                    List<dynamic> imagens = e['images'];

                    return SizedBox(
                      height: 400,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: imagens.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            width: 320,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(
                                    "${ApiConstants.baseUrlUploads}/${imagens[index]}", // Acesse imagens[index] em vez de e[index]["images"]
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: WidgetStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      backgroundColor: WidgetStateProperty.all(
                                          const Color(0xffFFB000)),
                                    ),
                                    onPressed: () {
                                      Url().urlWhatsApp();
                                    },
                                    child: const Text(
                                      "Entre em contato",
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
                    );
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
