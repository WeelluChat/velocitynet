import 'package:contained_tab_bar_view_with_custom_page_navigator/contained_tab_bar_view_with_custom_page_navigator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_net/modules/footer/footer.dart';
import 'package:velocity_net/modules/appbar/app_bar_component.dart';
import 'package:velocity_net/modules/appbar/app_bar_component_resize.dart';
import 'package:velocity_net/modules/endDrawer/end_drawer.dart';

class Oletv extends StatefulWidget {
  const Oletv({super.key});

  @override
  State<Oletv> createState() => _OletvState();
}

class _OletvState extends State<Oletv> {
  final ScrollController scrollController = ScrollController();

  final List<String> lifeLinePlans = [
    'assets/tv_plans/agro_canal.png',
    'assets/tv_plans/aparecida_logo.png',
    'assets/tv_plans/band_logo.png',
    'assets/tv_plans/canal_do_boi_logo.png',
    'assets/tv_plans/cultura_logo.webp',
    'assets/tv_plans/globo_logo.png',
    'assets/tv_plans/mega_tv_logo.png',
    'assets/tv_plans/ngt_logo.png',
    'assets/tv_plans/polishop_logo.png',
    'assets/tv_plans/record_logo.png',
    'assets/tv_plans/redebrasil_logo.png',
    'assets/tv_plans/redetv_logo.png',
    'assets/tv_plans/redevida_logo.png',
    'assets/tv_plans/sbt_logo.webp',
    'assets/tv_plans/terra_viva_logo.png',
    'assets/tv_plans/TV_Escola_logo.png',
    'assets/tv_plans/tv_senado_logo.png',
    'assets/tv_plans/urban_movie_logo.png',
    'assets/tv_plans/urban_serie_logo.png',
    'assets/tv_plans/urbans_kids_logo.png',
  ];

  final List<String> topHD = [
    'assets/topHD/animal_planet_logo.png',
    'assets/topHD/band_sports_logo.png',
    'assets/topHD/discovery_investigation_logo.png',
    'assets/topHD/dreamworks_logo.png',
    'assets/topHD/espn4_logo.png',
    'assets/topHD/food_network_logo.png',
    'assets/topHD/sony_movie_logo.png',
    'assets/topHD/cnn_internacional_logo.png',
    'assets/topHD/espn_logo.png',
    'assets/topHD/hgtv_logo.webp',
    'assets/topHD/lifetime_logo.png',
    'assets/topHD/tnt_series_logo.png',
    'assets/topHD/history2_logo.png',
    'assets/topHD/disney_channel.png',
    'assets/topHD/tlc_logo.png',
    'assets/topHD/FX_logo.png',
    'assets/topHD/space_channel_logo.png',
    'assets/topHD/amc_logo.png',
    'assets/topHD/cine_canal_logo.png',
    'assets/topHD/discovery_turbo_logo.png'
  ];

  final List<String> startHD = [
    'assets/startHD/bandNews_logo.png',
    'assets/startHD/discovery_channel_logo.png',
    'assets/startHD/hh_discovery_logo.png',
    'assets/startHD/warner_channel_logo.png',
    'assets/startHD/History_logo.png',
    'assets/startHD/cartoon_logo.png',
    'assets/startHD/cnn_brasil_logo.png',
    'assets/startHD/discovery_kids_logo.png',
    'assets/startHD/espn_2_logo.png',
    'assets/startHD/sonychannel_logo.jpg',
    'assets/startHD/star_channel.png',
    'assets/startHD/tnt_logo.webp',
    'assets/startHD/play_tv_logo.webp',
    'assets/startHD/national_logo.png',
    'assets/startHD/discovery_channel_logo.png',
  ];

  final List<String> premiumHD = [
    'assets/premiumHD/discovery_science_logo.png',
    'assets/premiumHD/discovery_world_logo.webp',
    'assets/premiumHD/filmArts_logo.png',
    'assets/premiumHD/oSat_logo.png',
    'assets/premiumHD/tcm_logo.png',
    'assets/premiumHD/teacher_discovery_logo.webp',
    'assets/premiumHD/ESPN3_Logo.png',
    'assets/premiumHD/espn_extra_logo.webp',
    'assets/premiumHD/tnt_novelas_logo.png',
  ];

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 1200;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 153, 189, 240),
      appBar: PreferredSize(
        preferredSize: isMobile ? const Size.fromHeight(80) : const Size.fromHeight(100),
        child: isMobile ? const AppBarComponentResize() : AppBarComponent(scrollController: scrollController),
      ),
      endDrawer: isMobile ? EndDrawer(scrollController: scrollController) : null,
      body: Container(
        color: const Color(0xFFEAF1FB),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              Container(
                height: isMobile ? 400 : 700,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/group.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: isMobile ? 80 : 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => launchUrl(Uri.parse('https://play.google.com/store/apps/details?id=br.tv.ole.oletv&hl=en_US')),
                          child: Image.asset('assets/googlestore.png', height: isMobile ? 70 : 100, width: isMobile ? 140 : 200),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () => launchUrl(Uri.parse('https://apps.apple.com/br/app/ol%C3%A9-tv/id1301299065')),
                          child: Image.asset('assets/appstore.png', height: isMobile ? 70 : 100, width: isMobile ? 126 : 180),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 0, vertical: 30),
                child: Column(
                  children: [
                    Text(
                      'ESCOLHA O PLANO IDEAL PARA VOCÊ!',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF13294E),
                        fontSize: isMobile ? 24 : 40,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF13294E),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      width: isMobile ? 350 : 650,
                      height: isMobile ? 900 : 800,
                      child: ContainedTabBarView(
                        tabBarProperties: TabBarProperties(
                          labelColor: Colors.transparent,
                          indicatorColor: Colors.blue,
                          height: isMobile ? 60 : 48,
                        ),
                        tabs: [
                          _tabLabel('Life Line', isMobile),
                          _tabLabel('Start HD', isMobile),
                          _tabLabel('Top HD', isMobile),
                          _tabLabel('Premium HD', isMobile),
                        ],
                        views: [
                          _buildPlanTab(context, isMobile, '+60 CANAIS DE TV', '+500h de VOD', 'GRÁTIS PARA CLIENTES', lifeLinePlans, []),
                          _buildPlanTab(context, isMobile, '+80 CANAIS DE TV', '+2000h de VOD', 'R\$ 79,90/mês', startHD, ['LIFE LINE']),
                          _buildPlanTab(context, isMobile, '+120 CANAIS DE TV', '+3000h de VOD', 'R\$ 119,90/mês', topHD, ['LIFE LINE', 'START HD']),
                          _buildPlanTab(context, isMobile, '+130 CANAIS DE TV', '+4000h de VOD', 'R\$ 149,90/mês', premiumHD, ['LIFE LINE', 'START HD', 'TOP HD']),
                        ],
                      ),
                    ),
                    SizedBox(height: isMobile ? 40 : 100),
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

  Widget _tabLabel(String title, bool isMobile) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 8 : 0),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontSize: isMobile ? 14 : 20,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildPlanTab(BuildContext context, bool isMobile, String channelCount, String vodHours, String price, List<String> images, List<String> includedPlans) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        color: Color(0xFFEAF1FB),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text(channelCount, style: GoogleFonts.poppins(fontSize: isMobile ? 16 : 20, fontWeight: FontWeight.w500, color: Colors.black)),
          Text(vodHours, style: GoogleFonts.poppins(fontSize: isMobile ? 16 : 20, color: Colors.blue, fontWeight: FontWeight.w500)),
          Text(price, style: GoogleFonts.poppins(fontSize: isMobile ? 16 : 20, color: Colors.green, fontWeight: FontWeight.w500)),
          if (includedPlans.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: isMobile ? 4 : 8,
                runSpacing: isMobile ? 4 : 0,
                children: includedPlans.map((plan) {
                  return Chip(
                    avatar: const Icon(Icons.add_circle, size: 18, color: Colors.blue),
                    label: Text(plan, style: GoogleFonts.poppins(fontSize: isMobile ? 14 : 18)),
                    backgroundColor: Colors.blue[50],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  );
                }).toList(),
              ),
            ),
          Expanded(
            child: GridView.builder(
              itemCount: images.length,
              padding: const EdgeInsets.all(20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isMobile ? 3 : 5,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Image.asset(images[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
