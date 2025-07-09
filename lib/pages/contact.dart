import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_net/modules/appbar/app_bar_component.dart';
import 'package:velocity_net/modules/appbar/app_bar_component_resize.dart';
import 'package:velocity_net/modules/endDrawer/end_drawer.dart';
import 'package:velocity_net/modules/footer/footer.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  late bool isMobile;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    isMobile = true;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isMobile = MediaQuery.of(context).size.width <= 1200;
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: PreferredSize(
        preferredSize:
            isMobile ? const Size.fromHeight(80) : const Size.fromHeight(140),
        child: Container(
          margin: isMobile ? const EdgeInsets.only(top: 15) : EdgeInsets.zero,
          child: isMobile
              ? const AppBarComponentResize()
              : AppBarComponent(scrollController: _scrollController),
        ),
      ),
      endDrawer:
          isMobile ? EndDrawer(scrollController: _scrollController) : null,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: 60,
                horizontal: isSmallScreen ? 24 : 80,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xffF7F9FC), Color(0xffEDF2FA)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'NOSSOS CANAIS DE ATENDIMENTO',
                    style: GoogleFonts.poppins(
                      color: const Color(0xff1A2D45),
                      fontSize: isSmallScreen ? 26 : 36,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 40),
                  _buildContactList(),
                ],
              ),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildContactList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildContactItem(
          icon: Image.asset(
            'assets/weellu_logo.png',
            width: 40,
            errorBuilder: (_, __, ___) =>
                const Icon(Icons.alternate_email, size: 32),
          ),
          label: "Weellu Social / Velocitynet Telecom",
          onTap: () => _launchUrl("https://webchat.weellu.com/"),
        ),
        _contactSpacer(),
        _buildContactItem(
          icon: PhosphorIcon(
            PhosphorIcons.instagramLogo(),
            size: 32,
            color: const Color(0xFFE1306C),
          ),
          label: "@velocitynet_oficial",
          onTap: () =>
              _launchUrl("https://www.instagram.com/velocitynet.oficial/"),
        ),
        _contactSpacer(),
        _buildContactItem(
          icon: PhosphorIcon(
            PhosphorIcons.facebookLogo(),
            size: 32,
            color: const Color(0xFF4267B2),
          ),
          label: "@velocitynettelecom",
          onTap: () => _launchUrl("https://www.facebook.com/velocitynettelecom"),
        ),
        _contactSpacer(),
        _buildContactItem(
          icon: PhosphorIcon(
            PhosphorIcons.whatsappLogo(),
            size: 32,
            color: const Color(0xFF25D366),
          ),
          label: "+55 (94) 99260-0430",
          subtitle: "WhatsApp",
          onTap: () => _launchUrl(
              "https://api.whatsapp.com/send?phone=5594992600430&text=Olá, tudo bem?"),
        ),
        _contactSpacer(),
        _buildContactItem(
          icon: PhosphorIcon(
            PhosphorIcons.phone(),
            size: 32,
            color: const Color(0xff343434),
          ),
          label: "+55 (94) 99132-6169",
          subtitle: "Somente ligações por operadores",
          onTap: () => _launchUrl("tel:+5594991326169"),
        ),
        _contactSpacer(),
        _buildContactItem(
          icon: PhosphorIcon(
            PhosphorIcons.envelope(),
            size: 32,
            color: const Color(0xFFB3261E),
          ),
          label: "velocitynetfinanceiro@gmail.com",
          onTap: () =>
              _launchUrl("mailto:velocitynetfinanceiro@gmail.com"),
        ),
        _contactSpacer(),
        _buildContactItem(
          icon: PhosphorIcon(
            PhosphorIcons.mapPin(),
            size: 32,
            color: const Color(0xFFEB1010),
          ),
          label: "Av: B QD: 298 LT:23",
          subtitle: "Cidade Jardim, Parauapebas - PA, 68515-000",
          onTap: () =>
              _launchUrl("https://maps.app.goo.gl/AYWLVsUVsNWPtz2E6"),
        ),
      ],
    );
  }

  Widget _contactSpacer() => const SizedBox(height: 24);

  Widget _buildContactItem({
    required Widget icon,
    required String label,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      splashColor: Colors.blue.withOpacity(0.1),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: const Color(0xFFECECEC)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            icon,
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff1A2D45),
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: const Color(0xff666666),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Não foi possível abrir o link: $url');
    }
  }
}
