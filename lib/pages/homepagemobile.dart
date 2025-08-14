import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; // 👈 Adicione esta importação
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:universal_html/html.dart' as html;
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_net/modules/benefits/tv.dart';
import 'package:velocity_net/modules/description/description.dart';
import 'package:velocity_net/modules/footer/footer.dart';
import 'package:velocity_net/modules/plans/repository/Paraempresa.dart';
import 'package:velocity_net/modules/plans/repository/selectedapp.dart';
import 'package:velocity_net/modules/questions/questions.dart';
import 'package:velocity_net/modules/slider/slider.dart';
import 'package:velocity_net/pages/pdf.dart';
import 'package:velocity_net/pages/previewpdf.dart';

const Color primaryDarkColor = Color(0xFFFFFFFF);
const Color primaryLightColor = Color(0xff08203E);
const Color accentColor = Color(0xFFE3F2FD);
const Color borderColor = Color(0xFFE0E0E0);
const Color textColor = Color(0xFF1A237E);
const Color disabledColor = Color(0xFFBDBDBD);

// ✨ FUNÇÃO AUXILIAR PARA FORMATAR MOEDA
String formatCurrency(double value) {
  final format = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
  return format.format(value);
}

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

  void _removeApp(String appId) {
  if (selectedCombo == null) return;

  setState(() {
    final apps = List<SelectedApp>.from(selectedCombo!.apps);
    // Remove o app pelo seu ID, não pelo índice
    apps.removeWhere((app) => app.id == appId);

    // Recalcula o total...
    final newTotal = selectedCombo!.megaPrice +
          apps.fold<double>(0, (sum, app) => sum + app.price);

    // Atualiza o combo
    selectedCombo = selectedCombo!.copyWith(apps: apps, total: newTotal);

    showSummary = selectedCombo!.apps.isNotEmpty || selectedCombo!.mega.isNotEmpty;
  });
}

  void _removeInternet() {
    if (selectedCombo == null) return;

    setState(() {
      // Limpa internet e apps, zera total e fecha summary
      selectedCombo = SelectedCombo(
        mega: '',
        megaPrice: 0,
        apps: [],
        total: 0,
        isVisible: false,
      );

      showSummary = false;
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
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 246, 250, 253)),
                padding: EdgeInsets.all(isMobile ? 15 : 30),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Venha fazer parte da Velocity!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: isMobile ? 24 : 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Escolha sua velocidade ideal, adicione os streamings que você ama e aproveite internet + entretenimento do seu jeito.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: const Color.fromARGB(255, 134, 134, 134),
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 40),
                    DefaultTabController(
                      length: 1, // Ajustado para 1, pois só há uma aba visível
                      child: Column(
                        children: [
                          SizedBox(
                            height: isMobile ? 1132 : 850,
                            child: TabBarView(
                              children: [
                                Paraempresa(
                                  onComboUpdated: (combo) {
                                    _updateSelectedCombo(combo);
                                  },
                                  selectedCombo: selectedCombo,
                                  onRemoveApp: _removeApp,
                                  onRemoveInternet: _removeInternet,
                                ),
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
    if (!isMobile) return const SizedBox.shrink();

    return AnimatedSlide(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
      offset: showSummary ? Offset.zero : const Offset(0, 1),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 400),
        opacity: showSummary ? 1 : 0,
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (selectedCombo != null) ...[
                if (selectedCombo!.mega.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            'INTERNET ${selectedCombo!.mega} Megas',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0A84FF),
                            ),
                          ),
                        ),
                        Text(
                          // ✨ CORREÇÃO APLICADA AQUI
                          formatCurrency(selectedCombo!.megaPrice),
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0A84FF),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: _removeInternet,
                          child: const Icon(Icons.close,
                              color: Colors.redAccent, size: 20),
                        ),
                      ],
                    ),
                  ),
                if (selectedCombo!.apps.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Apps selecionados:",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF444444),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: selectedCombo!.apps
                        .map(
                          (app) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    app.name,
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      color: const Color(0xFF555555),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => _removeApp(
                                      selectedCombo!.apps.indexOf(app) as String),
                                  child: const Icon(Icons.close,
                                      color: Colors.redAccent, size: 18),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      const Divider(thickness: 1, color: Color(0xFFE0E0E0)),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total mensal:',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF00C853),
                            ),
                          ),
                          Text(
                            // ✨ CORREÇÃO APLICADA AQUI
                            formatCurrency(selectedCombo!.total),
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF00C853),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      // Botão expandido para ocupar mais espaço
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF25D366),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 2,
                        ),
                        onPressed: () {
                          final message = selectedCombo!.apps.isEmpty
                              ? 'Olá, gostaria de contratar o plano de ${selectedCombo!.mega} Mega'
                              : 'Olá, gostaria de contratar o plano de ${selectedCombo!.mega} Mega com '
                                  '${selectedCombo!.apps.map((app) => app.name).join(', ')}';
                          launchUrl(Uri.parse(
                            "https://api.whatsapp.com/send?phone=+5594992600430&text=${Uri.encodeComponent(message)}",
                          ));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(PhosphorIcons.whatsappLogo(),
                                color: Colors.white, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'Contratar agora',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      // Botão PDF com largura fixa
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 2,
                      ),
                      onPressed: () async {
                        if (selectedCombo != null) {
                          try {
                            final pdfBytes =
                                await gerarPdfRelatorio(selectedCombo!);

                            if (kIsWeb) {
                              final blob =
                                  html.Blob([pdfBytes], 'application/pdf');
                              final url =
                                  html.Url.createObjectUrlFromBlob(blob);
                              final anchor = html.AnchorElement(href: url)
                                ..download = 'resumo_velocity.pdf'
                                ..style.display = 'none';

                              html.document.body?.children.add(anchor);
                              anchor.click();
                              html.document.body?.children.remove(anchor);
                              html.Url.revokeObjectUrl(url);
                            } else {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) =>
                                      PreviewPdf(combo: selectedCombo!),
                                ),
                              );
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Erro ao gerar PDF: ${e.toString()}')),
                            );
                          }
                        }
                      },
                      child: Text(
                        "PDF",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
