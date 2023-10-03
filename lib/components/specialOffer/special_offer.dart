import 'package:flutter/material.dart';

class SpecialOffer extends StatelessWidget {
  const SpecialOffer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, bottom: 50, left: 20, right: 20),
      alignment: Alignment.center,
      width: 1280,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                const Text(
                  'Obtenha internet banda larga a um preço incomparável.',
                  style: TextStyle(fontSize: 45),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Sim! Você poderá usar nossa Internet para conectar sua casa ou negocio usando seu computador, telefone e vários outros dispositivos.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Badge(
                      offset: const Offset(-25, 1),
                      alignment: Alignment.topLeft,
                      backgroundColor: Colors.transparent,
                      label: const Text(
                        'R\$',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      child: RichText(
                        text: const TextSpan(
                            text: '124,99',
                            style: TextStyle(
                                fontSize: 45,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' / Mês',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15),
                              )
                            ]),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.router_outlined,
                          color: Colors.blue, size: 45),
                      label: const SizedBox(
                        width: 300,
                        child: Text(
                          "Instalação grátis é roteador em comodato",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "ASSINE AGORA",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 520,
            child: Image.asset('offer.jpg', width: 520, fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }
}
