import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:velocity_net/model/card_data.dart';
import 'package:velocity_net/service/api.dart';

class Descrption extends StatefulWidget {
  const Descrption({super.key});

  @override
  State<Descrption> createState() => _DescrptionState();
}

class _DescrptionState extends State<Descrption> {
  List<CardData> cardList = [];

  card() async {
    final cardData = await Api().getCards();
    final jsonData = json.decode(cardData);

    for (final item in jsonData) {
      setState(() {
        cardList.add(CardData.fromJson(item));
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
    return Container(
      padding: const EdgeInsets.only(top: 50, bottom: 50),
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color(0xff08203E),
        Color(0xff06141C),
      ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              Text(
                textAlign: TextAlign.center,
                'Nós temos a solução perfeita para você.',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width < 600 ? 30 : 40,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
            alignment: Alignment.center,
            height: 320,
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 20, right: 20),
              itemCount: cardList.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final cardData = cardList[index];
                return Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 270,
                        height: 320,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color(0xFFD4D4D4),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15, top: 15, right: 10, bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                cardData.icon,
                                color: const Color(0xffFFB000),
                                size: 70,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                cardData.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                cardData.description,
                                style: const TextStyle(
                                  color: Color(0xFF9E9E9E),
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
