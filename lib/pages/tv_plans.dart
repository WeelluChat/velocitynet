import 'package:contained_tab_bar_view_with_custom_page_navigator/contained_tab_bar_view_with_custom_page_navigator.dart';
import 'package:flutter/material.dart';
import 'package:velocity_net/components/appbar/app_bar_component.dart';
import 'package:velocity_net/components/appbar/app_bar_component_resize.dart';
import 'package:velocity_net/components/copyright/copyright.dart';
import 'package:velocity_net/components/endDrawer/end_drawer.dart';
import 'package:velocity_net/components/footer/footer.dart';
import 'package:velocity_net/helpers/url.dart';

class TvPlans extends StatefulWidget {
  const TvPlans({super.key});

  @override
  State<TvPlans> createState() => _TvPlansState();
}

class _TvPlansState extends State<TvPlans> {
  bool mobile = false;
  final ScrollController scrollController = ScrollController();
  final List<String> lifeLinePlans = [
    'tv_plans/agro_canal.png',
    'tv_plans/aparecida_logo.png',
    'tv_plans/band_logo.png',
    'tv_plans/canal_do_boi_logo.png',
    'tv_plans/cultura_logo.webp',
    'tv_plans/globo_logo.png',
    'tv_plans/mega_tv_logo.png',
    'tv_plans/ngt_logo.png',
    'tv_plans/polishop_logo.png',
    'tv_plans/record_logo.png',
    'tv_plans/redebrasil_logo.png',
    'tv_plans/redetv_logo.png',
    'tv_plans/redevida_logo.png',
    'tv_plans/sbt_logo.webp',
    'tv_plans/terra_viva_logo.png',
    'tv_plans/TV_Escola_logo.png',
    'tv_plans/tv_senado_logo.png',
    'tv_plans/urban_movie_logo.png',
    'tv_plans/urban_serie_logo.png',
    'tv_plans/urbans_kids_logo.png',
  ];

  final List<String> topHD = [
    'topHD/animal_planet_logo.png',
    'topHD/band_sports_logo.png',
    'topHD/discovery_investigation_logo.png',
    'topHD/dreamworks_logo.png',
    'topHD/espn4_logo.png',
    'topHD/food_network_logo.png',
    'topHD/sony_movie_logo.png',
    'topHD/cnn_internacional_logo.png',
    'topHD/espn_logo.png',
    'topHD/hgtv_logo.webp',
    'topHD/lifetime_logo.png',
    'topHD/tnt_series_logo.png',
    'topHD/history2_logo.png',
    'topHD/disney_channel.png',
    'topHD/tlc_logo.png',
    'topHD/FX_logo.png',
    'topHD/space_channel_logo.png',
    'topHD/amc_logo.png',
    'topHD/cine_canal_logo.png',
    'topHD/discovery_turbo_logo.png'
  ];

  final List<String> startHD = [
    'startHD/bandNews_logo.png',
    'startHD/discovery_channel_logo.png',
    'startHD/hh_discovery_logo.png',
    'startHD/warner_channel_logo.png',
    'startHD/History_logo.png',
    'startHD/cartoon_logo.png',
    'startHD/cnn_brasil_logo.png',
    'startHD/discovery_kids_logo.png',
    'startHD/espn_2_logo.png',
    'startHD/sonychannel_logo.jpg',
    'startHD/star_channel.png',
    'startHD/tnt_logo.webp',
    'startHD/play_tv_logo.webp',
    'startHD/national_logo.png',
    'startHD/discovery_channel_logo.png',
  ];

  final List<String> premiumHD = [
    'premiumHD/discovery_science_logo.png',
    'premiumHD/discovery_world_logo.webp',
    'premiumHD/filmArts_logo.png',
    'premiumHD/oSat_logo.png',
    'premiumHD/tcm_logo.png',
    'premiumHD/teacher_discovery_logo.webp',
    'premiumHD/ESPN3_Logo.png',
    'premiumHD/espn_extra_logo.webp',
    'premiumHD/tnt_novelas_logo.png',
  ];
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
                    'banner_tv_planos.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('tv_plans/logo.png', width: 420),
                  const SizedBox(
                    height: 80,
                  ),
                  const Text(
                    'ASSISTA PELO APLICATIVO',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    runSpacing: 10,
                    spacing: 20,
                    children: [
                      InkWell(
                        child: Image.asset(
                          'googleplay.png',
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                        onTap: () {
                          Url().urlPlayStore();
                        },
                      ),
                      InkWell(
                        onTap: () {
                          Url().urlAppStore();
                        },
                        child: Image.asset(
                          'apple_store.png',
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding:
                  EdgeInsets.only(top: 50, bottom: 50, left: 20, right: 20),
              child: Text(
                textAlign: TextAlign.center,
                'ESCOLHA O PLANO IDEAL PARA VOCÊ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                color: const Color(0xff081E38),
                width: 1000,
                height: MediaQuery.of(context).size.width < 700 ? 590 : 950,
                child: ContainedTabBarView(
                  tabBarProperties: const TabBarProperties(
                      indicatorWeight: 5,
                      indicatorColor: Color(0xffFFB000),
                      indicatorSize: TabBarIndicatorSize.tab),
                  tabs: const [
                    Text(
                      'LIFE LINE',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'START HD',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'TOP HD',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      'PREMIUM HD',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                  views: [
                    Container(
                      color: const Color(0xffF1F1F1),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      '+60 CANAIS DE TV',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width <
                                                  600
                                              ? 20
                                              : 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '+500h de VOD',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize:
                                            MediaQuery.of(context).size.width <
                                                    600
                                                ? 20
                                                : 25,
                                      ),
                                    ),
                                    Text(
                                      'GRATIS PARA CLIENTES',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width <
                                                  600
                                              ? 15
                                              : 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: GridView.builder(
                              itemBuilder: (context, index) {
                                return Container(
                                  padding:
                                      MediaQuery.of(context).size.width < 600
                                          ? const EdgeInsets.all(5)
                                          : const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Image.asset(
                                    lifeLinePlans[index],
                                  ),
                                );
                              },
                              itemCount: lifeLinePlans.length,
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 20),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: const Color(0xffF1F1F1),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      '+80 CANAIS DE TV',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width <
                                                  600
                                              ? 20
                                              : 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '+2000h de VOD',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize:
                                            MediaQuery.of(context).size.width <
                                                    600
                                                ? 20
                                                : 25,
                                      ),
                                    ),
                                    Text(
                                      'R\$ 79,90 por mês',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width <
                                                  600
                                              ? 15
                                              : 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.add_circle,
                                          color: Color(0xff081E38),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'LIFE LINE',
                                          style: TextStyle(
                                              color: const Color(0xff081E38),
                                              fontSize: MediaQuery.of(context)
                                                          .size
                                                          .width <
                                                      600
                                                  ? 15
                                                  : 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: GridView.builder(
                              itemBuilder: (context, index) {
                                return Container(
                                  padding:
                                      MediaQuery.of(context).size.width < 600
                                          ? const EdgeInsets.all(5)
                                          : const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Image.asset(
                                    startHD[index],
                                  ),
                                );
                              },
                              itemCount: startHD.length,
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 20),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: const Color(0xffF1F1F1),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      '+120 CANAIS DE TV',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width <
                                                  600
                                              ? 20
                                              : 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '+3000h de VOD',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize:
                                            MediaQuery.of(context).size.width <
                                                    600
                                                ? 20
                                                : 25,
                                      ),
                                    ),
                                    Text(
                                      'R\$ 119,90 por mês',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width <
                                                  600
                                              ? 15
                                              : 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.add_circle,
                                          color: Color(0xff081E38),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'LIFE LINE',
                                          style: TextStyle(
                                              color: const Color(0xff081E38),
                                              fontSize: MediaQuery.of(context)
                                                          .size
                                                          .width <
                                                      600
                                                  ? 15
                                                  : 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        const Icon(
                                          Icons.add_circle,
                                          color: Color(0xff081E38),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'START HD',
                                          style: TextStyle(
                                              color: const Color(0xff081E38),
                                              fontSize: MediaQuery.of(context)
                                                          .size
                                                          .width <
                                                      600
                                                  ? 15
                                                  : 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: GridView.builder(
                              itemBuilder: (context, index) {
                                return Container(
                                  padding:
                                      MediaQuery.of(context).size.width < 600
                                          ? const EdgeInsets.all(5)
                                          : const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Image.asset(
                                    topHD[index],
                                  ),
                                );
                              },
                              itemCount: topHD.length,
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 20),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: const Color(0xffF1F1F1),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      '+130 CANAIS DE TV',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width <
                                                  600
                                              ? 20
                                              : 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '+4000h de VOD',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize:
                                            MediaQuery.of(context).size.width <
                                                    600
                                                ? 20
                                                : 25,
                                      ),
                                    ),
                                    Text(
                                      'R\$ 149,90 por mês',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width <
                                                  600
                                              ? 15
                                              : 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.add_circle,
                                          color: Color(0xff081E38),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'LIFE LINE',
                                          style: TextStyle(
                                              color: const Color(0xff081E38),
                                              fontSize: MediaQuery.of(context)
                                                          .size
                                                          .width <
                                                      600
                                                  ? 15
                                                  : 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        const Icon(
                                          Icons.add_circle,
                                          color: Color(0xff081E38),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'START HD',
                                          style: TextStyle(
                                              color: const Color(0xff081E38),
                                              fontSize: MediaQuery.of(context)
                                                          .size
                                                          .width <
                                                      600
                                                  ? 15
                                                  : 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        const Icon(
                                          Icons.add_circle,
                                          color: Color(0xff081E38),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'TOP HD',
                                          style: TextStyle(
                                              color: const Color(0xff081E38),
                                              fontSize: MediaQuery.of(context)
                                                          .size
                                                          .width <
                                                      600
                                                  ? 15
                                                  : 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: GridView.builder(
                              itemBuilder: (context, index) {
                                return Container(
                                  padding:
                                      MediaQuery.of(context).size.width < 600
                                          ? const EdgeInsets.all(5)
                                          : const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Image.asset(
                                    premiumHD[index],
                                  ),
                                );
                              },
                              itemCount: premiumHD.length,
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 20),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Footer(),
            const Copyright(),
          ],
        ),
      ),
    );
  }
}
