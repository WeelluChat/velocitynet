import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_net/helpers/url.dart';
import 'package:velocity_net/modules/plans/repository/curriculo.dart';
import 'package:velocity_net/pages/contact.dart';
import 'package:velocity_net/pages/tv_plans.dart';

class EndDrawer extends StatefulWidget {
  final ScrollController scrollController;
  const EndDrawer({super.key, required this.scrollController});

  @override
  State<EndDrawer> createState() => _EndDrawerState();
}

class _EndDrawerState extends State<EndDrawer> {
  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;

    return Drawer(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 180,
              height: 55,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 30),

            // INÍCIO
            _buildMenuItem(label: "INÍCIO", onTap: () {
              Navigator.pop(context);
              Navigator.popUntil(context, ModalRoute.withName('/'));
              Future.delayed(const Duration(milliseconds: 300), () {
                widget.scrollController.animateTo(
                  widget.scrollController.position.minScrollExtent,
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeInOutCubic,
                );
              });
            }),

            const SizedBox(height: 24),

            // PLANOS
            _buildMenuItem(label: "PLANOS", onTap: () {
              Navigator.pop(context);
              Navigator.popUntil(context, ModalRoute.withName('/'));
              Future.delayed(const Duration(milliseconds: 300), () {
                widget.scrollController.animateTo(
                  widget.scrollController.position.minScrollExtent + 600,
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeInOutCubic,
                );
              });
            }),

            const SizedBox(height: 24),

            // SOBRE NÓS
            _buildMenuItem(label: "SOBRE NÓS", onTap: () {
              Navigator.pop(context);
              Navigator.popUntil(context, ModalRoute.withName('/'));
              Future.delayed(const Duration(milliseconds: 300), () {
                widget.scrollController.animateTo(
                  widget.scrollController.position.minScrollExtent + 2050,
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeInOutCubic,
                );
              });
            }),

            const SizedBox(height: 24),

            // OFERTA
            _buildMenuItem(label: "OFERTA", onTap: () {
              Navigator.pop(context);
              Navigator.popUntil(context, ModalRoute.withName('/'));
              Future.delayed(const Duration(milliseconds: 300), () {
                widget.scrollController.animateTo(
                  widget.scrollController.position.minScrollExtent + 3750,
                  duration: const Duration(milliseconds: 1500),
                  curve: Curves.easeInOutCubic,
                );
              });
            }),

            const SizedBox(height: 24),

            // TV
            _buildMenuItem(label: "TV", onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Oletv()),
              );
            }),

            const SizedBox(height: 24),

            // CONTATOS
            _buildMenuItem(label: "CONTATOS", onTap: () {
              if (currentRoute == '/contatos') return;
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactPage()),
              );
            }),

            const SizedBox(height: 24),

            // TRABALHE CONOSCO
            _buildMenuItem(label: "TRABALHE CONOSCO", onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TrabalheConosco()),
              );
            }),

            const Spacer(),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00B4DB),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 4,
              ),
              onPressed: () => Url().urlCentralAssinante(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "CENTRAL DO ASSINANTE",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({required String label, required VoidCallback onTap}) {
    return _HoverableMenuItem(label: label, onTap: onTap);
  }
}

class _HoverableMenuItem extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _HoverableMenuItem({required this.label, required this.onTap, Key? key}) : super(key: key);

  @override
  State<_HoverableMenuItem> createState() => _HoverableMenuItemState();
}

class _HoverableMenuItemState extends State<_HoverableMenuItem> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final baseColor = const Color(0xFF1A1A1A);
    final hoverColor = const Color(0xFFF9A826);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: _isHovering ? hoverColor : Colors.transparent,
                width: 2.5,
              ),
            ),
          ),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: _isHovering ? hoverColor : baseColor,
            ),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}
