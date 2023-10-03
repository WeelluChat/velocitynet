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
        child: Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 50, bottom: 50),
          child: SizedBox(
            // color: Colors.green,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Nós temos a solução perfeita para você.',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 400,
          width: 1450,
          // color: Colors.deepPurple,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Center(
                child: MouseRegion(
                  onEnter: (_) => setState(() => _isHovering1 = true),
                  onExit: (_) => setState(() => _isHovering1 = false),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        // A imagem de fundo
                        Positioned.fill(
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 400),
                            opacity: _isHovering1 ? 1 : 0,
                            child: Image.asset(
                              'description/descrption_image.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          width: 270,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFFD4D4D4),
                            ),
                            color: _isHovering1
                                ? Colors.black.withOpacity(0.7)
                                : Colors.transparent,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, top: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.wifi,
                                  color: _isHovering1
                                      ? const Color(0xff3682C5)
                                      : const Color(0xff3682C5),
                                  size: 70,
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Text(
                                  'Internet Banda Larga',
                                  style: TextStyle(
                                    color: _isHovering1
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 25,
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
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
                                const SizedBox(
                                  height: 25,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: MouseRegion(
                  onEnter: (_) => setState(() => _isHovering2 = true),
                  onExit: (_) => setState(() => _isHovering2 = false),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        // A imagem de fundo
                        Positioned.fill(
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 400),
                            opacity: _isHovering2 ? 1 : 0,
                            child: Image.asset(
                              'description/descrption_image.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          width: 270,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFFD4D4D4),
                            ),
                            color: _isHovering2
                                ? Colors.black.withOpacity(0.7)
                                : Colors.transparent,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, top: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.connected_tv,
                                  color: _isHovering2
                                      ? const Color(0xff3682C5)
                                      : const Color(0xff3682C5),
                                  size: 70,
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Text(
                                  'Tv por Assinatura',
                                  style: TextStyle(
                                    color: _isHovering2
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 25,
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Text(
                                  'Temos TV por assinatura disponível com vários canais.',
                                  style: TextStyle(
                                    color: _isHovering2
                                        ? Colors.white
                                        : Colors.grey,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: MouseRegion(
                  onEnter: (_) => setState(() => _isHovering3 = true),
                  onExit: (_) => setState(() => _isHovering3 = false),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        // A imagem de fundo
                        Positioned.fill(
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 400),
                            opacity: _isHovering3 ? 1 : 0,
                            child: Image.asset(
                              'description/descrption_image.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          width: 270,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFFD4D4D4),
                            ),
                            color: _isHovering3
                                ? Colors.black.withOpacity(0.7)
                                : Colors.transparent,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, top: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.router_outlined,
                                  color: _isHovering3
                                      ? const Color(0xff3682C5)
                                      : const Color(0xff3682C5),
                                  size: 70,
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Text(
                                  'Equipamentos',
                                  style: TextStyle(
                                    color: _isHovering3
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 25,
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Text(
                                  'Usamos os melhores roteadores e servidores para entregar o melhor serviço para você.',
                                  style: TextStyle(
                                    color: _isHovering3
                                        ? Colors.white
                                        : Colors.grey,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: MouseRegion(
                  onEnter: (_) => setState(() => _isHovering4 = true),
                  onExit: (_) => setState(() => _isHovering4 = false),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        // A imagem de fundo
                        Positioned.fill(
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 400),
                            opacity: _isHovering4 ? 1 : 0,
                            child: Image.asset(
                              'description/descrption_image.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          width: 270,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFFD4D4D4),
                            ),
                            color: _isHovering4
                                ? Colors.black.withOpacity(0.7)
                                : Colors.transparent,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, top: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.construction,
                                  color: _isHovering4
                                      ? const Color(0xff3682C5)
                                      : const Color(0xff3682C5),
                                  size: 70,
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Text(
                                  'Suporte',
                                  style: TextStyle(
                                    color: _isHovering4
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 25,
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Text(
                                  'Nosso suporte é rápido e preciso e nunca deixará você na mão',
                                  style: TextStyle(
                                    color: _isHovering4
                                        ? Colors.white
                                        : Colors.grey,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: MouseRegion(
                  onEnter: (_) => setState(() => _isHovering5 = true),
                  onExit: (_) => setState(() => _isHovering5 = false),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        // A imagem de fundo
                        Positioned.fill(
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 400),
                            opacity: _isHovering5 ? 1 : 0,
                            child: Image.asset(
                              'description/descrption_image.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          width: 270,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFFD4D4D4),
                            ),
                            color: _isHovering5
                                ? Colors.black.withOpacity(0.7)
                                : Colors.transparent,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, top: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.groups,
                                  color: _isHovering5
                                      ? const Color(0xff3682C5)
                                      : const Color(0xff3682C5),
                                  size: 70,
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Text(
                                  'Equipe',
                                  style: TextStyle(
                                    color: _isHovering5
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 25,
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Text(
                                  'Nossa equipe é composta por pessoas altamente qualificadas para entregar a você o melhor serviço possível',
                                  style: TextStyle(
                                    color: _isHovering5
                                        ? Colors.white
                                        : Colors.grey,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
