import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class MaintenancePage extends StatefulWidget {
  final String? title;
  final String? subtitle;
  final String? message;

  const MaintenancePage({
    super.key,
    this.title = 'Site em Manutenção',
    this.subtitle = 'Estamos melhorando a sua experiência',
    this.message =
        'Estamos realizando manutenções no nosso site para oferecer um serviço melhor. Voltaremos em breve!',
  });

  @override
  State<MaintenancePage> createState() => _MaintenancePageState();
}

class _MaintenancePageState extends State<MaintenancePage> {
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(isMobile ? 24 : 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ==================== LOGO ====================
                Container(
                  width: isMobile ? 120 : 180,
                  height: isMobile ? 120 : 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF0066CC).withOpacity(0.2),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/logo.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFFE3F2FD),
                          child: const Icon(
                            Icons.image_not_supported,
                            size: 60,
                            color: Color(0xFF0066CC),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                SizedBox(height: isMobile ? 40 : 60),

                // ==================== MENSAGEM GRANDE ====================
                Text(
                  widget.message ??
                      'Estamos realizando manutenções no nosso site para oferecer um serviço melhor. Voltaremos em breve!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 28 : 42,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF003366),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
