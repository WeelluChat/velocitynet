import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_net/helpers/url.dart';
import 'package:velocity_net/modules/plans/repository/curriculo.dart';
import 'package:velocity_net/pages/tv_plans.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  final ScrollController scrollController;

  const AppBarComponent({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;

    return Material(
      elevation: 4,
      color: Colors.white, // ✅ força o branco e impede roxo
      child: Container(
        height: preferredSize.height,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1300),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo.png',
                  width: 180,
                  height: 55,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 40),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildMenuItem("INÍCIO", () {
                        if (currentRoute != "/") {
                          Navigator.pushNamed(context, '/');
                        }
                        scrollController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.easeInOutCubic,
                        );
                      }),
                      const SizedBox(width: 24),
                      _buildMenuItem("PLANOS", () {
                        if (currentRoute != "/") {
                          Navigator.pushNamed(context, '/');
                        }
                        scrollController.animateTo(
                          600,
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.easeInOutCubic,
                        );
                      }),
                      const SizedBox(width: 24),
                      _buildMenuItem("SOBRE NÓS", () {
                        if (currentRoute != "/") {
                          Navigator.pushNamed(context, '/');
                        }
                        scrollController.animateTo(
                          1400,
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.easeInOutCubic,
                        );
                      }),
                      const SizedBox(width: 24),
                      _buildMenuItem("OFERTA", () {
                        if (currentRoute != "/") {
                          Navigator.pushNamed(context, '/');
                        }
                        scrollController.animateTo(
                          1910,
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.easeInOutCubic,
                        );
                      }),
                      const SizedBox(width: 24),
                      _buildMenuItem("TV", () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => Oletv()),
                        );
                      }),
                      const SizedBox(width: 24),
                      _buildMenuItem("CONTATOS", () {
                        if (currentRoute == '/contatos') return;
                        Navigator.pushNamed(context, '/contatos');
                      }),
                      const SizedBox(width: 24),
                      _buildMenuItem("TRABALHE CONOSCO", () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => TrabalheConosco()),
                        );
                      }),
                    ],
                  ),
                ),
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
        ),
      ),
    );
  }

  Widget _buildMenuItem(String label, VoidCallback onTap) {
    return _HoverableMenuItem(label: label, onTap: onTap);
  }

  @override
  Size get preferredSize => const Size.fromHeight(90);
}

class _HoverableMenuItem extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _HoverableMenuItem({
    required this.label,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  State<_HoverableMenuItem> createState() => _HoverableMenuItemState();
}

class _HoverableMenuItemState extends State<_HoverableMenuItem> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    const baseColor = Color(0xFF1A1A1A);
    const hoverColor = Color.fromARGB(255, 38, 70, 249);

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
