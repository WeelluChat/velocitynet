import 'package:flutter/material.dart';

class Descrption extends StatefulWidget {
  const Descrption({super.key});

  @override
  State<Descrption> createState() => _DescrptionState();
}

class _DescrptionState extends State<Descrption> {
  bool _isHovering1 = false;
  bool _isHovering2 = false;
  bool _isHovering3 = false;
  bool _isHovering4 = false;
  bool _isHovering5 = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, bottom: 50),
      width: double.infinity,
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
          Wrap(
            spacing: 20.00,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              MouseRegion(
                onEnter: (_) => setState(() => _isHovering1 = true),
                onExit: (_) => setState(() => _isHovering1 = false),
                child: Stack(
                  children: [
                    // A imagem de fundo
                    Positioned.fill(
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 400),
                        opacity: _isHovering1 ? 1 : 0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'card_overlay.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 270,
                      height: 320,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFFD4D4D4),
                        ),
                        // color: _isHovering1
                        //     ? Colors.black.withOpacity(0.7)
                        //     : Colors.transparent,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15, top: 15, right: 10, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.wifi_rounded,
                              color: _isHovering1
                                  ? const Color(0xffFFB000)
                                  : const Color(0xffFFB000),
                              size: 70,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Internet Banda Larga',
                              style: TextStyle(
                                color:
                                    _isHovering1 ? Colors.white : Colors.white,
                                fontSize: 25,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Aqui você contrata internet fibra óptica para sua residência ou empresa.',
                              style: TextStyle(
                                color: _isHovering1
                                    ? Colors.white
                                    : const Color(0xFF9E9E9E),
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              MouseRegion(
                onEnter: (_) => setState(() => _isHovering2 = true),
                onExit: (_) => setState(() => _isHovering2 = false),
                child: Stack(
                  children: [
                    // A imagem de fundo
                    Positioned.fill(
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 400),
                        opacity: _isHovering2 ? 1 : 0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'card_overlay.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
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
                              Icons.connected_tv,
                              color: _isHovering2
                                  ? const Color(0xffFFB000)
                                  : const Color(0xffFFB000),
                              size: 70,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Tv por Assinatura',
                              style: TextStyle(
                                color:
                                    _isHovering2 ? Colors.white : Colors.white,
                                fontSize: 25,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Temos TV por assinatura disponível com vários canais.',
                              style: TextStyle(
                                color:
                                    _isHovering2 ? Colors.white : Colors.grey,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              MouseRegion(
                onEnter: (_) => setState(() => _isHovering3 = true),
                onExit: (_) => setState(() => _isHovering3 = false),
                child: Stack(
                  children: [
                    // A imagem de fundo
                    Positioned.fill(
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 400),
                        opacity: _isHovering3 ? 1 : 0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'card_overlay.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
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
                              Icons.router_outlined,
                              color: _isHovering3
                                  ? const Color(0xffFFB000)
                                  : const Color(0xffFFB000),
                              size: 70,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Equipamentos',
                              style: TextStyle(
                                color:
                                    _isHovering3 ? Colors.white : Colors.white,
                                fontSize: 25,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Usamos os melhores roteadores e servidores para entregar o melhor serviço para você.',
                              style: TextStyle(
                                color:
                                    _isHovering3 ? Colors.white : Colors.grey,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              MouseRegion(
                onEnter: (_) => setState(() => _isHovering4 = true),
                onExit: (_) => setState(() => _isHovering4 = false),
                child: Stack(
                  children: [
                    // A imagem de fundo
                    Positioned.fill(
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 400),
                        opacity: _isHovering4 ? 1 : 0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'card_overlay.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
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
                              Icons.construction,
                              color: _isHovering4
                                  ? const Color(0xffFFB000)
                                  : const Color(0xffFFB000),
                              size: 70,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Suporte',
                              style: TextStyle(
                                color:
                                    _isHovering4 ? Colors.white : Colors.white,
                                fontSize: 25,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Nosso suporte é rápido e preciso e nunca deixará você na mão',
                              style: TextStyle(
                                color:
                                    _isHovering4 ? Colors.white : Colors.grey,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              MouseRegion(
                onEnter: (_) => setState(() => _isHovering5 = true),
                onExit: (_) => setState(() => _isHovering5 = false),
                child: Stack(
                  children: [
                    // A imagem de fundo
                    Positioned.fill(
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 400),
                        opacity: _isHovering5 ? 1 : 0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'card_overlay.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
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
                              Icons.groups,
                              color: _isHovering5
                                  ? const Color(0xffFFB000)
                                  : const Color(0xffFFB000),
                              size: 70,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Equipe',
                              style: TextStyle(
                                color:
                                    _isHovering5 ? Colors.white : Colors.white,
                                fontSize: 25,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Nossa equipe é composta por pessoas altamente qualificadas para entregar a você o melhor serviço possível',
                              style: TextStyle(
                                color:
                                    _isHovering5 ? Colors.white : Colors.grey,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
