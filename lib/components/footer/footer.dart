import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  bool isHovered = false;
  bool isHovered1 = false;
  bool isHovered2 = false;
  bool isHovered3 = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // color: Colors.cyan,
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color(0xff08203E),
        Color(0xff06141C),
      ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 50, bottom: 10),
        child: Wrap(
          alignment: MediaQuery.of(context).size.width < 700
              ? WrapAlignment.start
              : WrapAlignment.center,
          runSpacing: 55,
          spacing: 55,
          children: [
            SizedBox(
              width: 280,
              height: 220,
              // color: Colors.red,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.headset_mic,
                            color: Color(0xffFFB000),
                            size: 50,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Suporte',
                                style: TextStyle(
                                    color: Color(0xffDED4D4), fontSize: 16),
                              ),
                              Text(
                                '+55 (94) 99132-6169',
                                style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Endereço',
                        style: TextStyle(
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      const Text(
                        'Avenida B Quadra 298 Lote 23 \nCidade Jardim Paraupebas - PA',
                        style:
                            TextStyle(color: Color(0xffDED4D4), fontSize: 16),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          MouseRegion(
                            onEnter: (_) {
                              setState(() {
                                isHovered1 = true;
                              });
                            },
                            onExit: (_) {
                              setState(() {
                                isHovered1 = false;
                              });
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: const Color(0xFF274972),
                                  borderRadius: BorderRadius.circular(50)),
                              child: Icon(
                                Icons.facebook,
                                color: isHovered1 ? Colors.blue : Colors.white,
                                size: 25.0,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          MouseRegion(
                            onEnter: (_) {
                              setState(() {
                                isHovered2 = true;
                              });
                            },
                            onExit: (_) {
                              setState(() {
                                isHovered2 = false;
                              });
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: const Color(0xFF274972),
                                  borderRadius: BorderRadius.circular(50)),
                              child: PhosphorIcon(
                                isHovered2
                                    ? PhosphorIcons.fill.twitterLogo
                                    : PhosphorIcons.regular.twitterLogo,
                                color: isHovered2 ? Colors.blue : Colors.white,
                                size: 25.0,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          MouseRegion(
                            onEnter: (_) {
                              setState(() {
                                isHovered3 = true;
                              });
                            },
                            onExit: (_) {
                              setState(() {
                                isHovered3 = false;
                              });
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: const Color(0xFF274972),
                                  borderRadius: BorderRadius.circular(50)),
                              child: PhosphorIcon(
                                isHovered3
                                    ? PhosphorIcons.fill.instagramLogo
                                    : PhosphorIcons.regular.instagramLogo,
                                color: isHovered3
                                    ? const Color(0xffE1306C)
                                    : const Color(0xffffffff),
                                size: 25.0,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          MouseRegion(
                            onEnter: (_) {
                              setState(() {
                                isHovered = true;
                              });
                            },
                            onExit: (_) {
                              setState(() {
                                isHovered = false;
                              });
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: const Color(0xFF274972),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: PhosphorIcon(
                                PhosphorIcons.fill.linkedinLogo,
                                color: isHovered ? Colors.blue : Colors.white,
                                size: 22.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 280,
              height: 220,
              //  color: Colors.red,
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'CATEGORIAS',
                                style: TextStyle(
                                  color: Color(0xffffffff),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Internet Resídencial',
                            style: TextStyle(
                                color: Color(0xffDED4D4),
                                fontSize: 16,
                                height: 2),
                          ),
                          Text(
                            'Internet Corporativa',
                            style: TextStyle(
                                color: Color(0xffDED4D4),
                                fontSize: 16,
                                height: 2),
                          ),
                          Text(
                            'Link Dedicado',
                            style: TextStyle(
                                color: Color(0xffDED4D4),
                                fontSize: 16,
                                height: 2),
                          ),
                          Text(
                            'TV por Assinatura',
                            style: TextStyle(
                                color: Color(0xffDED4D4),
                                fontSize: 16,
                                height: 2),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 280,
              height: 260,
              //  color: Colors.red,
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'SOBRE A VELOCITYNET',
                                style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Sobre Nós',
                            style: TextStyle(
                                color: Color(0xffDED4D4),
                                fontSize: 16,
                                height: 2),
                          ),
                          Text(
                            'Contato',
                            style: TextStyle(
                                color: Color(0xffDED4D4),
                                fontSize: 16,
                                height: 2),
                          ),
                          Text(
                            'Politica de Privacidade',
                            style: TextStyle(
                                color: Color(0xffDED4D4),
                                fontSize: 16,
                                height: 2),
                          ),
                          Text(
                            'Politica de Privacidade',
                            style: TextStyle(
                                color: Color(0xffDED4D4),
                                fontSize: 16,
                                height: 2),
                          ),
                          Text(
                            'Termos e Condições',
                            style: TextStyle(
                                color: Color(0xffDED4D4),
                                fontSize: 16,
                                height: 2),
                          ),
                          Text(
                            'Missão & Visão',
                            style: TextStyle(
                                color: Color(0xffDED4D4),
                                fontSize: 16,
                                height: 2),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 280,
              height: 150,
              //  color: Colors.red,
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'HORARIO ATENDIMENTO',
                                style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Segunda - Domingo',
                            style: TextStyle(
                                fontSize: 16, color: Color(0xffDED4D4)),
                          ),
                          Text(
                            '08:00 AM - 18:00 PM',
                            style: TextStyle(
                                color: Color(0xffffffff),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 2),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
