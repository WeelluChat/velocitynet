import 'package:flutter/material.dart';

class Benefits extends StatelessWidget {
  const Benefits({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, bottom: 50, left: 20, right: 20),
      width: 700,
      alignment: Alignment.center,
      child: Wrap(
        direction: Axis.horizontal,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Curta filmes, séries, esportes, programas de TV e muito mais",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 45),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Contrate um de nossos planos e assista quando quiser de onde estiver.",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 30),
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 5, right: 43, left: 43),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.blue),
                      ),
                      child: const Text(
                        "R\$ 99,99",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.only(
                                top: 5, bottom: 5, right: 40, left: 40)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                              // borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                        ),
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "SAIBA MAIS",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
