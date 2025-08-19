import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_net/modules/description/model/card_model.dart';
import 'package:velocity_net/service/api.dart';

class Descrption extends StatefulWidget {
  const Descrption({super.key});

  @override
  State<Descrption> createState() => _DescrptionState();
}

class _DescrptionState extends State<Descrption> {
  List<CardModel> cardList = [];

  card() async {
    final cardData = await Api().getCards();
    final jsonData = json.decode(cardData);

    for (final item in jsonData) {
      setState(() {
        cardList.add(CardModel.fromJson(item));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    card();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff08203E), Color(0xff06141C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'A Velocitynet Telecom tem a\nsolução perfeita para o seu problema!',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: isMobile ? 16 : 30,
              fontWeight: FontWeight.bold,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 40),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 20,
            runSpacing: 20,
            children: cardList.map((cardData) {
              return SizedBox(
                width: 250,
                height: 290,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF0C2D5B),
                        Color.fromARGB(255, 14, 57, 121)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(2, 4),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          cardData.icon,
                          color: const Color(0xffFFB000),
                          size: 50,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          cardData.title,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: Text(
                            cardData.description,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              color: const Color(0xFFBDBDBD),
                              fontSize: 15,
                              height: 1.4,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
