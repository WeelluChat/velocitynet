import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:velocity_net/modules/plans/provider/plan_provider.dart';

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
        Consumer<PlanProvider>(builder: (context, controller, _) {
          return SizedBox(
            height: 615,
            child: Image.network(
              'controller.planBase',
              fit: BoxFit.cover,
            ),
          );
        }),
      ],
    );
  }
}
