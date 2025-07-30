import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

// ==================== CONSTANTES ====================
const Color textColor = Colors.black;
const Color megaColor = Color.fromARGB(255, 5, 45, 83);
const Color cardMega = Colors.white;
const Color tabSelectedColor = Color(0xFF0A84FF);
const Color tabUnselectedColor = Color(0xFFE0E0E0);
const Color tabTextSelectedColor = Colors.white;
const Color tabTextUnselectedColor = Color(0xFF757575);
const Color backgroundColor = Color(0xFFF8F9FA);
const Color borderColor = Color(0xFFE0E0E0);
const Color accentColor = Color(0xFFE3F2FD);

// ==================== MODELOS ====================
class SelectedApp {
  final String name;
  final int price;
  final String image;
  final bool isVisible;

  SelectedApp({
    required this.name,
    required this.price,
    required this.image,
    required this.isVisible,
  });

  SelectedApp copyWith({
    String? name,
    int? price,
    String? image,
    bool? isVisible,
  }) {
    return SelectedApp(
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      isVisible: isVisible ?? this.isVisible,
    );
  }
}

class SelectedCombo {
  final String mega;
  final int megaPrice;
  final List<SelectedApp> apps;
  final int total;
  final bool isVisible;

  SelectedCombo({
    required this.mega,
    required this.megaPrice,
    required this.apps,
    required this.total,
    required this.isVisible,
  });

  SelectedCombo copyWith({
    String? mega,
    int? megaPrice,
    List<SelectedApp>? apps,
    int? total,
    bool? isVisible,
  }) {
    return SelectedCombo(
      mega: mega ?? this.mega,
      megaPrice: megaPrice ?? this.megaPrice,
      apps: apps ?? this.apps,
      total: total ?? this.total,
      isVisible: isVisible ?? this.isVisible,
    );
  }
}

// ==================== SERVIÇO API ====================
class ApiService {
  static const String baseUrl = 'https://api.velocitynet.com.br/api/v1';
  // static const String baseImageUrl = "https://api.velocitynet.com.br/";
  static const String uploadsUrl =
      'https://api.velocitynet.com.br/uploads/category/';

  Future<List<dynamic>> getPlanos() async {
    try {
      final url = Uri.parse('$baseUrl/planos');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        if (decodedResponse is List) return decodedResponse;
        throw Exception('Formato de resposta inválido');
      }
      throw Exception('Falha ao carregar dados: ${response.statusCode}');
    } catch (e) {
      throw Exception('Erro na requisição: $e');
    }
  }

  Future<List<dynamic>> getCategoryPlans() async {
    try {
      final url = Uri.parse('$baseUrl/category-plan');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      throw Exception('Falha ao carregar dados: ${response.statusCode}');
    } catch (e) {
      throw Exception('Erro na requisição: $e');
    }
  }

  List<dynamic> filterPlans(List<dynamic> plans, String keyword) {
    return plans.where((item) {
      final nome = (item['nome'] ?? '').toString().toLowerCase();
      final isVisible = item['isVisible'] ?? true;
      return nome.contains(keyword.toLowerCase()) && isVisible;
    }).toList();
  }

  String getImageUrl(String? path) {
    if (path == null || path.isEmpty) return '';
    return '$uploadsUrl$path';
  }
}

// ==================== WIDGET PRINCIPAL ====================
class Paraempresa extends StatefulWidget {
  final Function(SelectedCombo)? onComboUpdated;
  final SelectedCombo? selectedCombo;
  final Function(int)? onRemoveApp;
  final Function()? onRemoveInternet;

  const Paraempresa({
    super.key,
    this.onComboUpdated,
    this.selectedCombo,
    this.onRemoveApp,
    this.onRemoveInternet,
  });

  @override
  State<Paraempresa> createState() => _ParaempresaState();
}

class _ParaempresaState extends State<Paraempresa>
    with TickerProviderStateMixin {
  // Estados para planos de internet
  int _selectedMegaIndex = -1;
  List<int> _selectedAppIndices = [];
  bool _isLoading = true;
  String _errorMessage = '';
  List<dynamic> _combos = [];
  List<dynamic> _planos = [];
  List<SelectedApp> _beneficios = [];
  TabController? _tabController;

  // Estados para planos de streaming
  List<dynamic> telecinePlans = [];
  List<dynamic> maxPlans = [];
  List<dynamic> premierePlans = [];
  List<dynamic> deezerPlans = [];
  List<dynamic> globoplayPlans = [];

  bool isLoadingTelecine = true;
  bool isLoadingMax = true;
  bool isLoadingPremiere = true;
  bool isLoadingDeezer = true;
  bool isLoadingGloboplay = true;

  // Controladores para abas
  TabController? _streamingTabController;
  int _currentStreamingTabIndex = 0;
  int _currentMainTabIndex = 0;

  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _loadPlanos();
    _loadStreamingPlans();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _streamingTabController?.dispose();
    super.dispose();
  }

  Future<void> _loadStreamingPlans() async {
    try {
      final categoryPlans = await _apiService.getCategoryPlans();

      setState(() {
        telecinePlans = _apiService.filterPlans(categoryPlans, 'telecine');
        maxPlans = _apiService.filterPlans(categoryPlans, 'max');
        premierePlans = _apiService.filterPlans(categoryPlans, 'premiere');
        deezerPlans = _apiService.filterPlans(categoryPlans, 'deezeer');
        globoplayPlans = _apiService.filterPlans(categoryPlans, 'Globoplay');
        // globoplayPlans = _apiService
        //     .filterPlans(categoryPlans, 'Globoplay')
        //     .where((e) =>
        //         !(e['nome'] ?? '').toString().toLowerCase().contains('canais'))
        //     .toList();

        isLoadingTelecine = false;
        isLoadingMax = false;
        isLoadingPremiere = false;
        isLoadingDeezer = false;
        isLoadingGloboplay = false;

        _streamingTabController = TabController(
          length: 5,
          vsync: this,
          initialIndex: _currentStreamingTabIndex,
        );
      });
    } catch (e) {
      setState(() {
        isLoadingTelecine = false;
        isLoadingMax = false;
        isLoadingPremiere = false;
        isLoadingDeezer = false;
        isLoadingGloboplay = false;
      });
    }
  }

  @override
  void didUpdateWidget(covariant Paraempresa oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedCombo != oldWidget.selectedCombo) {
      _syncWithSelectedCombo();
    }
  }

  void _syncWithSelectedCombo() {
    if (widget.selectedCombo == null) {
      _selectedMegaIndex = -1;
      _selectedAppIndices.clear();
      return;
    }

    if (widget.selectedCombo!.mega.isEmpty) {
      _selectedMegaIndex = -1;
      _selectedAppIndices.clear();
      return;
    }

    for (int i = 0; i < _planos.length; i++) {
      final plano = _planos[i];
      final planoMega = (plano['nome'] as String).replaceAll('MEGA', '').trim();
      if (planoMega == widget.selectedCombo!.mega) {
        _selectedMegaIndex = i;
        break;
      }
    }

    _selectedAppIndices.clear();
    for (final selectedApp in widget.selectedCombo!.apps) {
      for (int i = 0; i < _beneficios.length; i++) {
        if (_beneficios[i].name == selectedApp.name) {
          _selectedAppIndices.add(i);
          break;
        }
      }
    }
  }

  Future<void> _loadPlanos() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      final data = await _apiService.getPlanos();

      if (data.isNotEmpty) {
        setState(() {
          _combos = data;
          _tabController =
              TabController(length: _combos.length + 4, vsync: this);
          _loadFirstCombo();
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Nenhum plano disponível no momento';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Erro ao carregar planos: ${e.toString()}';
      });
    }
  }

  void _loadFirstCombo() {
    final visibleCombos =
        _combos.where((combo) => combo['isVisible'] ?? true).toList();
    if (visibleCombos.isNotEmpty) {
      final firstCombo = visibleCombos.first;
      final planos = (firstCombo['planos'] as List)
          .where((plano) => plano['isVisible'] ?? true)
          .toList();
      final beneficios = planos.isNotEmpty
          ? _processBenefits(planos.first['beneficios'] as List? ?? [])
          : [];

      setState(() {
        _planos = planos;
        _beneficios = beneficios.cast<SelectedApp>();
        _syncWithSelectedCombo();
      });
    }
  }

  void _onTabChanged(int index) {
    final visibleCombos =
        _combos.where((combo) => combo['isVisible'] ?? true).toList();
    if (visibleCombos.isNotEmpty && index < visibleCombos.length) {
      final combo = visibleCombos[index];
      final planos = (combo['planos'] as List)
          .where((plano) => plano['isVisible'] ?? true)
          .toList();
      final beneficios = planos.isNotEmpty
          ? _processBenefits(planos.first['beneficios'] as List? ?? [])
          : [];

      setState(() {
        _planos = planos;
        _beneficios = beneficios.cast<SelectedApp>();
        _selectedMegaIndex = -1;
        _selectedAppIndices.clear();
        widget.onComboUpdated?.call(SelectedCombo(
          mega: "",
          megaPrice: 0,
          apps: [],
          total: 0,
          isVisible: false,
        ));
      });
    }
  }

  List<SelectedApp> _processBenefits(List<dynamic> beneficios) {
    return beneficios.map<SelectedApp>((b) {
      return SelectedApp(
        name: b['nome'] ?? 'App sem nome',
        price: (b['valor'] as num?)?.toInt() ?? 0,
        image: b['image'] ?? 'assets/default_app.png',
        isVisible: b['isVisible'] ?? true,
      );
    }).toList();
  }

  List<int> get currentAppValues {
    if (_selectedMegaIndex == -1 || _planos.isEmpty) {
      return List.filled(_beneficios.length, 0);
    }

    final selectedPlano = _planos[_selectedMegaIndex];
    if (selectedPlano['beneficios'] is! List) {
      return List.filled(_beneficios.length, 0);
    }

    return (selectedPlano['beneficios'] as List).map<int>((b) {
      return (b['valor'] as num?)?.toInt() ?? 0;
    }).toList();
  }

  int get _selectedMegaValue {
    if (_selectedMegaIndex == -1 || _planos.isEmpty) return 0;
    return (_planos[_selectedMegaIndex]['valor'] as num).toInt();
  }

  int get _selectedAppValue {
    return _selectedAppIndices.fold(
        0, (sum, index) => sum + currentAppValues[index]);
  }

  int get totalValue => _selectedMegaValue + _selectedAppValue;

  void _updateSelectedCombo() {
    if (_selectedMegaIndex == -1) {
      widget.onComboUpdated?.call(SelectedCombo(
        mega: "",
        megaPrice: 0,
        apps: [],
        total: 0,
        isVisible: false,
      ));
      return;
    }

    final selectedPlan = _planos[_selectedMegaIndex];
    final selectedBenefits =
        _selectedAppIndices.map((i) => _beneficios[i]).toList();
    final newCombo = SelectedCombo(
      mega: selectedPlan['nome'].replaceAll('MEGA', '').trim(),
      megaPrice: (selectedPlan['valor'] as num).toInt(),
      apps: selectedBenefits,
      total: totalValue,
      isVisible: selectedPlan['isVisible'] ?? true,
    );

    widget.onComboUpdated?.call(newCombo);
  }

  void _selectPlan(int index) {
    setState(() {
      if (_selectedMegaIndex == index) {
        _selectedMegaIndex = -1;
        _selectedAppIndices.clear();
      } else {
        _selectedMegaIndex = index;
        _selectedAppIndices.clear();
        _beneficios = _processBenefits(_planos[index]['beneficios'] as List);
      }
      _updateSelectedCombo();
    });
  }

  void _toggleAppSelection(int index) {
    setState(() {
      if (_selectedAppIndices.contains(index)) {
        _selectedAppIndices.remove(index);
      } else {
        _selectedAppIndices.add(index);
      }
      _updateSelectedCombo();
    });
  }

  // ==================== WIDGETS PARA STREAMING ====================

  Widget _buildStreamingPlansList(List<dynamic> plans, bool isMobile) {
    if (plans.isEmpty) {
      return Center(
        child: Text(
          'Nenhum plano encontrado',
          style: GoogleFonts.poppins(
            color: Colors.black54,
            fontSize: isMobile ? 14 : 16,
          ),
        ),
      );
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(12),
      itemCount: plans.length,
      itemBuilder: (context, index) {
        final plan = plans[index];
        final List<dynamic> images = (plan['images'] as List?)
                ?.where((img) => img['isVisible'] ?? true)
                .toList() ??
            [];
        final logoUrl = _apiService.getImageUrl(plan['logo']);
        final ScrollController scrollController = ScrollController();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (logoUrl.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Image.network(
                  logoUrl,
                  height: 50,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: const Icon(Icons.broken_image,
                        size: 40, color: Colors.grey),
                  ),
                ),
              ),
            const SizedBox(height: 10),
            Center(
              child: Container(
                width: isMobile ? 400 : 1250,
                height: isMobile ? 735 : 607,
                child: Center(
                  child: Stack(
                    children: [
                      ListView.builder(
                        controller: scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: images.length,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        itemBuilder: (context, i) {
                          final imgUrl =
                              _apiService.getImageUrl(images[i]['filename']);
                              SizedBox(height: 30,);
                          return Container(
                            width: isMobile ? 290 : 260,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                             
                              
                            ),
                            child: Column(
                              children: [
                                if (isMobile)
                                  Column(
                                    children: [
                                      SizedBox(height: 50,),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: Image.network(
                                            imgUrl,
                                            fit: BoxFit.contain,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    Container(
                                              color: accentColor,
                                              alignment: Alignment.center,
                                              child: const Icon(
                                                  Icons.broken_image,
                                                  size: 40,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  )
                                else
                                  Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          imgUrl,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Container(
                                            color: accentColor,
                                            alignment: Alignment.center,
                                            child: const Icon(Icons.broken_image,
                                                size: 40, color: Colors.grey),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(colors: [
                                        Color.fromARGB(255, 43, 208, 219),
                                        Color.fromARGB(255, 9, 52, 117),
                                      ]),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(PhosphorIcons.whatsapp_logo),
                                        TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            "FAÇA SEU CONTRATO",
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                  
                      /// Botão esquerdo
                      Positioned(
                        left: 0,
                        top: 0,
                        bottom: 0,
                        child: Center(
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios),
                            color: const Color.fromARGB(255, 109, 109, 109),
                            onPressed: () {
                              scrollController.animateTo(
                                scrollController.offset - 315,
                                duration: const Duration(milliseconds: 350),
                                curve: Curves.ease,
                              );
                            },
                          ),
                        ),
                      ),
                  
                      /// Botão direito
                      Positioned(
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: Center(
                          child: IconButton(
                            icon: const Icon(Icons.arrow_forward_ios),
                            color: const Color.fromARGB(255, 109, 109, 109),
                            onPressed: () {
                              scrollController.animateTo(
                                scrollController.offset + 315,
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.ease,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        );
      },
    );
  }

  // Widget _buildStreamingTabContent() {
  //   final isMobile = MediaQuery.of(context).size.width < 600;

  //   return Column(
  //     children: [
  //       Container(
  //         margin: EdgeInsets.only(bottom: isMobile ? 15 : 20),
  //         child: Text(
  //           'Escolha seu plano de streaming',
  //           style: GoogleFonts.poppins(
  //             color: Colors.black,
  //             fontSize: isMobile ? 20 : 24,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //       ),
  //       Container(
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(12),
  //           border: Border.all(color: borderColor),
  //         ),
  //         child: TabBar(
  //           controller: _streamingTabController,
  //           indicator: BoxDecoration(
  //             borderRadius: BorderRadius.circular(10),
  //             color: tabSelectedColor,
  //           ),
  //           labelColor: Colors.white,
  //           unselectedLabelColor: Colors.black54,
  //           labelStyle: GoogleFonts.poppins(
  //             fontSize: isMobile ? 12 : 14,
  //             fontWeight: FontWeight.w600,
  //           ),
  //           unselectedLabelStyle: GoogleFonts.poppins(
  //             fontSize: isMobile ? 12 : 14,
  //             fontWeight: FontWeight.normal,
  //           ),
  //           isScrollable: true,
  //           tabs: const [
  //             Tab(text: '+TELECINE'),
  //             Tab(text: '+MAX'),
  //             Tab(text: '+PREMIERE'),
  //             Tab(text: '+DEEZER'),
  //             Tab(text: '+GLOBOPLAY'),
  //           ],
  //           onTap: (index) {
  //             setState(() {
  //               _currentStreamingTabIndex = index;
  //             });
  //           },
  //         ),
  //       ),
  //       const SizedBox(height: 20),
  //       Expanded(
  //         child: TabBarView(
  //           controller: _streamingTabController,
  //           children: [
  //             _buildStreamingTab(isLoadingTelecine, telecinePlans, isMobile),
  //             _buildStreamingTab(isLoadingMax, maxPlans, isMobile),
  //             _buildStreamingTab(isLoadingPremiere, premierePlans, isMobile),
  //             _buildStreamingTab(isLoadingDeezer, deezerPlans, isMobile),
  //             _buildStreamingTab(isLoadingGloboplay, globoplayPlans, isMobile),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildStreamingTab(
      bool isLoading, List<dynamic> plans, bool isMobile) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: tabSelectedColor),
      );
    }
    return _buildStreamingPlansList(plans, isMobile);
  }

  // ==================== WIDGETS PRINCIPAIS ====================

  @override
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: _buildInternetContent(isMobile),
    );
  }

  Widget _buildInternetContent(bool isMobile) {
    if (_isLoading) return _buildLoadingState();
    if (_errorMessage.isNotEmpty) return _buildErrorState();
    if (_tabController == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Container(
      decoration: const BoxDecoration(
       
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppBar(),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              ..._combos
                  .where((combo) => combo['isVisible'] ?? true)
                  .map<Widget>((combo) {
                return _buildComboContent();
              }).toList(),
              _buildStreamingTab(isLoadingTelecine, telecinePlans, isMobile),
              _buildStreamingTab(isLoadingMax, maxPlans, isMobile),
              _buildStreamingTab(isLoadingPremiere, premierePlans, isMobile),
              _buildStreamingTab(isLoadingDeezer, deezerPlans, isMobile),
              _buildStreamingTab(isLoadingGloboplay, globoplayPlans, isMobile),
            ]),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(90),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        ),
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.9,
          ),
          decoration: BoxDecoration(
            color: tabUnselectedColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: TabBar(
                controller: _tabController,
                onTap: _onTabChanged,
                isScrollable: true,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0A84FF), Color(0xFF0066CC)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: tabSelectedColor.withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 1,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                dividerColor: Colors.transparent,
                indicatorWeight: 0,
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: tabTextSelectedColor,
                unselectedLabelColor: tabTextUnselectedColor,
                labelStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                unselectedLabelStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
                tabs: [
                  ..._combos
                      .where((combo) => combo['isVisible'] ?? true)
                      .map<Widget>((combo) {
                    return Tab(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          combo['title'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  }),
                  const Tab(text: '+TELECINE'),
                  const Tab(text: '+MAX'),
                  const Tab(text: '+PREMIERE'),
                  const Tab(text: '+DEEZER'),
                  const Tab(text: '+GLOBOPLAY'),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}


  Widget _buildComboContent() {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final lateralPadding = isMobile ? 8.0 : 12.0;

    return ScreenUtilInit(
      designSize: isMobile ? const Size(360, 800) : const Size(1024, 768),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Container(
          padding: EdgeInsets.only(
            left: lateralPadding,
            right: lateralPadding,
          ),
          width: double.infinity,
          decoration: const BoxDecoration(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: isMobile ? 2.sp : 10.sp),
              isMobile
                  ? Column(
                      children: [
                        _buildMegaColumn(),
                        SizedBox(height: 10.sp),
                        _buildAppColumn(),
                        SizedBox(height: 10.sp),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildMegaColumn(),
                        SizedBox(width: 17.sp),
                        _buildAppColumn(),
                        SizedBox(width: 17.sp),
                        _buildSummaryColumn(),
                      ],
                    ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMegaColumn() {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final lateralPadding = isMobile ? 8.0 : 12.0;

    return Container(
      width: isMobile ? 500 - (2 * lateralPadding) : 300.sp,
      height: isMobile ? null : 376.sp,
      padding: EdgeInsets.only(bottom: 4.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: const Color.fromARGB(255, 230, 230, 230),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: isMobile ? MainAxisSize.min : MainAxisSize.max,
        children: [
          Container(
            height: 36.sp,
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Center(
              child: Text(
                'ESCOLHA A SUA VELOCIDADE',
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 13.sp : 10.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF495057),
                  letterSpacing: 0.5.sp,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.sp),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _planos.length,
              itemBuilder: (context, index) {
                final plano = _planos[index];
                return _buildMegaItem(plano, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMegaItem(dynamic plano, int index) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final isSelected = _selectedMegaIndex == index;
    final mega = (plano['nome'] as String).replaceAll('MEGA', '').trim();
    final price = (plano['valor'] as num).toInt();

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 6.sp : 8.sp,
        vertical: 8.sp,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => _selectPlan(index),
          child: Stack(
            children: [
              Container(
                width: isMobile ? double.infinity : 300.sp,
                height: isMobile ? 70.sp : 50.sp,
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFE7F5FF) : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF4DABF7)
                        : const Color(0xFFE9ECEF),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.only(left: 5.sp),
                        width: isMobile ? 170.sp : 170.sp,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildSelectionIndicator(isSelected),
                            SizedBox(width: 5.sp),
                            Flexible(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(),
                                      child: Text(
                                        mega,
                                        style: GoogleFonts.poppins(
                                          color: textColor,
                                          letterSpacing: -1.5.sp,
                                          fontSize: isMobile ? 220.sp : 50.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 1.sp),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: isMobile ? 2.sp : 3.sp),
                                      child: Text(
                                        'MEGAS',
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xFF228BE6),
                                          letterSpacing: 0.5.sp,
                                          fontSize: isMobile ? 150.sp : 30.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: isMobile
                          ? EdgeInsets.only(left: 5)
                          : EdgeInsetsGeometry.only(left: 30),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 13),
                        child: Container(
                          width: isMobile ? 120.sp : 120.sp,
                          padding: EdgeInsets.symmetric(horizontal: 3.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                'R\$',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF495057),
                                  fontSize: isMobile ? 13.sp : 13.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 1.sp),
                              Text(
                                '$price',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF212529),
                                  letterSpacing: -1.0.sp,
                                  fontSize: isMobile ? 30.sp : 25.sp,
                                  fontWeight: FontWeight.w700,
                                  height: 1.0,
                                ),
                              ),
                              SizedBox(width: 1),
                              Transform.translate(
                                offset: Offset(0, isMobile ? -13.sp : -8.sp),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, right: 10),
                                  child: Text(
                                    ',99',
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFF495057),
                                      fontSize: isMobile ? 10.sp : 13.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: isMobile ? 6.sp : 5.sp),
                      child: InkWell(
                        onTap: () {
                          _showSpeedDetails(context, mega, price);
                        },
                        child: Icon(
                          PhosphorIcons.info,
                          color: const Color(0xFF495057),
                          size: isMobile ? 20.sp : 20.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Positioned(
                  top: 4,
                  right: 4,
                  child: IconButton(
                    icon: Icon(Icons.close,
                        size: 18, color: const Color.fromARGB(0, 244, 67, 54)),
                    onPressed: () {
                      widget.onRemoveInternet?.call();
                      setState(() {
                        _selectedMegaIndex = -1;
                      });
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppColumn() {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final lateralPadding = isMobile ? 8.0 : 12.0;
    final bool isSpeedSelected = _selectedMegaIndex != -1;

    return Container(
      width: isMobile ? 500 - (2 * lateralPadding) : 300.sp,
      height: isMobile ? null : 376.sp,
      padding: EdgeInsets.only(bottom: 4.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: const Color(0xFFE9ECEF),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: isMobile ? MainAxisSize.min : MainAxisSize.max,
        children: [
          Container(
            height: 36.sp,
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Center(
              child: Text(
                'ESCOLHA SEUS STREAMING',
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 13.sp : 10.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF495057),
                  letterSpacing: 0.5.sp,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.sp),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _beneficios.length,
              itemBuilder: (context, index) {
                return _buildAppItem(index, isSpeedSelected);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppItem(int index, bool isSpeedSelected) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final bool isSelected = _selectedAppIndices.contains(index);
    final app = _beneficios[index];
    if (!app.isVisible) return const SizedBox.shrink();
    final bool isSvg = app.image.toLowerCase().startsWith('data:image/svg');
    final int appPrice = currentAppValues[index];

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 6.sp : 0.sp,
        vertical: 8.sp,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: isSpeedSelected ? () => _toggleAppSelection(index) : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: isMobile ? 300.sp : 280.sp,
                    height: isMobile ? 70.sp : 50.sp,
                    decoration: BoxDecoration(
                      color: isSelected && isSpeedSelected
                          ? const Color(0xFFE7F5FF)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected && isSpeedSelected
                            ? const Color(0xFF4DABF7)
                            : const Color(0xFFE9ECEF),
                        width: 1.5,
                      ),
                    ),
                    child: Padding(
                      padding: isMobile
                          ? const EdgeInsets.only(top: 3, left: 7, right: 10)
                          : const EdgeInsets.only(top: 8, left: 8, right: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildSelectionIndicator(
                              isSelected && isSpeedSelected),
                          SizedBox(
                            width: isMobile ? 110.sp : null,
                            height: isMobile ? 25.sp : null,
                            child: isSvg
                                ? SvgPicture.network(
                                    app.image,
                                    fit: BoxFit.cover,
                                  )
                                : _buildAppImage(app.image),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              InkWell(
                                onTap: () {
                                  _showAppDetails(context, app);
                                },
                                child: Icon(
                                  PhosphorIcons.info,
                                  color: const Color(0xFF495057),
                                  size: isMobile ? 20.sp : 20.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isSelected && isSpeedSelected)
                    Positioned(
                      top: 4,
                      right: 4,
                      child: IconButton(
                        icon: const Icon(
                          Icons.close,
                          size: 18,
                          color: Colors.transparent, // oculto
                        ),
                        onPressed: () {
                          widget.onRemoveApp?.call(index);
                          setState(() {
                            _selectedAppIndices.remove(index);
                          });
                        },
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryColumn() {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final lateralPadding = isMobile ? 8.0 : 12.0;
    final bool isSpeedSelected = _selectedMegaIndex != -1;

    return Container(
      width: isMobile ? 500 - (2 * lateralPadding) : 200.sp,
      height: isMobile ? 370 : 376.sp,
      padding: EdgeInsets.only(bottom: 4.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: const Color(0xFFE9ECEF),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: isMobile ? MainAxisSize.min : MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 8.sp : 6.sp,
                vertical: isMobile ? 4.sp : 4.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      '${_selectedAppIndices.length}',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF495057),
                        fontSize: isMobile ? 9.sp : 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 2.sp),
                    Icon(
                      PhosphorIcons.shopping_cart,
                      color: const Color(0xFF495057),
                      size: isMobile ? 9.sp : 12.sp,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: isMobile ? 260.sp : 150.sp,
            height: isMobile ? 28.sp : 30.sp,
            margin: EdgeInsets.symmetric(horizontal: isMobile ? 8.sp : 0),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFFE9ECEF),
              ),
            ),
            child: Center(
              child: Text(
                isSpeedSelected && _planos.isNotEmpty
                    ? '${(_planos[_selectedMegaIndex]['nome'] as String).replaceAll('MEGA', '').trim()} Megas'
                    : 'Selecione um plano',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF495057),
                  fontSize: isMobile ? 10.sp : 10.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(height: isMobile ? 4.sp : 8.sp),
          Container(
            width: isMobile ? 260.sp : 150.sp,
            height: isMobile ? 46.sp : 40.sp,
            margin: EdgeInsets.symmetric(horizontal: isMobile ? 8.sp : 0),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFFE9ECEF),
              ),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: isMobile ? 4.sp : 6.sp),
                    child: Text(
                      'R\$',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF495057),
                        fontSize: isMobile ? 12.sp : 8.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(width: 1.sp),
                  Text(
                    '$totalValue',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF212529),
                      fontSize: isMobile ? 28.sp : 19.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(0, isMobile ? -3.sp : -1.sp),
                    child: Text(
                      ',99',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF495057),
                        fontSize: isMobile ? 12.sp : 10.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (!isMobile) ...[
                    SizedBox(width: 2.sp),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'até o',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF495057),
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'vencimento',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF495057),
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
          Column(
            children: [
              if (isMobile) SizedBox(height: 3.sp),
              if (isMobile)
                Text(
                  'até o vencimento',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF495057),
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
          if (_selectedAppIndices.isNotEmpty)
            Container(
              width: isMobile ? 260.sp : 190.sp,
              height: isMobile ? 90.sp : 150.sp,
              padding:
                  EdgeInsets.symmetric(horizontal: isMobile ? 8.sp : 12.sp),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _selectedAppIndices.length,
                itemBuilder: (context, index) {
                  int appIndex = _selectedAppIndices[index];
                  String appName = _beneficios[appIndex].name;

                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: isMobile ? 1.sp : 4.sp,
                      horizontal: isMobile ? 0.sp : 8.sp,
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 4.sp : 4.sp,
                        vertical: isMobile ? 3.sp : 4.sp,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color(0xFFE9ECEF),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            appName,
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF212529),
                              fontSize: isMobile ? 9.sp : 8.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: isMobile ? 30.sp : 8.sp,
              horizontal: isMobile ? 10.sp : 10.sp,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(10.sp),
                onTap: isSpeedSelected
                    ? () {
                        if (_selectedMegaIndex == -1) return;

                        final selectedPlan = _planos[_selectedMegaIndex];
                        final selectedApps = _selectedAppIndices
                            .map((i) => _beneficios[i].name)
                            .join(', ');

                        final message =
                            'Olá, gostaria de contratar o plano ${selectedPlan['nome'].replaceAll('MEGA', '').trim()} MEGA '
                            'no valor de R\$ ${selectedPlan['valor']},99 '
                            '${_selectedAppIndices.isNotEmpty ? 'com os seguintes benefícios: $selectedApps' : 'sem benefícios adicionais'} '
                            '(Total: R\$ $totalValue,99)';

                        launchUrl(Uri.parse(
                            "https://api.whatsapp.com/send?phone=+5594992600430&text=${Uri.encodeComponent(message)}"));
                      }
                    : null,
                child: Opacity(
                  opacity: isSpeedSelected ? 1.0 : 0.6,
                  child: Container(
                    height: isMobile ? 38.sp : 40.sp,
                    width: isMobile ? 240.sp : 155.sp,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF25D366),
                          Color(0xFF128C7E),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF25D366).withOpacity(0.3),
                          spreadRadius: 3.sp,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          PhosphorIcons.whatsapp_logo,
                          color: Colors.white,
                          size: isMobile ? 16.sp : 17.sp,
                        ),
                        SizedBox(width: isMobile ? 4.sp : 6.sp),
                        Text(
                          'Contrate agora',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: isMobile ? 11.sp : 13.sp,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: Colors.blue),
          const SizedBox(height: 16),
          Text(
            'Carregando planos...',
            style: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              _errorMessage,
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _loadPlanos,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(
              'Tentar novamente',
              style: GoogleFonts.poppins(
                  color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionIndicator(bool selected) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Padding(
      padding: isMobile
          ? EdgeInsetsGeometry.only()
          : EdgeInsetsGeometry.only(left: 7, bottom: 5),
      child: Icon(
        selected ? Icons.check_circle : Icons.radio_button_unchecked,
        color: selected ? const Color(0xFF228BE6) : const Color(0xFFADB5BD),
        size: 18.sp,
      ),
    );
  }

  Widget _buildAppImage(String imageData) {
    try {
      return Image.memory(
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
        base64Decode(imageData),
      );
    } catch (e) {
      return const Icon(Icons.broken_image, color: Colors.grey);
    }
  }

  void _showSpeedDetails(BuildContext context, String mega, int price) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final plano = _planos.firstWhere(
      (plano) =>
          (plano['nome'] as String).replaceAll('MEGA', '').trim() == mega,
      orElse: () => null,
    );

    if (plano == null) {
      return _showBasicSpeedDetails(context, mega, price);
    }

    List<Map<String, dynamic>> speedDetails = [];
    if (plano['detalhes'] is List) {
      speedDetails = (plano['detalhes'] as List).map((detalhe) {
        return {
          'text': detalhe['text'] ?? 'Descrição não disponível',
          'icon': detalhe['icon'] ?? 0,
        };
      }).toList();
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 32,
            vertical: isMobile ? 16 : 24,
          ),
          child: Center(
            child: Container(
              width: isMobile ? double.infinity : 380,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Detalhes da Velocidade',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF2D2D2D),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.black54),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Internet Fibra Óptica - ${mega}MEGA',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF003366),
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (speedDetails.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: speedDetails.map((detalhe) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                PhosphorIconsData(detalhe['icon']),
                                color: const Color(0xFF003366),
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  detalhe['text'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    color: const Color(0xFF6B7A90),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    )
                  else
                    Text(
                      '• Conexão estável e simétrica\n'
                      '• Download e Upload na mesma velocidade\n'
                      '• Sem limite de franquia\n'
                      '• Suporte técnico 24/7',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: const Color(0xFF6B7A90),
                      ),
                    ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE9ECEF)),
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Valor:',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'R\$ ',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF003366),
                              ),
                            ),
                            Text(
                              '$price',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF003366),
                              ),
                            ),
                            Text(
                              ',99/mês',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF003366),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showBasicSpeedDetails(BuildContext context, String mega, int price) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Internet ${mega}MEGA'),
          content: Text('Velocidade de ${mega}Mbps\nValor: R\$$price,99/mês'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  void _showAppDetails(BuildContext context, SelectedApp app) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(isMobile ? 8.sp : 12.sp),
          child: Container(
            width: isMobile ? double.infinity : 320.sp,
            padding: EdgeInsets.all(isMobile ? 12.sp : 16.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.sp),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        app.name,
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 12.sp : 13.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1A2D45),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close,
                          size: isMobile ? 16.sp : 18.sp,
                          color: const Color(0xFF1A2D45)),
                      onPressed: () => Navigator.of(context).pop(),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                SizedBox(height: isMobile ? 8.sp : 10.sp),
                Container(
                  width: 70.sp,
                  height: 70.sp,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F4FA),
                    borderRadius: BorderRadius.circular(12.sp),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(6.sp),
                    child: _buildAppImage(app.image),
                  ),
                ),
                SizedBox(height: isMobile ? 10.sp : 12.sp),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Benefícios:',
                    style: GoogleFonts.poppins(
                      fontSize: isMobile ? 11.sp : 12.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1A2D45),
                    ),
                  ),
                ),
                SizedBox(height: 4.sp),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '• Acesso ilimitado\n'
                    '• Qualidade HD/4K\n'
                    '• Perfis personalizados\n'
                    '• Download offline',
                    style: GoogleFonts.poppins(
                      fontSize: isMobile ? 10.sp : 11.sp,
                      color: const Color(0xFF5A6C88),
                      height: 1.4,
                    ),
                  ),
                ),
                SizedBox(height: isMobile ? 10.sp : 12.sp),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  child: Text(
                    'R\$ ${app.price},99/mês',
                    style: GoogleFonts.poppins(
                      fontSize: isMobile ? 11.sp : 12.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF007BFF),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
