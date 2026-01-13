import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_net/helpers/url.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  final Map<String, bool> _hoverStates = {
    'facebook': false,
    'email': false,
    'instagram': false,
    'whatsapp': false,
  };

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(),
        child: Column(
          children: [
            isMobile
                ? _buildMobileLayout(currentRoute)
                : _buildDesktopLayout(currentRoute),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
            ),
            _buildFooterBottom(),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(String? currentRoute) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // _buildCategorySection(currentRoute),
          _buildContactSection(),
          _buildScheduleSection(),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(String? currentRoute) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // _buildCategorySection(currentRoute),
        const SizedBox(height: 40),
        _buildContactSection(),
        const SizedBox(height: 40),
        _buildScheduleSection(),
      ],
    );
  }

  // Widget _buildCategorySection(String? currentRoute) {
  //   return SizedBox(
  //     width: 280,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           'CATEGORIAS',
  //           style: GoogleFonts.poppins(
  //             color: Colors.black87,
  //             fontWeight: FontWeight.w700,
  //             fontSize: 18,
  //             letterSpacing: 1.2,
  //           ),
  //         ),
  //         const SizedBox(height: 25),
  //         _buildFooterLink(text: 'Link dedicado', onTap: () {}),
  //         _buildFooterLink(
  //           text: 'Tv por assinatura',
  //           onTap: () {
  //             if (currentRoute != '/tvplanos') {
  //               Navigator.pushNamed(context, '/tvplanos');
  //             }
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildContactSection() {
    return SizedBox(
      width: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CANAIS DE ATENDIMENTO',
            style: GoogleFonts.poppins(
              color: Colors.black87,
              fontWeight: FontWeight.w700,
              fontSize: 18,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 25),
          _buildContactInfo(label: 'Financeiro', number: '+55 (94) 99104-5810'),
          const SizedBox(height: 15),
          _buildContactInfo(label: 'Ligação', number: '+55 (94) 99132-6169'),
          const SizedBox(height: 25),
          Text(
            'REDES SOCIAIS',
            style: GoogleFonts.poppins(
              color: Colors.black54,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _buildSocialIcon(
                icon: Icons.facebook,
                hoverColor: const Color(0xFF1877F2),
                key: 'facebook',
                onTap: Url().urlFacebook,
              ),
              const SizedBox(width: 12),
              _buildSocialIcon(
                icon: PhosphorIcons.envelope(),
                hoverColor: const Color(0xFFEA4335),
                key: 'email',
                onTap: Url().urlGmail,
              ),
              const SizedBox(width: 12),
              _buildSocialIcon(
                icon: PhosphorIcons.instagramLogo(),
                hoverColor: const Color(0xFFE1306C),
                key: 'instagram',
                onTap: Url().urlInstagram,
              ),
              const SizedBox(width: 12),
              _buildSocialIcon(
                icon: PhosphorIcons.whatsappLogo(),
                hoverColor: const Color(0xFF25D366),
                key: 'whatsapp',
                onTap: Url().urlWeellu,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleSection() {
    return SizedBox(
      width: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'HORÁRIO DE ATENDIMENTO',
            style: GoogleFonts.poppins(
              color: Colors.black87,
              fontWeight: FontWeight.w700,
              fontSize: 18,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 25),
          _buildScheduleItem(
            days: 'Segunda - Sexta',
            hours: '08:00h - 18:00h',
          ),
          const SizedBox(height: 20),
          _buildScheduleItem(
            days: 'Sábados',
            hours: '08:00h - 13:00h (Presencial)\n13:00h - 18:00h (Online)',
          ),
          const SizedBox(height: 20),
          _buildScheduleItem(
            days: 'Domingo / Feriado',
            hours: 'Sem atendimento',
          ),
        ],
      ),
    );
  }

  Widget _buildFooterBottom() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        const Color.fromARGB(255, 7, 28, 54),
        const Color.fromARGB(255, 9, 46, 102)
      ])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '© 2024 Velocitynet | Todos os direitos reservados.',
            style: GoogleFonts.poppins(
              color: const Color.fromARGB(255, 255, 255, 255),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Velocitynet Telecom LTDA - CNPJ: 24.513.378/0001-57',
            style: GoogleFonts.poppins(
              color: const Color.fromARGB(255, 255, 255, 255),
              fontSize: 13,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            'velocitynet@velocitynet.com.br',
            style: GoogleFonts.poppins(
              color: const Color.fromARGB(255, 255, 255, 255),
              fontSize: 13,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFooterLink({required String text, required VoidCallback onTap}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            text,
            style: GoogleFonts.poppins(
              color: Colors.black87,
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactInfo({required String label, required String number}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.black54,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          number,
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon({
    required dynamic icon,
    required Color hoverColor,
    required String key,
    required VoidCallback onTap,
  }) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hoverStates[key] = true),
      onExit: (_) => setState(() => _hoverStates[key] = false),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _hoverStates[key]! ? hoverColor : const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: _hoverStates[key]!
                ? [
                    BoxShadow(
                      color: hoverColor.withOpacity(0.4),
                      blurRadius: 10,
                      spreadRadius: 2,
                    )
                  ]
                : [],
          ),
          child: Center(
            child: icon is IconData
                ? Icon(icon, color: Colors.black87, size: 20)
                : PhosphorIcon(icon, color: Colors.black87, size: 20),
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleItem({required String days, required String hours}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          days,
          style: GoogleFonts.poppins(
            color: Colors.black54,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          hours,
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 15,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
