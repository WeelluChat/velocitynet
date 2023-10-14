import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:velocity_net/components/appbar/app_bar_component.dart';
import 'package:velocity_net/components/appbar/app_bar_component_resize.dart';
import 'package:velocity_net/components/copyright/copyright.dart';
import 'package:velocity_net/components/footer/footer.dart';
import 'package:velocity_net/helpers/url.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  bool mobile = false;
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    mobile = MediaQuery.of(context).size.width > 1200 ? false : true;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: mobile == true
            ? const Size.fromHeight(80)
            : const Size.fromHeight(140),
        child: Container(
          margin: mobile == true
              ? const EdgeInsets.only(top: 15)
              : const EdgeInsets.only(top: 0),
          child: (mobile == true)
              ? const AppBarComponentResize()
              : AppBarComponent(scrollController: scrollController),
        ),
      ),
      endDrawer: mobile
          ? Drawer(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 15),
                    child: InkWell(
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        scrollController.animateTo(
                            scrollController.position.minScrollExtent,
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.easeInQuad);
                        // print('meu botão aqui');
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "INÍCIO",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: InkWell(
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        scrollController.animateTo(
                            scrollController.position.minScrollExtent + 600,
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.easeInQuad);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "PLANOS",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: InkWell(
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        scrollController.animateTo(
                            scrollController.position.minScrollExtent + 1400,
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.easeInQuad);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "SOBRE NÓS",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: InkWell(
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        scrollController.animateTo(
                            scrollController.position.minScrollExtent + 3350,
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.easeInQuad);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "OFERTA",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: InkWell(
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        scrollController.animateTo(
                            scrollController.position.minScrollExtent + 3850,
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.easeInQuad);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "BENEFÍCIOS",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0XFF13294E),
                      ),
                      onPressed: () {
                        Url().urlWhatsApp();
                      },
                      child: const Text(
                        "ASSINE JÁ",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: const Color(0XFF13294E)),
                      onPressed: () {},
                      child: const Text(
                        "CENTRAL DO ASSINANTE",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : null,
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Flex(
            direction: Axis.vertical,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 50, bottom: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 22),
                      child: Text(
                        textAlign: MediaQuery.of(context).size.width < 600
                            ? TextAlign.start
                            : TextAlign.start,
                        'NOSSOS CANAIS DE ATENDIMENTO',
                        style: const TextStyle(
                            color: Color(0xff343434),
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextButton.icon(
                        icon: Image.asset(
                          'weellu_logo.png',
                          width: 45,
                        ),
                        label: const Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          "Weellu Social",
                          style: TextStyle(fontSize: 22),
                        ),
                        onPressed: () {
                          Url().urlWeellu();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextButton.icon(
                        icon: PhosphorIcon(
                          PhosphorIcons.fill.whatsappLogo,
                          size: 40,
                          color: Colors.green,
                        ),
                        label: const Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          "+55 (94) 99132-6169",
                          style: TextStyle(fontSize: 22),
                        ),
                        onPressed: () {
                          Url().urlWhatsApp();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextButton.icon(
                        icon: PhosphorIcon(
                          PhosphorIcons.fill.instagramLogo,
                          size: 40,
                          color: Colors.pink,
                        ),
                        label: const Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          "@velocitynet_oficial",
                          style: TextStyle(fontSize: 22),
                        ),
                        onPressed: () {
                          Url().urlInstagram();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextButton.icon(
                        icon: PhosphorIcon(
                          PhosphorIcons.fill.facebookLogo,
                          size: 40,
                          color: Colors.blue,
                        ),
                        label: const Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          "@velocitynettelecom",
                          style: TextStyle(fontSize: 22),
                        ),
                        onPressed: () {
                          Url().urlFacebook();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextButton.icon(
                        icon: PhosphorIcon(
                          PhosphorIcons.fill.phone,
                          size: 40,
                          color: const Color(0xff343434),
                        ),
                        label: const Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          "+55 (94) 99132-6169* Somente ligações por operadores",
                          style: TextStyle(fontSize: 22),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextButton.icon(
                        icon: PhosphorIcon(
                          PhosphorIcons.regular.envelope,
                          size: 40,
                          color: const Color(0xFF690707),
                        ),
                        label: const Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          "velocitynetfinanceiro@gmail.com",
                          style: TextStyle(fontSize: 22),
                        ),
                        onPressed: () {
                          Url().urlGmail();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextButton.icon(
                        icon: PhosphorIcon(
                          PhosphorIcons.fill.mapPin,
                          size: 40,
                          color: const Color(0xFFEB1010),
                        ),
                        label: const Text(
                          "Av: B QD: 298 LT:23 - Cidade Jardim, Parauapebas - PA, 68515-000",
                          style: TextStyle(fontSize: 22),
                        ),
                        onPressed: () {
                          Url().urlMaps();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
