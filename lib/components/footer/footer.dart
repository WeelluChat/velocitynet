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
      // color: Colors.cyan,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right:30),
            child: SizedBox(
              width: 340,
              height: 260,
              // color: Colors.red,
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.headset_mic,
                                color: Color(0xff1e73be),
                                size: 50,
                              ),
                              SizedBox(width: 15,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Suporte',
                                    style: TextStyle(
                                        color: Color(0xff636363), fontSize: 16),
                                  ),
                                  Text(
                                    '+55 (94) 99132-6169',
                                    style: TextStyle(
                                       color: Color(0xff171717),
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
                                color: Color(0xff171717),
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          const Text(
                            'Avenida B Quadra 298 Lote 23 Cidade\nJardim Paraupebas - PA',
                            style: TextStyle(
                                color: Color(0xff636363), fontSize: 16),
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
                                      color: const Color(0xFFE7E7E7),
                                      borderRadius: BorderRadius.circular(50)),
                                  child:  Icon(
                                    Icons.facebook,
                                    color:  isHovered1
                                        ? Colors.blue
                                        : const Color(0xffA5ADBB),
                                    size: 25.0,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10,),
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
                                      color: const Color(0xFFE7E7E7),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: PhosphorIcon(
                                    isHovered2 ? PhosphorIcons.fill.twitterLogo : PhosphorIcons.regular.twitterLogo,
                                    color:  isHovered2
                                        ? Colors.blue
                                        : const Color(0xffA5ADBB),
                                    size: 25.0,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10,),
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
                                      color: const Color(0xFFE7E7E7),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: PhosphorIcon(
                                    isHovered3 ? PhosphorIcons.fill.instagramLogo : PhosphorIcons.regular.instagramLogo,
                                    color: isHovered3
                                        ? const Color(0xffE1306C)
                                        : const Color(0xffA5ADBB),
                                    size: 25.0,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10,),
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
                                    color: const Color(0xFFE7E7E7),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: PhosphorIcon(
                                    PhosphorIcons.fill.linkedinLogo,
                                    color: isHovered
                                        ? Colors.blue
                                        : const Color(0xffA5ADBB),
                                    size: 25.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left:30),
            child: SizedBox(
              width: 280,
              height: 260,
              // color: Colors.red,
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
                                  color: Color(0xff171717),
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
                                color: Color(0xff636363),
                                fontSize: 16,
                                height: 2),
                          ),
                          Text(
                            'Internet Corporativa',
                            style: TextStyle(
                                color: Color(0xff636363),
                                 fontSize: 16,
                                height: 2),
                          ),
                          Text(
                            'Link Dedicado',
                            style: TextStyle(
                                color: Color(0xff636363),
                                fontSize: 18,
                                height: 2),
                          ),
                          Text(
                            'TV por Assinatura',
                            style: TextStyle(
                                color: Color(0xff636363),
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
          ),
          const Padding(
            padding: EdgeInsets.only(left:30),
            child: SizedBox(
              width: 280,
              height: 260,
              // color: Colors.red,
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
                                    color: Color(0xff171717),
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
                                color: Color(0xff636363),
                                fontSize: 16,
                                height: 2),
                          ),
                          Text(
                            'Contato',
                            style: TextStyle(
                                color: Color(0xff636363),
                                fontSize: 16,
                                height: 2),
                          ),
                          Text(
                            'Politica de Privacidade',
                            style: TextStyle(
                                color: Color(0xff636363),
                                fontSize: 16,
                                height: 2),
                          ),
                          Text(
                            'Politica de Privacidade',
                            style: TextStyle(
                                color: Color(0xff636363),
                                fontSize: 16,
                                height: 2),
                          ),
                          Text(
                            'Termos e Condições',
                            style: TextStyle(
                                color: Color(0xff636363),
                                fontSize: 16,
                                height: 2),
                          ),
                          Text(
                            'Missão & Visão',
                            style: TextStyle(
                                color: Color(0xff636363),
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
          ),
          const Padding(
            padding: EdgeInsets.only(left:30),
            child: SizedBox(
              width: 280,
              height: 260,
              // color: Colors.red,
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
                                    color: Color(0xff171717),
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
                            style: TextStyle(fontSize: 16, color: Color(0xff636363)),
                          ),
                          Text(
                            '08:00 AM - 18:00 PM',
                            style: TextStyle(
                                color: Color(0xff171717),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 2),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Sábado',
                            style: TextStyle(color: Color(0xff636363), fontSize: 16),
                          ),
                          Text(
                            '08:00 AM - 12:00 PM',
                            style: TextStyle(
                                color: Color(0xff171717),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 2),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                'Domingo',
                                style: TextStyle(
                                  color: Color(0xff636363),
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Fechado',
                                style: TextStyle(
                                  color: Color(0xff1e73be),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
