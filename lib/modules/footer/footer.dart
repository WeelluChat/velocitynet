import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:velocity_net/helpers/url.dart';

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
  bool isHovered4 = false;
  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;

    return Container(
      width: double.infinity,
      // color: Colors.cyan,
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color(0xff08203E),
        Color(0xff06141C),
      ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, top: 50, bottom: 10, right: 20),
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
              //  color: Colors.red,
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
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
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              // Url().urlWhatsApp();
                            },
                            child: const Text(
                              'Link dedicado',
                              style: TextStyle(
                                  color: Color(0xffDED4D4),
                                  fontSize: 16,
                                  height: 2),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (currentRoute == '/tvplanos') {
                                return;
                              }
                              Navigator.pushNamed(context, '/tvplanos');
                            },
                            child: const Text(
                              'Tv por assinatura',
                              style: TextStyle(
                                  color: Color(0xffDED4D4),
                                  fontSize: 16,
                                  height: 2),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
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
                          const Row(
                            children: [
                              Text(
                                'CANAIS DE ATENDIMENTO',
                                style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // const Row(
                          //   children: [
                          //     Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         Text(
                          //           'Suporte / Outros',
                          //           style: TextStyle(
                          //               color: Color(0xffDED4D4), fontSize: 16),
                          //         ),
                          //         Text(
                          //           '+55 (94) 99132-6169',
                          //           style: TextStyle(
                          //               color: Color(0xFFFFFFFF),
                          //               fontWeight: FontWeight.bold,
                          //               fontSize: 18),
                          //         ),
                          //       ],
                          //     )
                          //   ],
                          // ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          const Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Financeiro',
                                    style: TextStyle(
                                        color: Color(0xffDED4D4), fontSize: 16),
                                  ),
                                  Text(
                                    '+55 (94) 99104-5810',
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
                            height: 10,
                          ),
                          const Text(
                            'Redes Sociais',
                            style: TextStyle(
                                color: Color(0xffDED4D4), fontSize: 16),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Url().urlFacebook();
                                },
                                child: MouseRegion(
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
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Icon(
                                      Icons.facebook,
                                      color: isHovered1
                                          ? Colors.blue
                                          : Colors.white,
                                      size: 25.0,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  Url().urlGmail();
                                },
                                child: MouseRegion(
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
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: PhosphorIcon(
                                      isHovered2
                                          ? PhosphorIcons.fill.envelope
                                          : PhosphorIcons.regular.envelope,
                                      color: isHovered2
                                          ? const Color(0xFFEA4335)
                                          : Colors.white,
                                      size: 25.0,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  Url().urlInstagram();
                                },
                                child: MouseRegion(
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
                                        borderRadius:
                                            BorderRadius.circular(50)),
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
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  Url().urlWeellu();
                                },
                                child: MouseRegion(
                                  onEnter: (_) {
                                    setState(() {
                                      isHovered4 = true;
                                    });
                                  },
                                  onExit: (_) {
                                    setState(() {
                                      isHovered4 = false;
                                    });
                                  },
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFF274972),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Image.asset(
                                        (isHovered4
                                            ? 'vetor_velocitynet_brasil.png'
                                            : 'vetor_velocitynet_brasil.png'),
                                        color: isHovered4
                                            ? Colors.green
                                            : const Color(0xffffffff),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // InkWell(
                          //   onTap: () {
                          //     if (currentRoute == '/contatos') {
                          //       return;
                          //     }
                          //     Navigator.pushNamed(context, '/contatos');
                          //   },
                          //   child: const Text(
                          //     'Contatos',
                          //     style: TextStyle(
                          //         color: Color(0xffDED4D4),
                          //         fontSize: 16,
                          //         height: 2),
                          //   ),
                          // ),
                          // const Text(
                          //   'Politica de Privacidade',
                          //   style: TextStyle(
                          //       color: Color(0xffDED4D4),
                          //       fontSize: 16,
                          //       height: 2),
                          // ),
                          // const Text(
                          //   'Termos e Condições',
                          //   style: TextStyle(
                          //       color: Color(0xffDED4D4),
                          //       fontSize: 16,
                          //       height: 2),
                          // ),
                          // InkWell(
                          //   onTap: () {
                          //     if (currentRoute == '/missao-visao') {
                          //       return;
                          //     }

                          //     Navigator.pushNamed(context, '/missao-visao');
                          //   },
                          //   child: const Text(
                          //     'Missão & Visão',
                          //     style: TextStyle(
                          //         color: Color(0xffDED4D4),
                          //         fontSize: 16,
                          //         height: 2),
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 280,
              height: 350,
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
                            'Segunda - Sexta',
                            style: TextStyle(
                                fontSize: 16, color: Color(0xffDED4D4)),
                          ),
                          Text(
                            '08:00h - 18:00h',
                            style: TextStyle(
                                color: Color(0xffffffff),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 2),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Sábados',
                            style: TextStyle(
                                fontSize: 16, color: Color(0xffDED4D4)),
                          ),
                          Text(
                            '08:00h - 13:00h (Presencial)\n13:00h - 18:00h (Online)',
                            style: TextStyle(
                                color: Color(0xffffffff),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 2),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Domingo / Feriado',
                            style: TextStyle(
                                fontSize: 16, color: Color(0xffDED4D4)),
                          ),
                          Text(
                            'Sem atendimento',
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
            Column(
              children: [
                const Text(
                  '© 2024 Velocitynet | Todos os direitos reservados.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  child: const Text(
                    'Velocitynet Telecom LTDA - CNPJ: 24.513.378/0001-57 - velocitynet@velocitynet.com.br',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
