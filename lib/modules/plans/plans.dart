import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_net/modules/plans/repository/monteseucombo.dart';
import 'package:velocity_net/modules/plans/repository/paraempresa.dart';

const Color primaryDarkColor = Color(0xFFFFFFFF);
const Color primaryLightColor = Color(0xff08203E);
const Color accentColor = Color(0xFFE3F2FD);
const Color borderColor = Color(0xFFE0E0E0);
const Color textColor = Color(0xFF1A237E);
const Color disabledColor = Color(0xFFBDBDBD);

class PlansComponent extends StatefulWidget {
  const PlansComponent({super.key});

  @override
  State<PlansComponent> createState() => _PlansComponentState();
}

class _PlansComponentState extends State<PlansComponent> {
  List<dynamic> telecinePlans = [];
  List<dynamic> maxPlans = [];
  List<dynamic> premierePlans = [];
  List<dynamic> deezerPlans = [];
  List<dynamic> globoplayPlans = [];

  bool isLoadingTelecine = true;
  bool isLoadingMax = true;
  bool isLoadingPremiere = true;
  bool isLoadingDeezer = true;
  bool isLoadingGloboplay = true;

  String getImageUrl(String path) {
    const String baseUrl = 'https://api.velocitynet.com.br/api/v1/uploads/';
    return '$baseUrl$path';
  }

  Future<void> fetchPlans(String keyword, void Function(List<dynamic>) setter,
      void Function() stopLoading) async {
    final Uri uri =
        Uri.parse("https://api.velocitynet.com.br/api/v1/category-plan");
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final filtered = data.where((item) {
          final nome = (item['nome'] ?? '').toString().toLowerCase();
          return nome.contains(keyword);
        }).toList();
        setState(() {
          setter(filtered);
          stopLoading();
        });
      } else {
        stopLoading();
      }
    } catch (e) {
      stopLoading();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPlans('telecine', (list) => telecinePlans = list,
        () => isLoadingTelecine = false);
    fetchPlans('max', (list) => maxPlans = list, () => isLoadingMax = false);
    fetchPlans('premiere', (list) => premierePlans = list,
        () => isLoadingPremiere = false);
    fetchPlans(
        'deezer', (list) => deezerPlans = list, () => isLoadingDeezer = false);
    fetchPlans('globoplay', (list) {
      globoplayPlans = list
          .where((e) =>
              !(e['nome'] ?? '').toString().toLowerCase().contains('canais'))
          .toList();
    }, () => isLoadingGloboplay = false);
  }

  Widget _buildPlansList(List<dynamic> plans, bool isMobile) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: plans.length,
      itemBuilder: (context, index) {
        final plan = plans[index];
        final List<dynamic> images = plan['images'] ?? [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            SizedBox(
              height: isMobile ? 600 : 600,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemBuilder: (context, i) {
                  final imgUrl = getImageUrl(images[i]);
                  return Container(
                    width: isMobile ? 250 : 280,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: borderColor,
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: primaryDarkColor.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        imgUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: accentColor,
                          alignment: Alignment.center,
                          child: Icon(Icons.broken_image,
                              size: 40, color: primaryDarkColor),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
          ],
        );
      },
    );
  }

  Widget _buildTab(
      bool isLoading, List<dynamic> plans, String title, bool isMobile) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: primaryDarkColor),
      );
    }
    if (plans.isEmpty) {
      return Center(
        child: Text(
          'Nenhum plano $title encontrado.',
          style: GoogleFonts.poppins(
            color: textColor,
            fontSize: isMobile ? 14 : 16,
          ),
        ),
      );
    }
    return _buildPlansList(plans, isMobile);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Center(
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        padding: EdgeInsets.all(isMobile ? 15 : 30),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: isMobile ? 30 : 45),
              child: Text(
                'Escolha o melhor plano para você!',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: isMobile ? 24 : 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DefaultTabController(
              length: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 400,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color.fromARGB(255, 0, 89, 255),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: TabBar(
                          tabAlignment: TabAlignment.center,
                          indicator: const UnderlineTabIndicator(
                            borderSide: BorderSide(
                              width: 3.0,
                              color: Color.fromARGB(255, 0, 89, 255),
                            ),
                          ),
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.black54,
                          labelStyle: GoogleFonts.poppins(
                            fontSize: isMobile ? 13 : 14,
                            fontWeight: FontWeight.w600,
                          ),
                          unselectedLabelStyle: GoogleFonts.poppins(
                            fontSize: isMobile ? 13 : 15,
                            fontWeight: FontWeight.normal,
                          ),
                          isScrollable: true,
                          dividerColor: Colors.transparent,
                          tabs: const [
                            Tab(text: 'PARA VOCÊ'),
                            Tab(text: 'PARA EMPRESA'),
                            Tab(text: '+TELECINE'),
                            Tab(text: '+MAX'),
                            Tab(text: '+PREMIERE'),
                            Tab(text: '+DEEZER'),
                            Tab(text: '+GLOBOPLAY'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: isMobile ? 1400 : 640,
                    child: TabBarView(
                      children: [
                        Monteseucombo(onComboSelected: (SelectedCombo ) {  },),
                        Paraempresa(),
                        _buildTab(
                            isLoadingTelecine, telecinePlans, '+TELECINE', isMobile),
                        _buildTab(isLoadingMax, maxPlans, '+MAX', isMobile),
                        _buildTab(
                            isLoadingPremiere, premierePlans, '+PREMIERE', isMobile),
                        _buildTab(isLoadingDeezer, deezerPlans, '+DEEZER', isMobile),
                        _buildTab(
                            isLoadingGloboplay, globoplayPlans, '+GLOBOPLAY', isMobile),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: isMobile ? 50 : 100),
          ],
        ),
      ),
    );
  }
}
