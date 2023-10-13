import 'package:flutter/material.dart';
import 'package:hexagon/hexagon.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:velocity_net/components/appbar/app_bar_component.dart';
import 'package:velocity_net/components/appbar/app_bar_component_resize.dart';
import 'package:velocity_net/components/copyright/copyright.dart';
import 'package:velocity_net/components/footer/footer.dart';
import 'package:velocity_net/helpers/url.dart';

class CompanyValues extends StatefulWidget {
  const CompanyValues({super.key});

  @override
  State<CompanyValues> createState() => _CompanyValuesState();
}

class _CompanyValuesState extends State<CompanyValues> {
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
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 815,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'banner_visao.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('logo2.png', width: MediaQuery.of(context).size.width < 700 ? 400 : 700),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 50, bottom: 50),
              child: Text(
                  'Guiados por Missão, Moldados por Visão, Sustentados por Valores', textAlign: TextAlign.center, style: TextStyle(fontSize: 40),),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Wrap(
                runSpacing:20,
                alignment: WrapAlignment.center,
                spacing: 30,
                children: [
                  Container(
                    height: 490,
                    width: 400,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'mission_vision_values/missao.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PhosphorIcon(
                          PhosphorIcons.regular.target,
                          color: Colors.white,
                          size: 60,
                        ),
                        const Text(
                          'MISSÃO',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 45,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            textAlign: TextAlign.center,
                            'O propósito, a razão pela qual a empresa existe',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 490,
                    width: 400,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'mission_vision_values/visao.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PhosphorIcon(
                          PhosphorIcons.regular.eye,
                          color: Colors.white,
                          size: 60,
                        ),
                        const Text(
                          'VISÃO',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 45,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            textAlign: TextAlign.center,
                            'Onde a empresa deseja chegar no futuro ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 490,
                    width: 400,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'mission_vision_values/valores.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PhosphorIcon(
                          PhosphorIcons.regular.heart,
                          color: Colors.white,
                          size: 60,
                        ),
                        const Text(
                          'VALORES',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 45,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            textAlign: TextAlign.center,
                            'Ponte entre o que a empresa é e onde ela quer chegar.',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
             const Footer(),
               const Copyright()
          ],
        ),
      ),
    );
  }
}