import 'package:flutter/material.dart';

class SpecialOffer extends StatelessWidget {
  const SpecialOffer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, bottom: 50, left: 20, right: 20),
      // alignment: Alignment.center,
      width: double.infinity,
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: SizedBox(
              width: 750,
              // color: Colors.green,
              child: Column(
                crossAxisAlignment: MediaQuery.of(context).size.width < 700
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
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
                    'Tenha agora 700MB de velocidade incrível por apenas R\$67,49/mês nos primeiros 3 meses! Após isso, continue navegando por apenas R\$124,99/mês. Não perca essa oportunidade de ter a internet que você merece! #Internet700MB #Promoção #Velocidade',
                    textAlign: MediaQuery.of(context).size.width < 600
                        ? TextAlign.center
                        : TextAlign.start,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Container(
                        // color: Colors.red,
                        child: RichText(
                          text: const TextSpan(
                            text: 'R\$ 67,49',
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
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.router_outlined,
                          color: Color(0XFF13294E),
                          size: 45,
                        ),
                        label:  const SizedBox(
                          // color: Colors.amber,
                          width: 230,
                          child: Text(
                            "Instalação por apenas R\$ 50,00",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xffFFB000)),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "SABER MAIS",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: MediaQuery.of(context).size.width > 1200,
            child: SizedBox(
              // color: Colors.red,
              width: 510,
              child: Image.asset(
                'image_promocao.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
