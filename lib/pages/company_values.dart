import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:velocity_net/components/appbar/app_bar_component.dart';
import 'package:velocity_net/components/appbar/app_bar_component_resize.dart';
import 'package:velocity_net/components/copyright/copyright.dart';
import 'package:velocity_net/components/endDrawer/end_drawer.dart';
import 'package:velocity_net/components/footer/footer.dart';

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
          ? EndDrawer(
              scrollController: scrollController,
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
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Image.asset(
                      'logo2.png',
                      width:
                          MediaQuery.of(context).size.width < 700 ? 400 : 700,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 50, bottom: 50),
              child: Text(
                'Guiados por Missão, Moldados por Visão, Sustentados por Valores',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width < 600 ? 30 : 40,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50, right: 20, left: 20),
              child: Wrap(
                runSpacing: 20,
                alignment: WrapAlignment.center,
                spacing: 30,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width < 600 ? 400 : 490,
                    width: MediaQuery.of(context).size.width < 600 ? 300 : 390,
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
                        Text(
                          'MISSÃO',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width < 600
                                  ? 30
                                  : 40,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            textAlign: TextAlign.center,
                            'O propósito, a razão pela qual a empresa existe',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width < 600
                                        ? 25
                                        : 30,
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
                    height: MediaQuery.of(context).size.width < 600 ? 400 : 490,
                    width: MediaQuery.of(context).size.width < 600 ? 300 : 390,
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
                        Text(
                          'VISÃO',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width < 600
                                  ? 30
                                  : 40,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            textAlign: TextAlign.center,
                            'Onde a empresa deseja chegar no futuro ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width < 600
                                        ? 25
                                        : 30,
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
                    height: MediaQuery.of(context).size.width < 600 ? 400 : 490,
                    width: MediaQuery.of(context).size.width < 600 ? 300 : 390,
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
                        Text(
                          'VALORES',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width < 600
                                  ? 30
                                  : 40,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            textAlign: TextAlign.center,
                            'Ponte entre o que a empresa é e onde ela quer chegar.',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width < 600
                                        ? 25
                                        : 30,
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
