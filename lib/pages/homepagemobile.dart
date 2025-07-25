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
import 'package:velocity_net/modules/plans/repository/monteseucombo.dart' hide SelectedApp, SelectedCombo;
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

  void updateSelectedCombo(SelectedCombo combo) {
    setState(() {
      selectedCombo = combo;
      showSummary = combo.mega.isNotEmpty;
    });
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
                        'Planos para Empresas',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: isMobile ? 24 : 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DefaultTabController(
                      length: 1, // Apenas 1 aba
                      child: Column(
                        children: [
                          // TabBar invisível mas necessária
                          Visibility(
                            visible: false,
                            maintainSize: false,
                            maintainAnimation: false,
                            maintainState: false,
                            child: SizedBox(
                              height: 0,
                              child: TabBar(
                                tabs: [
                                  Tab(text: 'PARA EMPRESA'),
                                ],
                              ),
                            ),
                          ),
                          // Conteúdo da aba
                          SizedBox(
                            height: isMobile ? 1490 : 850,
                            child: TabBarView(
                              children: [
                                const Paraempresa(),
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
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
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}