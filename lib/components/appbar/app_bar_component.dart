import 'package:flutter/material.dart';

class AppBarComponent extends AppBar {
  final ScrollController scrollController;

  AppBarComponent({super.key, required this.scrollController});

  @override
  State<AppBarComponent> createState() => _AppBarComponentState();
}

class _AppBarComponentState extends State<AppBarComponent> {
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = widget.scrollController;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints(
          maxWidth: 500.0,
        ),
        child: Column(
          children: [
            Container(
              color: const Color(0XFF13294E),
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.location_pin,
                      color: Color(0xFFDE7642),
                    ),
                    label: const Text(
                      "Av: B QD: 298 LT:23 - Cidade Jardim, Parauapebas - PA, 68515-000",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Image.asset(
                      "whatsapp.png",
                      width: 20,
                    ),
                    label: const Text(
                      "+55 (94) 99132-6169",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.facebook,
                      color: Colors.blue,
                    ),
                    label: const Text(
                      "@velocitynettelecom",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Image.asset(
                      "instagram.png",
                      width: 20,
                    ),
                    label: const Text(
                      "@velocitynet_oficial",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: 1280,
              child: Flex(
                mainAxisAlignment: MainAxisAlignment.center,
                direction: Axis.horizontal,
                children: [
                  Image.asset(
                    'logo.png',
                    width: 200,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      scrollController.animateTo(
                          scrollController.position.minScrollExtent,
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.easeInQuad);
                    },
                    child: const Text(
                      "INÍCIO",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      scrollController.animateTo(
                          scrollController.position.minScrollExtent + 600,
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.easeInQuad);
                    },
                    child: const Text(
                      "PLANOS",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      scrollController.animateTo(
                          scrollController.position.minScrollExtent + 1400,
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.easeInQuad);
                    },
                    child: const Text(
                      "SOBRE NÓS",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      scrollController.animateTo(
                          scrollController.position.minScrollExtent + 1910,
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.easeInQuad);
                    },
                    child: const Text(
                      "OFERTA",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      scrollController.animateTo(
                          scrollController.position.minScrollExtent + 2410,
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.easeInQuad);
                    },
                    child: const Text(
                      "BENEFÍCIOS",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Color(0xFF0C13A2),
                      ),
                    ),
                    onPressed: () {},
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextButton.icon(
                        onPressed: () {},
                        label: const Text(
                          "ASSINE JÁ",
                          style: TextStyle(color: Colors.white),
                        ),
                        icon: const Directionality(
                          textDirection: TextDirection.ltr,
                          child: Icon(
                            Icons.arrow_right_sharp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Color(0xFF0C13A2),
                      ),
                    ),
                    onPressed: () {},
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextButton.icon(
                        onPressed: () {},
                        label: const Text(
                          "CENTRAL DO ASSINANTE",
                          style: TextStyle(color: Colors.white),
                        ),
                        icon: const Directionality(
                          textDirection: TextDirection.ltr,
                          child: Icon(
                            Icons.arrow_right_sharp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
