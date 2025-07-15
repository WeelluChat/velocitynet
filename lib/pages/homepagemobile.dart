import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_net/modules/benefits/tv.dart';
import 'package:velocity_net/modules/description/description.dart';
import 'package:velocity_net/modules/footer/footer.dart';
import 'package:velocity_net/modules/plans/repository/Paraempresa.dart';
import 'package:velocity_net/modules/plans/repository/monteseucombo.dart';
import 'package:velocity_net/modules/questions/questions.dart';
import 'package:velocity_net/modules/slider/slider.dart';

const Color primaryDarkColor = Color(0xFFFFFFFF);
const Color primaryLightColor = Color(0xff08203E);
const Color accentColor = Color(0xFFE3F2FD);
const Color borderColor = Color(0xFFE0E0E0);
const Color textColor = Color(0xFF1A237E);
const Color disabledColor = Color(0xFFBDBDBD);

class Homepagemobile extends StatefulWidget {
  final ScrollController scrollController;

  const Homepagemobile({super.key, required this.scrollController});

  @override
  State<Homepagemobile> createState() => _HomepagemobileState();
}

class _HomepagemobileState extends State<Homepagemobile> {
  SelectedCombo? selectedCombo;
  bool showSummary = false;
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

  void updateSelectedCombo(SelectedCombo combo) {
    setState(() {
      selectedCombo = combo;
      showSummary = combo.mega.isNotEmpty;
    });
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
        () => setState(() => isLoadingTelecine = false));
    fetchPlans('max', (list) => maxPlans = list,
        () => setState(() => isLoadingMax = false));
    fetchPlans('premiere', (list) => premierePlans = list,
        () => setState(() => isLoadingPremiere = false));
    fetchPlans('deezer', (list) => deezerPlans = list,
        () => setState(() => isLoadingDeezer = false));
    fetchPlans('globoplay', (list) {
      globoplayPlans = list
          .where((e) =>
              !(e['nome'] ?? '').toString().toLowerCase().contains('canais'))
          .toList();
      setState(() => isLoadingGloboplay = false);
    }, () {});
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Scaffold(
      bottomNavigationBar:
          (showSummary && isMobile) ? _buildSummaryBottomBar(isMobile) : null,
      body: SingleChildScrollView(
        controller: widget.scrollController,
        child: Column(
          children: [
            const SliderComponent(),
            Center(
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
                            height: isMobile ? 1100 : 791,
                            child: TabBarView(
                              children: [
                                Monteseucombo(
                                  onComboSelected: updateSelectedCombo,
                                  initialCombo: selectedCombo,
                                ),
                                const Paraempresa(),
                                _buildTab(isLoadingTelecine, telecinePlans,
                                    '+TELECINE', isMobile),
                                _buildTab(
                                    isLoadingMax, maxPlans, '+MAX', isMobile),
                                _buildTab(isLoadingPremiere, premierePlans,
                                    '+PREMIERE', isMobile),
                                _buildTab(isLoadingDeezer, deezerPlans,
                                    '+DEEZER', isMobile),
                                _buildTab(isLoadingGloboplay, globoplayPlans,
                                    '+GLOBOPLAY', isMobile),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: isMobile ? 50 : 10),
                  ],
                ),
              ),
            ),
            const Descrption(),
            const Tv(),
            const Questions(),
            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryBottomBar(bool isMobile) {
    return AnimatedSlide(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
      offset: showSummary ? Offset.zero : const Offset(0, 1),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 400),
        opacity: showSummary ? 1 : 0,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, -4),
              ),
            ],
            border: Border(top: BorderSide(color: Colors.grey.shade300)),
          ),
          constraints: BoxConstraints(
            maxHeight: isMobile
                ? MediaQuery.of(context).size.height * 0.35 + 51
                : MediaQuery.of(context).size.height * 0.45,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Cabeçalho
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Resumo do Plano',
                    style: GoogleFonts.poppins(
                      fontSize: isMobile ? 18 : 20,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF052D53),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    tooltip: 'Fechar',
                    onPressed: () {
                      setState(() {
                        showSummary = false;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (selectedCombo != null) ...[
                // Internet
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'INTERNET ${selectedCombo!.mega} Megas',
                      style: GoogleFonts.poppins(
                        fontSize: isMobile ? 15 : 17,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF333333),
                      ),
                    ),
                    Text(
                      'R\$ ${selectedCombo!.megaPrice},99',
                      style: GoogleFonts.poppins(
                        fontSize: isMobile ? 15 : 17,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0A84FF),
                      ),
                    ),
                  ],
                ),
                if (selectedCombo!.apps.isNotEmpty) ...[
                  const SizedBox(height: 3),
                  // Scroll das streamings
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: isMobile ? 70 : 220,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children:
                            selectedCombo!.apps.asMap().entries.map((entry) {
                          final index = entry.key;
                          final app = entry.value;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 1),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    app.name,
                                    style: GoogleFonts.poppins(
                                      fontSize: isMobile ? 13 : 15,
                                      height: 1.1,
                                      color: const Color(0xFF555555),
                                    ),
                                  ),
                                ),
                                Text(
                                  'R\$ ${app.price},00',
                                  style: GoogleFonts.poppins(
                                    fontSize: isMobile ? 13 : 15,
                                    fontWeight: FontWeight.w600,
                                    height: 1.1,
                                    color: const Color(0xFF0A84FF),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    final monteseucomboState =
                                        Monteseucombo.of(context);
                                    if (monteseucomboState != null) {
                                      monteseucomboState
                                          .removeAppSelection(app.name);
                                    }
                                    setState(() {
                                      final apps =
                                          List<SelectedApp>.from(selectedCombo!.apps);
                                      apps.removeAt(index);
                                      final newTotal = selectedCombo!.megaPrice +
                                          apps.fold<int>(0, (sum, app) => sum + app.price);
                                      selectedCombo = SelectedCombo(
                                        mega: selectedCombo!.mega,
                                        megaPrice: selectedCombo!.megaPrice,
                                        apps: apps,
                                        total: newTotal,
                                      );
                                      showSummary = selectedCombo!.apps.isNotEmpty ||
                                          selectedCombo!.mega.isNotEmpty;
                                    });
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Icon(Icons.close,
                                        color: Colors.redAccent, size: 18),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                const Divider(thickness: 1, color: Color(0xFFE0E0E0)),
                const SizedBox(height: 10),
                // Total
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total mensal:',
                      style: GoogleFonts.poppins(
                        fontSize: isMobile ? 16 : 18,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF333333),
                      ),
                    ),
                    Text(
                      'R\$ ${selectedCombo!.total},99',
                      style: GoogleFonts.poppins(
                        fontSize: isMobile ? 18 : 20,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF00C853),
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 12),
              // Botão contratar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF25D366),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4,
                  ),
                  onPressed: selectedCombo != null
                      ? () {
                          final message = selectedCombo!.apps.isEmpty
                              ? 'Olá, gostaria de contratar o plano de ${selectedCombo!.mega} Mega'
                              : 'Olá, gostaria de contratar o plano de ${selectedCombo!.mega} Mega com '
                                  '${selectedCombo!.apps.map((app) => app.name).join(', ')}';
                          launchUrl(Uri.parse(
                            "https://api.whatsapp.com/send?phone=+5594992600430&text=${Uri.encodeComponent(message)}",
                          ));
                        }
                      : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PhosphorIcon(
                        PhosphorIcons.whatsappLogo(),
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Contratar agora',
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 16 : 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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

  String getImageUrl(String path) {
    const String baseUrl = 'https://api.velocitynet.com.br/api/v1/uploads/';
    return '$baseUrl$path';
  }
}
