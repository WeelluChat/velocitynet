import 'package:flutter/material.dart';

class SpecialOffer extends StatelessWidget {
  const SpecialOffer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, bottom: 50, left: 20, right: 20),
      alignment: Alignment.center,
      width: 1550,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.center,
        verticalDirection: VerticalDirection.up,
        children: [
          SizedBox(
            width: 750,
            child: Expanded(
              flex: 1,
              child: Column(
                children: [
                  Text(
                    'Obtenha internet banda larga a um preço incomparável.',
                    textAlign: MediaQuery.of(context).size.width < 600
                        ? TextAlign.center
                        : TextAlign.start,
                    style: TextStyle(
                      fontSize:
                          MediaQuery.of(context).size.width < 600 ? 30 : 40,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Sim! Você poderá usar nossa Internet para conectar sua casa ou negocio usando seu computador, telefone e vários outros dispositivos.',
                    textAlign: MediaQuery.of(context).size.width < 600
                        ? TextAlign.center
                        : TextAlign.start,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.start,
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
                                  color: Color(0XFF13294E)),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' / Mês',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15),
                                )
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          child: TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.router_outlined,
                              color: Color(0XFF13294E),
                              size: 45,
                            ),
                            label: const SizedBox(
                              width: 300,
                              child: Text(
                                "Instalação grátis é roteador em comodato",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: MediaQuery.of(context).size.width < 600
                        ? Alignment.center
                        : Alignment.centerLeft,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0XFF13294E)),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "ASSINE AGORA",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: MediaQuery.of(context).size.width > 600,
            child: SizedBox(
              width: 520,
              height: 520,
              child: Image.asset(
                'offer.jpg',
                width: 520,
                height: 520,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
