import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:velocity_net/helpers/url.dart';

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
    final currentRoute = ModalRoute.of(context)?.settings.name;

    return Container(
      constraints: const BoxConstraints(
        maxWidth: 500.0,
      ),
      child: Column(
        children: [
          // Container(
          //   color: const Color(0XFF13294E),
          //   padding: const EdgeInsets.only(top: 10, bottom: 10),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       TextButton.icon(
          //         onPressed: () {
          //           Url().urlWhatsApp();
          //         },
          //         icon: PhosphorIcon(
          //           PhosphorIcons.fill.whatsappLogo,
          //           color: Colors.green,
          //           size: 25.0,
          //         ),
          //         label: const Text(
          //           "+55 (94) 99132-6169",
          //           style: TextStyle(color: Colors.white),
          //         ),
          //       ),
          //       TextButton.icon(
          //         onPressed: () {
          //           Url().urlFacebook();
          //         },
          //         icon: PhosphorIcon(
          //           PhosphorIcons.fill.facebookLogo,
          //           color: Colors.blue,
          //           size: 25.0,
          //         ),
          //         label: const Text(
          //           "@velocitynettelecom",
          //           style: TextStyle(color: Colors.white),
          //         ),
          //       ),
          //       TextButton.icon(
          //         onPressed: () {
          //           Url().urlInstagram();
          //         },
          //         icon: PhosphorIcon(
          //           PhosphorIcons.fill.instagramLogo,
          //           color: const Color(0xFFEA4335),
          //           size: 25.0,
          //         ),
          //         label: const Text(
          //           "@velocitynet_oficial",
          //           style: TextStyle(color: Colors.white),
          //         ),
          //       ),
          //       TextButton.icon(
          //         onPressed: () {
          //           //
          //         },
          //         icon: PhosphorIcon(
          //           PhosphorIcons.fill.mapPin,
          //           color: Colors.orange,
          //           size: 25.0,
          //         ),
          //         label: const Text(
          //           "Parauapebas",
          //           style: TextStyle(color: Colors.white),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
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
                    if (currentRoute != "/") {
                      Navigator.pushNamed(context, '/');
                    }

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
                    if (currentRoute != "/") {
                      Navigator.pushNamed(context, '/');
                    }
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
                    if (currentRoute != "/") {
                      Navigator.pushNamed(context, '/');
                    }
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
                    if (currentRoute != "/") {
                      Navigator.pushNamed(context, '/');
                    }
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
                    if (currentRoute == '/tvplanos') {
                      return;
                    }
                    Navigator.pushNamed(context, '/tvplanos');
                  },
                  child: const Text(
                    "TV",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    if (currentRoute == '/contatos') {
                      return;
                    }

                    Navigator.of(context).pushNamed('/contatos');
                  },
                  child: const Text(
                    "CONTATOS",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                // ElevatedButton(
                //   style: const ButtonStyle(
                //     backgroundColor: WidgetStatePropertyAll(
                //       Color(0XFF13294E),
                //     ),
                //   ),
                //   onPressed: () {},
                //   child: Directionality(
                //     textDirection: TextDirection.rtl,
                //     child: TextButton.icon(
                //       onPressed: () {
                //         Url().urlWhatsApp();
                //       },
                //       label: const Text(
                //         "ASSINE JÁ",
                //         style: TextStyle(color: Colors.white),
                //       ),
                //       icon: const Directionality(
                //         textDirection: TextDirection.ltr,
                //         child: Icon(
                //           Icons.arrow_right_sharp,
                //           color: Colors.white,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   width: 20,
                // ),
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Color(0XFF13294E),
                    ),
                  ),
                  onPressed: () {},
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextButton.icon(
                      onPressed: () {
                        Url().urlCentralAssinante();
                      },
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
      ),
    );
  }
}
