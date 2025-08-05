import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:universal_html/html.dart' as html;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:velocity_net/modules/plans/repository/Paraempresa.dart';
import 'package:velocity_net/modules/plans/repository/apiservice.dart';
import 'package:velocity_net/modules/plans/repository/app_details.dart';
import 'package:velocity_net/modules/plans/repository/monteseucombo.dart';
import 'package:velocity_net/modules/plans/repository/selectedapp.dart';
import 'package:velocity_net/pages/pdf.dart';
import 'package:velocity_net/pages/previewpdf.dart';

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
  int _selectedMegaIndex = -1;
  List<int> _selectedAppIndices = [];
  bool _isLoading = true;
  String _errorMessage = '';
  List<dynamic> _combos = [];
  List<dynamic> _planos = [];
  List<SelectedApp> _beneficios = [];
  TabController? _tabController;

  List<dynamic> telecinePlans = [];
  List<dynamic> maxPlans = [];
  List<dynamic> premierePlans = [];
  List<dynamic> deezerPlans = [];
  List<dynamic> globoplayPlans = [];
  List<dynamic> canaisPlans = [];

  bool isLoadingTelecine = true;
  bool isLoadingMax = true;
  bool isLoadingPremiere = true;
  bool isLoadingDeezer = true;
  bool isLoadingGloboplay = true;
  bool isLoadingCanais = true;

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
        // Filtrar planos e verificar visibilidade
        telecinePlans = _apiService
            .filterPlans(categoryPlans, 'telecine')
            .where((plan) => plan['isVisible'] ?? true)
            .toList();
        maxPlans = _apiService
            .filterPlans(categoryPlans, 'max')
            .where((plan) => plan['isVisible'] ?? true)
            .toList();
        premierePlans = _apiService
            .filterPlans(categoryPlans, 'premiere')
            .where((plan) => plan['isVisible'] ?? true)
            .toList();
        deezerPlans = _apiService
            .filterPlans(categoryPlans, 'deezer')
            .where((plan) => plan['isVisible'] ?? true)
            .toList();
        globoplayPlans = _apiService
            .filterPlans(categoryPlans, 'globoplay')
            .where((plan) => plan['isVisible'] ?? true)
            .toList();
        canaisPlans = _apiService
            .filterPlans(categoryPlans, "globoplay + canais")
            .where((plan) => plan['isVisible'] ?? true)
            .toList();

        isLoadingTelecine = false;
        isLoadingMax = false;
        isLoadingPremiere = false;
        isLoadingDeezer = false;
        isLoadingGloboplay = false;
        isLoadingCanais = false;

        // Determinar quais tabs devem ser exibidas
        final tabsToShow = [
          telecinePlans.isNotEmpty,
          maxPlans.isNotEmpty,
          premierePlans.isNotEmpty,
          deezerPlans.isNotEmpty,
          globoplayPlans.isNotEmpty,
          canaisPlans.isNotEmpty,
        ];

        // Criar o TabController apenas com as tabs visíveis
        _streamingTabController = TabController(
          length: tabsToShow.where((visible) => visible).length,
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
        isLoadingCanais = false;
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
              TabController(length: _combos.length + 6, vsync: this);
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
        id: b['_id']?.toString() ?? '',
        color: b['color'] ?? '', // Novo campo
        benefitDetails: (b['beneficioDetalhes'] as List?) // Novo campo
                ?.map<String>((detail) => detail['text']?.toString() ?? '')
                .toList() ??
            [],
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
                width: isMobile ? 407 : 1250,
                height: isMobile ? 795 : 630,
                child: Center(
                  child: Stack(
                    children: [
                      ListView.builder(
                        controller: scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: images.length,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60), // Aumento significativo do padding
                        itemBuilder: (context, i) {
                          final imgUrl =
                              _apiService.getImageUrl(images[i]['filename']);
                          return Container(
                            width: isMobile ? 295 : 260,
                            margin: const EdgeInsets.symmetric(
                                horizontal:
                                    30), // Espaçamento dobrado entre cards
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                if (isMobile)
                                  Column(
                                    children: [
                                      const SizedBox(height: 70),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                                      const SizedBox(height: 15),
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
                                            child: const Icon(
                                                Icons.broken_image,
                                                size: 40,
                                                color: Colors.grey),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                    ],
                                  ),
                                // Botão de contrato
                                Center(
                                  child: Material(
                                    borderRadius: BorderRadius.circular(12),
                                    elevation: 4,
                                    child: Container(
                                      height: 48,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF25D366),
                                            Color(0xFF128C7E),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.green.withOpacity(0.3),
                                            blurRadius: 8,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(12),
                                        onTap: () {
                                          launchUrl(Uri.parse(
                                              "https://api.whatsapp.com/send?phone=+5594992600430&text=Olá, quero fazer parte da Velocity!"));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                  PhosphorIcons.whatsapp_logo,
                                                  color: Colors.white,
                                                  size: 24),
                                              const SizedBox(width: 10),
                                              Text(
                                                "FAÇA SEU CONTRATO",
                                                style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                  letterSpacing: 0.5,
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
                        },
                      ),

                      /// Botões de navegação (mantidos os mesmos)
                      Positioned(
                        left: 0,
                        top: 0,
                        bottom: 0,
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 6,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back_ios),
                              color: const Color(0xFF555555),
                              iconSize: 24,
                              onPressed: () {
                                scrollController.animateTo(
                                  scrollController.offset -
                                      375, // Ajuste para o novo espaçamento
                                  duration: const Duration(milliseconds: 350),
                                  curve: Curves.easeOut,
                                );
                              },
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 6,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.arrow_forward_ios),
                              color: const Color(0xFF555555),
                              iconSize: 24,
                              onPressed: () {
                                scrollController.animateTo(
                                  scrollController.offset +
                                      375, // Ajuste para o novo espaçamento
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeOut,
                                );
                              },
                            ),
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

  Widget _buildStreamingTab(
      bool isLoading, List<dynamic> plans, bool isMobile) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: tabSelectedColor),
      );
    }
    return _buildStreamingPlansList(plans, isMobile);
  }

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
      decoration: const BoxDecoration(),
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
              if (telecinePlans.isNotEmpty)
                _buildStreamingTab(isLoadingTelecine, telecinePlans, isMobile),
              if (maxPlans.isNotEmpty)
                _buildStreamingTab(isLoadingMax, maxPlans, isMobile),
              if (premierePlans.isNotEmpty)
                _buildStreamingTab(isLoadingPremiere, premierePlans, isMobile),
              if (deezerPlans.isNotEmpty)
                _buildStreamingTab(isLoadingDeezer, deezerPlans, isMobile),
              if (globoplayPlans.isNotEmpty)
                _buildStreamingTab(
                    isLoadingGloboplay, globoplayPlans, isMobile),
              if (canaisPlans.isNotEmpty)
                _buildStreamingTab(isLoadingCanais, canaisPlans, isMobile),
            ]),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    final hasTelecine = telecinePlans.isNotEmpty;
    final hasMax = maxPlans.isNotEmpty;
    final hasPremiere = premierePlans.isNotEmpty;
    final hasDeezer = deezerPlans.isNotEmpty;
    final hasGloboplay = globoplayPlans.isNotEmpty;
    final hasCanais = canaisPlans.isNotEmpty;

    return PreferredSize(
      preferredSize: const Size.fromHeight(90),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Center(
            child: Container(
              width: 1000,
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFF0066CC), // Borda azul clara
                  width: 1.2,
                ),
              ),
              child: TabBar(
                controller: _tabController,
                onTap: _onTabChanged,
                isScrollable: true,
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 3.0,
                    color: Color(0xFF0066CC),
                  ),
                  insets: EdgeInsets.symmetric(horizontal: 5.0),
                ),
                indicatorSize: TabBarIndicatorSize.label,
                dividerColor: Colors.transparent,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey.shade600,
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
                      .map<Widget>((combo) => Tab(
                            child: Text(
                              combo['title'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )),
                  if (hasTelecine) const Tab(text: '+TELECINE'),
                  if (hasMax) const Tab(text: '+MAX'),
                  if (hasPremiere) const Tab(text: '+PREMIERE'),
                  if (hasDeezer) const Tab(text: '+DEEZER'),
                  if (hasGloboplay) const Tab(text: '+GLOBOPLAY'),
                  if (hasCanais) const Tab(text: "GLOBOPLAY + CANAIS"),
                ],
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
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
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

    Color appColor = app.color.isNotEmpty
        ? Color(int.parse('0xFF${app.color.replaceFirst('#', '')}'))
        : const Color(0xFF4DABF7);

    void _showAppDetails() {
      Color appColor = app.color.isNotEmpty
          ? Color(int.parse('0xFF${app.color.replaceFirst('#', '')}'))
          : const Color(0xFF4DABF7); // Cor padrão

      showDialog(
        context: context,
        builder: (BuildContext context) {
          final isMobile = MediaQuery.of(context).size.width < 600;

          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isMobile ? 340 : 400,
                maxHeight: MediaQuery.of(context).size.height * 0.9,
              ),
              child: Dialog(
                insetPadding: EdgeInsets.zero,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 32), // espaço para o botão X

                            // Imagem com sombra própria
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: appColor.withOpacity(0.3),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: isSvg
                                    ? SvgPicture.network(app.image)
                                    : Image.memory(base64Decode(app.image)),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Nome
                            Text(
                              app.name.toUpperCase(),
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: appColor,
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Benefícios
                            if (app.benefitDetails.isNotEmpty) ...[
                              Text(
                                'INCLUSO NO PLANO:',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[800],
                                ),
                              ),
                              const SizedBox(height: 12),
                              Column(
                                children: app.benefitDetails.map((detail) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(Icons.check_circle,
                                            size: 20, color: appColor),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            detail,
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 20),
                            ],

                            const SizedBox(height: 24),

                            // Botões
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // TextButton(
                                //   onPressed: () => Navigator.pop(context),
                                //   child: Text(
                                //     'FECHAR',
                                //     style: GoogleFonts.poppins(
                                //       fontWeight: FontWeight.w600,
                                //       color: Colors.grey[600],
                                //     ),
                                //   ),
                                // ),
                                const SizedBox(width: 12),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: appColor,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    elevation: 3,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _toggleAppSelection(index);
                                  },
                                  child: Text(
                                    isSelected ? 'REMOVER' : 'ADICIONAR',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Botão X no canto superior direito
                    Positioned(
                      top: 8,
                      right: 8,
                      child: IconButton(
                        icon: const Icon(Icons.close,
                            size: 24, color: Colors.grey),
                        onPressed: () => Navigator.pop(context),
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

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 6.sp : 0.sp, vertical: 8.sp),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: isSpeedSelected ? () => _toggleAppSelection(index) : null,
          onLongPress: _showAppDetails,
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
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildSelectionIndicator(
                              isSelected && isSpeedSelected),
                          isSvg
                              ? SvgPicture.network(app.image, width: 100)
                              : _buildAppImage(app.image),
                          IconButton(
                            onPressed: _showAppDetails,
                            icon: Icon(PhosphorIcons.info,
                                size: 20.sp, color: Colors.grey[700]),
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
                        icon: const Icon(Icons.close,
                            size: 18, color: Colors.transparent),
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
    final bool isSpeedSelected = _selectedMegaIndex != -1 &&
        _planos.isNotEmpty &&
        _selectedMegaIndex < _planos.length;
    final bool hasSelectedApps = _selectedAppIndices.isNotEmpty;

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
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header com contador de apps
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

          // Container do Plano selecionado
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
                isSpeedSelected
                    ? '${(_planos[_selectedMegaIndex]['nome'] as String).replaceAll('MEGA', '').trim()} Megas'
                    : 'Selecione um plano',
                style: GoogleFonts.poppins(
                  color: isSpeedSelected
                      ? const Color(0xFF495057)
                      : const Color(0xFFADB5BD),
                  fontSize: isMobile ? 10.sp : 10.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(height: isMobile ? 4.sp : 8.sp),

          // Container do Valor
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
                        color: isSpeedSelected
                            ? const Color(0xFF495057)
                            : const Color(0xFFADB5BD),
                        fontSize: isMobile ? 12.sp : 8.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(width: 1.sp),
                  Text(
                    isSpeedSelected ? '$totalValue' : '--',
                    style: GoogleFonts.poppins(
                      color: isSpeedSelected
                          ? const Color(0xFF212529)
                          : const Color(0xFFADB5BD),
                      fontSize: isMobile ? 28.sp : 19.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(0, isMobile ? -3.sp : -1.sp),
                    child: Text(
                      isSpeedSelected ? ',99' : '',
                      style: GoogleFonts.poppins(
                        color: isSpeedSelected
                            ? const Color(0xFF495057)
                            : const Color(0xFFADB5BD),
                        fontSize: isMobile ? 12.sp : 10.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (!isMobile && isSpeedSelected) ...[
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

          // Texto "até o vencimento" para mobile
          if (isMobile && isSpeedSelected)
            Column(
              children: [
                SizedBox(height: 3.sp),
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

          // Lista de Apps selecionados
          if (hasSelectedApps)
            Container(
              width: isMobile ? 260.sp : 190.sp,
              height: isMobile ? 90.sp : 130.sp,
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
                          Expanded(
                            child: Text(
                              appName,
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF212529),
                                fontSize: isMobile ? 9.sp : 8.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.close,
                              size: 18,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              widget.onRemoveApp?.call(index);
                              setState(() {
                                _selectedAppIndices.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

          // Espaçamento antes dos botões
          const Spacer(),

          // Botões fixos no rodapé
          Container(
            padding: EdgeInsets.symmetric(
              vertical: isMobile ? 10.sp : 8.sp,
              horizontal: isMobile ? 10.sp : 10.sp,
            ),
            child: Column(
              children: [
                // Botão WhatsApp
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10.sp),
                    onTap: isSpeedSelected
                        ? () {
                            _handleWhatsAppContact();
                          }
                        : null,
                    child: Opacity(
                      opacity: isSpeedSelected ? 1.0 : 0.6,
                      child: Container(
                        height: isMobile ? 38.sp : 35.sp,
                        width: double.infinity,
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
                                fontSize: isMobile ? 11.sp : 10.sp,
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
                SizedBox(height: isMobile ? 10.sp : 8.sp),

                // Botão PDF
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10.sp),
                    onTap: isSpeedSelected
                        ? () async {
                            await _handlePdfGeneration();
                          }
                        : null,
                    child: Opacity(
                      opacity: isSpeedSelected ? 1.0 : 0.6,
                      child: Container(
                        height: isMobile ? 38.sp : 35.sp,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.sp),
                          color: Colors.black,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 3.sp,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              PhosphorIcons.file_pdf,
                              color: Colors.white,
                              size: isMobile ? 16.sp : 17.sp,
                            ),
                            SizedBox(width: isMobile ? 4.sp : 6.sp),
                            Text(
                              'Baixar Resumo',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: isMobile ? 11.sp : 10.sp,
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
              ],
            ),
          ),
        ],
      ),
    );
  }

// Métodos auxiliares
  void _handleWhatsAppContact() {
    if (_selectedMegaIndex == -1) return;

    final selectedPlan = _planos[_selectedMegaIndex];
    final selectedApps =
        _selectedAppIndices.map((i) => _beneficios[i].name).join(', ');

    final message =
        'Olá, gostaria de contratar o plano ${selectedPlan['nome'].replaceAll('MEGA', '').trim()} MEGA '
        'no valor de R\$ ${selectedPlan['valor']},99 '
        '${_selectedAppIndices.isNotEmpty ? 'com os seguintes benefícios: $selectedApps' : 'sem benefícios adicionais'} '
        '(Total: R\$ $totalValue,99)';

    launchUrl(Uri.parse(
        "https://api.whatsapp.com/send?phone=+5594992600430&text=${Uri.encodeComponent(message)}"));
  }

  Future<void> _handlePdfGeneration() async {
    if (_selectedMegaIndex == -1) return;

    try {
      final selectedPlan = _planos[_selectedMegaIndex];
      final selectedApps =
          _selectedAppIndices.map((i) => _beneficios[i]).toList();

      final combo = SelectedCombo(
        mega: selectedPlan['nome'].replaceAll('MEGA', '').trim(),
        megaPrice: (selectedPlan['valor'] as num).toInt(),
        apps: selectedApps,
        total: totalValue,
        isVisible: true,
      );

      final pdfBytes = await gerarPdfRelatorio(combo);

      if (kIsWeb) {
        final blob = html.Blob([pdfBytes], 'application/pdf');
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..download = 'resumo_velocity.pdf'
          ..style.display = 'none';

        html.document.body?.children.add(anchor);
        anchor.click();
        html.document.body?.children.remove(anchor);
        html.Url.revokeObjectUrl(url);
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => PreviewPdf(combo: combo),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao gerar PDF: ${e.toString()}')),
      );
    }
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
    final isMobile = MediaQuery.of(context).size.width < 600;

    try {
      return Image.memory(
        height: isMobile ? 70 : 80,
        width: isMobile ? 130 : 180,
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
    barrierDismissible: true,
    builder: (BuildContext context) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(), // Tocar fora = fechar
        child: Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 32,
            vertical: isMobile ? 16 : 24,
          ),
          child: GestureDetector(
            onTap: () {}, // Impede que clique dentro feche
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
          ),
        ),
      );
    },
  );
}




  void _showBasicSpeedDetails(BuildContext context, String mega, int price) {
    showDialog(
      context: context,
      barrierDismissible: true,
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
}
