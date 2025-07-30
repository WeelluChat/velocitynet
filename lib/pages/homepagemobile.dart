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

  void _updateSelectedCombo(SelectedCombo combo) {
    setState(() {
      selectedCombo = combo;
      showSummary = combo.mega.isNotEmpty || combo.apps.isNotEmpty;
    });
  }

  void _removeApp(int index) {
    if (selectedCombo == null ||
        selectedCombo!.apps.isEmpty ||
        index >= selectedCombo!.apps.length) return;

    setState(() {
      final apps = List<SelectedApp>.from(selectedCombo!.apps);
      apps.removeAt(index);

      final newTotal = selectedCombo!.megaPrice +
          apps.fold<int>(0, (sum, app) => sum + app.price);

      selectedCombo = SelectedCombo(
        mega: selectedCombo!.mega,
        megaPrice: selectedCombo!.megaPrice,
        apps: apps,
        total: newTotal,
        isVisible: selectedCombo!.isVisible,
      );

      showSummary = selectedCombo!.apps.isNotEmpty ||
          (selectedCombo!.mega.isNotEmpty && selectedCombo!.mega != "");

      _updateSelectedCombo(selectedCombo!);
    });
  }

  void _removeInternet() {
    if (selectedCombo == null || selectedCombo!.mega.isEmpty) return;

    setState(() {
      final apps = List<SelectedApp>.from(selectedCombo!.apps);
      final appsTotal = apps.fold<int>(0, (sum, app) => sum + app.price);

      selectedCombo = SelectedCombo(
        mega: '',
        megaPrice: 0,
        apps: apps,
        total: appsTotal,
        isVisible: selectedCombo!.isVisible,
      );

      showSummary = selectedCombo!.apps.isNotEmpty;
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
                decoration: const BoxDecoration(color: Color.fromARGB(255, 246, 250, 253)),
                padding: EdgeInsets.all(isMobile ? 15 : 30),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: isMobile ? 30 : 45),
                      child: Text(
                        'Venha ser Velocity',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: isMobile ? 24 : 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DefaultTabController(
                      length: 3,
                      child: Column(
                        children: [
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
                          SizedBox(
                            height: isMobile ? 1072 : 850,
                            child: TabBarView(
                              children: [
                                Paraempresa(
                                  onComboUpdated: (combo) {
                                    _updateSelectedCombo(combo);
                                  },
                                  selectedCombo: selectedCombo,
                                  onRemoveApp: _removeApp,
                                  onRemoveInternet: _removeInternet,
                                ), // Paraempresa
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    /*  */
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
          border: Border(top: BorderSide(color: Colors.grey.shade300)),
        ),
        constraints: BoxConstraints(
          maxHeight: isMobile
              ? MediaQuery.of(context).size.height * 0.80
              : MediaQuery.of(context).size.height * 0.40,
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
                    fontSize: isMobile ? 16 : 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF052D53),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey),
                  tooltip: 'Fechar',
                  iconSize: 20,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      showSummary = false;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),

            if (selectedCombo != null) ...[
              // INTERNET
              if (selectedCombo!.mega.isNotEmpty)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: _buildSummaryItem(
                        isMobile,
                        'INTERNET ${selectedCombo!.mega} Megas',
                        'R\$ ${selectedCombo!.megaPrice},99',
                        const Color(0xFF0A84FF),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close,
                          color: Colors.redAccent, size: 18),
                      onPressed: _removeInternet,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),

              // APPS
              if (selectedCombo!.apps.isNotEmpty) ...[
                const SizedBox(height: 6),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: isMobile ? 90 : 150,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: selectedCombo!.apps.asMap().entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  entry.value.name,
                                  style: GoogleFonts.poppins(
                                    fontSize: isMobile ? 13 : 14,
                                    height: 1.2,
                                    color: const Color(0xFF555555),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.close,
                                    color: Colors.redAccent, size: 18),
                                onPressed: () => _removeApp(entry.key),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Divider(thickness: 1, color: Color(0xFFE0E0E0)),
              ),

              _buildSummaryItem(
                isMobile,
                'Total mensal:',
                'R\$ ${selectedCombo!.total},99',
                const Color(0xFF00C853),
                isTotal: true,
              ),
            ],

            const SizedBox(height: 10),

            // BOTÃO CONTRATAR
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF25D366),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 3,
                ),
                onPressed: selectedCombo != null &&
                        selectedCombo!.mega.isNotEmpty
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
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Contratar agora',
                      style: GoogleFonts.poppins(
                        fontSize: isMobile ? 14 : 16,
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


  Widget _buildSummaryItem(
      bool isMobile, String title, String value, Color valueColor,
      {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: isMobile ? (isTotal ? 16 : 15) : (isTotal ? 18 : 17),
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
              color: const Color(0xFF333333),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: isMobile ? (isTotal ? 18 : 16) : (isTotal ? 20 : 18),
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}