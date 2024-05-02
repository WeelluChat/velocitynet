import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PreviewCard extends StatefulWidget {
  const PreviewCard({super.key});

  @override
  State<PreviewCard> createState() => _PreviewCardState();
}

class _PreviewCardState extends State<PreviewCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'PLANO BÁSICO',
          style: GoogleFonts.getFont('Poppins', fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 615,
          child: Image.asset(
            'assets/card_500.png',
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
