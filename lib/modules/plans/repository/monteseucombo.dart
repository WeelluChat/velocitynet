import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

const Color textColor = Colors.black;
const Color megaColor = Color.fromARGB(255, 5, 45, 83);
const Color cardMega = Colors.white;

class SelectedApp {
  final String name;
  final int price;
  bool isSelected;

  SelectedApp({
    required this.name,
    required this.price,
    this.isSelected = true,
  });

  SelectedApp copyWith({
    String? name,
    int? price,
    bool? isSelected,
  }) {
    return SelectedApp(
      name: name ?? this.name,
      price: price ?? this.price,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

class SelectedCombo {
  final String mega;
  final int megaPrice;
  final List<SelectedApp> apps;
  final int total;

  SelectedCombo({
    required this.mega,
    required this.megaPrice,
    required this.apps,
    required this.total,
  });

  SelectedCombo copyWith({
    String? mega,
    int? megaPrice,
    List<SelectedApp>? apps,
    int? total,
  }) {
    return SelectedCombo(
      mega: mega ?? this.mega,
      megaPrice: megaPrice ?? this.megaPrice,
      apps: apps ?? this.apps,
      total: total ?? this.total,
    );
  }
}

class Monteseucombo extends StatefulWidget {
  final Function(SelectedCombo) onComboSelected;
  final SelectedCombo? initialCombo;
  
  const Monteseucombo({
    super.key, 
    required this.onComboSelected,
    this.initialCombo,
  });

    static _MonteseucomboState? of(BuildContext context) {
    return context.findAncestorStateOfType<_MonteseucomboState>();
  }

  @override
  State<Monteseucombo> createState() => _MonteseucomboState();
}

class _MonteseucomboState extends State<Monteseucombo> {
  final ScrollController _scrollController = ScrollController();
  int _selectedMegaIndex = -1;
  List<int> _selectedAppIndices = [];
  List<SelectedApp> _allApps = [];

  final List<String> appImages = [
    'assets/GloboPlayMaster.svg',
    'assets/maxMaster.svg',
    'assets/TELECINE.svg',
    'assets/premiere.svg',
    'assets/deezer-new-logo.svg',
  ];

  final List<String> appNames = [
    'GloboPlay',
    'Max',
    'Telecine',
    'Premiere',
    'Deezer',
  ];

  final List<int> defaultAppValues = [0, 0, 0, 0, 0];

  final Map<String, List<int>> streamingPricesByMega = {
    '500': [38, 0, 30, 50, 10],
    '700': [38, 0, 30, 50, 10],
    '800': [28, 20, 30, 50, 10],
    '900': [15, 5, 15, 30, 1],
    '1000': [15, 5, 15, 30, 1],
  };

  final List<String> megaValues = ['500', '700', '800', '900', '1000'];
  final List<int> megaPrices = [109, 119, 139, 164, 189];

  List<int> get currentAppValues {
    if (_selectedMegaIndex == -1) return defaultAppValues;
    return streamingPricesByMega[megaValues[_selectedMegaIndex]]!;
  }

  @override
  void initState() {
    super.initState();
    _initializeApps();
  }

  @override
  void didUpdateWidget(Monteseucombo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialCombo != oldWidget.initialCombo) {
      _initializeApps();
    }
  }

  void _initializeApps() {
    // Inicializa todos os apps
    _allApps = appNames.asMap().entries.map((entry) {
      return SelectedApp(
        name: entry.value,
        price: defaultAppValues[entry.key],
        isSelected: false,
      );
    }).toList();

    // Sincroniza com o estado inicial se fornecido
    if (widget.initialCombo != null) {
      _selectedMegaIndex = megaValues.indexOf(widget.initialCombo!.mega);
      
      // Atualiza os preços dos apps para a velocidade selecionada
      if (_selectedMegaIndex != -1) {
        _allApps = _allApps.asMap().entries.map((entry) {
          return entry.value.copyWith(
            price: streamingPricesByMega[megaValues[_selectedMegaIndex]]![entry.key],
          );
        }).toList();
      }
      
      // Atualiza a lista de apps selecionados
      _selectedAppIndices = [];
      for (var app in widget.initialCombo!.apps) {
        final index = appNames.indexOf(app.name);
        if (index != -1) {
          _allApps[index] = _allApps[index].copyWith(
            isSelected: app.isSelected,
            price: app.price,
          );
          if (app.isSelected) {
            _selectedAppIndices.add(index);
          }
        }
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _updateSelectedCombo() {
    final combo = SelectedCombo(
      mega: _selectedMegaIndex != -1 ? megaValues[_selectedMegaIndex] : '',
      megaPrice: _selectedMegaIndex != -1 ? megaPrices[_selectedMegaIndex] : 0,
      apps: _allApps.where((app) => app.isSelected).toList(),
      total: _calculateTotal(),
    );
    
    widget.onComboSelected(combo);
  }

  void removeAppSelection(String appName) {
    setState(() {
      final index = appNames.indexOf(appName);
      if (index != -1) {
        _allApps[index] = _allApps[index].copyWith(isSelected: false);
        _selectedAppIndices.remove(index);
        _updateSelectedCombo();
      }
    });
  }

  int _calculateTotal() {
    final megaValue = _selectedMegaIndex != -1 ? megaPrices[_selectedMegaIndex] : 0;
    final appsValue = _allApps.where((app) => app.isSelected)
                      .fold(0, (sum, app) => sum + app.price);
    return megaValue + appsValue;
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final lateralPadding = isMobile ? 8.0 : 12.0;
    final hasSelection = _selectedMegaIndex != -1;

    return ScreenUtilInit(
      designSize: isMobile ? const Size(360, 800) : const Size(1024, 768),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.only(
              left: lateralPadding,
              right: lateralPadding,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (isMobile) ...[
                  _buildMegaColumn(),
                  SizedBox(height: 10.sp),
                  _buildAppColumn(),
                ] else ...[
                  Row(
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
              ],
            ),
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
      decoration: ShapeDecoration(
        color: const Color.fromARGB(255, 230, 230, 230),
        shadows: [BoxShadow(blurRadius: 0)],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.sp),
          side: const BorderSide(color: Color.fromARGB(255, 158, 158, 158)),
        ),
      ),
      child: Column(
        mainAxisSize: isMobile ? MainAxisSize.min : MainAxisSize.max,
        children: [
          Container(
            height: 36.sp,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 230, 230, 230),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.sp),
                topRight: Radius.circular(5.sp),
              ),
            ),
            child: Center(
              child: Text(
                'ESCOLHA A SUA VELOCIDADE',
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 13.sp : 10.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromARGB(255, 0, 0, 0),
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
              itemCount: megaValues.length,
              itemBuilder: (context, index) {
                return _buildMegaItem(megaValues[index], megaPrices[index], index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMegaItem(String mega, int price, int index) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final isSelected = _selectedMegaIndex == index;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 6.sp : 8.sp,
        vertical: 8.sp,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(6.sp),
          onTap: () {
            setState(() {
              if (isSelected) {
                _selectedMegaIndex = -1;
                // Desmarca todos os apps ao deselecionar a velocidade
                _allApps = _allApps.map((app) => app.copyWith(isSelected: false)).toList();
                _selectedAppIndices.clear();
              } else {
                _selectedMegaIndex = index;
                // Atualiza os preços dos apps para a nova velocidade selecionada
                _allApps = _allApps.asMap().entries.map((entry) {
                  return entry.value.copyWith(
                    price: streamingPricesByMega[megaValues[_selectedMegaIndex]]![entry.key],
                  );
                }).toList();
              }
              _updateSelectedCombo();
            });
          },
          child: Container(
            width: isMobile ? double.infinity : 300.sp,
            height: isMobile ? 70.sp : 50.sp,
            decoration: ShapeDecoration(
              color: isSelected
                  ? const Color.fromARGB(255, 184, 208, 253).withOpacity(0.8)
                  : const Color.fromARGB(255, 255, 255, 255),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.sp),
                side: BorderSide(
                  color: isSelected
                      ? const Color(0xFFDED4D4)
                      : const Color.fromARGB(255, 168, 168, 168),
                ),
              ),
              shadows: [BoxShadow()],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(
                    padding: EdgeInsets.only(left: 5.sp),
                    width: isMobile ? 110.sp : 200.sp,
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
                                      fontSize: isMobile ? 100.sp : 27.sp,
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
                                      color: const Color.fromARGB(255, 22, 103, 179),
                                      letterSpacing: 0.5.sp,
                                      fontSize: isMobile ? 40.sp : 15.sp,
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
                      ? EdgeInsets.only(left: 30)
                      : EdgeInsetsGeometry.only(left: 30),
                  child: Container(
                    color: const Color.fromARGB(255, 134, 134, 134),
                    height: 32.sp,
                    width: 1.0.sp,
                  ),
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
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: isMobile ? 13.sp : 13.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 1.sp),
                          Text(
                            '$price',
                            style: GoogleFonts.poppins(
                              color: const Color.fromARGB(255, 0, 0, 0),
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
                              padding: const EdgeInsets.only(bottom: 10, right: 10),
                              child: Text(
                                ',99',
                                style: GoogleFonts.poppins(
                                  color: const Color.fromARGB(255, 0, 0, 0),
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
                      PhosphorIcons.info(),
                      color: const Color.fromARGB(255, 0, 0, 0),
                      size: isMobile ? 20.sp : 20.sp,
                    ),
                  ),
                ),
              ],
            ),
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
      decoration: ShapeDecoration(
        shadows: [BoxShadow(blurRadius: 0)],
        color: const Color.fromARGB(255, 230, 230, 230),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.sp),
          side: const BorderSide(color: Color.fromARGB(255, 168, 168, 168)),
        ),
      ),
      child: Column(
        mainAxisSize: isMobile ? MainAxisSize.min : MainAxisSize.max,
        children: [
          Container(
            height: 36.sp,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 230, 230, 230),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.sp),
                topRight: Radius.circular(5.sp),
              ),
            ),
            child: Center(
              child: Text(
                'ESCOLHA SEUS STREAMING',
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 13.sp : 10.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromARGB(255, 0, 0, 0),
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
              itemCount: _allApps.length,
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
    final app = _allApps[index];
    final bool isSelected = app.isSelected;
    final bool isSvg = appImages[index].toLowerCase().endsWith('.svg');

    final bool isMaxApp = index == 1;
    final bool is500or700Mega = _selectedMegaIndex != -1 &&
        (megaValues[_selectedMegaIndex] == '500' ||
            megaValues[_selectedMegaIndex] == '700');
    final bool isDisabled = isMaxApp && is500or700Mega;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 6.sp : 8.sp,
        vertical: 8.sp,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(6.sp),
          onTap: isSpeedSelected && !isDisabled
              ? () {
                  setState(() {
                    _allApps[index] = app.copyWith(
                      isSelected: !isSelected,
                    );
                    if (isSelected) {
                      _selectedAppIndices.remove(index);
                    } else {
                      _selectedAppIndices.add(index);
                    }
                    _updateSelectedCombo();
                  });
                }
              : null,
          child: Container(
            width: isMobile ? double.infinity : 300.sp,
            height: isMobile ? 70.sp : 50.sp,
            decoration: ShapeDecoration(
              color: isSelected && !isDisabled
                  ? const Color.fromARGB(255, 184, 208, 253).withOpacity(0.8)
                  : isDisabled
                      ? const Color.fromARGB(255, 240, 240, 240)
                      : const Color.fromARGB(255, 255, 255, 255),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.sp),
                side: BorderSide(
                  color: isSelected && !isDisabled
                      ? const Color(0xFFDED4D4)
                      : isDisabled
                          ? const Color(0xFFE0E0E0)
                          : const Color.fromARGB(255, 168, 168, 168),
                ),
              ),
              shadows: [BoxShadow()],
            ),
            child: Stack(
              children: [
                Padding(
                  padding: isMobile
                      ? EdgeInsetsGeometry.only(top: 23, left: 7)
                      : EdgeInsetsGeometry.only(top: 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSelectionIndicator(isSelected && isSpeedSelected && !isDisabled),
                      SizedBox(
                        width: isMobile ? 110.sp : 90.sp,
                        height: isMobile ? 25.sp : 30.sp,
                        child: isSvg
                            ? SvgPicture.asset(
                                appImages[index],
                                fit: BoxFit.contain,
                                color: isDisabled
                                    ? const Color.fromARGB(255, 180, 180, 180)
                                    : null,
                              )
                            : Image.asset(
                                appImages[index],
                                fit: BoxFit.contain,
                                color: isDisabled
                                    ? const Color.fromARGB(255, 180, 180, 180)
                                    : null,
                              ),
                      ),
                      SizedBox(width: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            'R\$',
                            style: GoogleFonts.poppins(
                              color: isDisabled
                                  ? const Color.fromARGB(255, 180, 180, 180)
                                  : const Color.fromARGB(255, 0, 0, 0),
                              fontSize: isMobile ? 10.sp : 13.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${app.price}',
                            style: GoogleFonts.poppins(
                              color: isDisabled
                                  ? const Color.fromARGB(255, 180, 180, 180)
                                  : const Color.fromARGB(255, 0, 0, 0),
                              letterSpacing: isMobile ? -0.6.sp : -1.0.sp,
                              fontSize: isMobile ? 30.sp : 25.sp,
                              fontWeight: FontWeight.w700,
                              height: 1.0,
                            ),
                          ),
                          SizedBox(width: 1.sp),
                          Transform.translate(
                            offset: Offset(0, isMobile ? -12.sp : -9.sp),
                            child: Text(
                              ',00',
                              style: GoogleFonts.poppins(
                                color: isDisabled
                                    ? const Color.fromARGB(255, 180, 180, 180)
                                    : const Color.fromARGB(255, 0, 0, 0),
                                fontSize: isMobile ? 10.sp : 13.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: isMobile ? 3.sp : 8.sp),
                          InkWell(
                            onTap: () {
                              AppPopups.showAppDetails(context, index);
                            },
                            child: Padding(
                              padding: isMobile
                                  ? EdgeInsets.only(right: 10, left: 10)
                                  : EdgeInsets.only(right: 14),
                              child: Icon(
                                PhosphorIcons.info(),
                                color: isDisabled
                                    ? const Color.fromARGB(255, 0, 0, 0)
                                    : const Color.fromARGB(255, 0, 0, 0),
                                size: isMobile ? 20.sp : 20.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (isDisabled)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.sp),
                        color: Colors.black.withOpacity(0.4),
                      ),
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 12.sp : 5.sp,
                            vertical: isMobile ? 4.sp : 5.sp,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red[700],
                            borderRadius: BorderRadius.circular(20.sp),
                          ),
                          child: Text(
                            'NÃO DISPONÍVEL',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: isMobile ? 10.sp : 12.sp,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryColumn() {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final lateralPadding = isMobile ? 8.0 : 12.0;
    final bool isSpeedSelected = _selectedMegaIndex != -1;
    final totalValue = _calculateTotal();
    final selectedApps = _allApps.where((app) => app.isSelected).toList();

    return Container(
      width: isMobile ? 500 - (2 * lateralPadding) : 200.sp,
      height: isMobile ? 370 : 376.sp,
      padding: EdgeInsets.only(bottom: 0.sp),
      decoration: ShapeDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.sp),
            side: const BorderSide(
              color: Color.fromARGB(255, 179, 179, 179),
            ),
          ),
          shadows: [BoxShadow(blurRadius: 1)]),
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
                GestureDetector(
                  onTap: () {
                    _showPlanDetails(context);
                  },
                  child: Text(
                    'Ver detalhes',
                    style: GoogleFonts.poppins(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: isMobile ? 9.sp : 8.sp,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${selectedApps.length}',
                      style: GoogleFonts.poppins(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: isMobile ? 9.sp : 10.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 2.sp),
                    Icon(
                      PhosphorIcons.shoppingCart(),
                      color: const Color.fromARGB(255, 0, 0, 0),
                      size: isMobile ? 9.sp : 10.sp,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: isMobile ? 260.sp : 133.sp,
            height: isMobile ? 28.sp : 28.sp,
            margin: EdgeInsets.symmetric(horizontal: isMobile ? 8.sp : 0),
            decoration: ShapeDecoration(
              shadows: [BoxShadow()],
              color: const Color.fromARGB(255, 255, 255, 255),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.sp),
                side: const BorderSide(color: Color.fromARGB(255, 175, 175, 175)),
              ),
            ),
            child: Center(
              child: Text(
                isSpeedSelected
                    ? 'Internet Fibra - ${megaValues[_selectedMegaIndex]} Megas'
                    : 'Selecione um plano',
                style: GoogleFonts.poppins(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: isMobile ? 10.sp : 9.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          SizedBox(height: isMobile ? 4.sp : 8.sp),
          Container(
            width: isMobile ? 260.sp : 133.sp,
            height: isMobile ? 46.sp : 40.sp,
            margin: EdgeInsets.symmetric(horizontal: isMobile ? 8.sp : 0),
            decoration: ShapeDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.sp),
                  side: const BorderSide(color: Color.fromARGB(255, 158, 158, 158)),
                ),
                shadows: [BoxShadow()]),
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
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: isMobile ? 12.sp : 8.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(width: 1.sp),
                  Text(
                    '$totalValue',
                    style: GoogleFonts.poppins(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: isMobile ? 28.sp : 19.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(0, isMobile ? -3.sp : -1.sp),
                    child: Text(
                      ',99',
                      style: GoogleFonts.poppins(
                        color: const Color.fromARGB(255, 0, 0, 0),
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
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'vencimento',
                          style: GoogleFonts.poppins(
                            color: const Color.fromARGB(255, 0, 0, 0),
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
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
          SizedBox(height: isMobile ? 4.sp : 8),
          if (selectedApps.isNotEmpty)
            Container(
              width: isMobile ? 260.sp : 190.sp,
              height: isMobile ? 90.sp : 153.sp,
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 8.sp : 12.sp),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: selectedApps.length,
                itemBuilder: (context, index) {
                  final app = selectedApps[index];
                  final appIndex = _allApps.indexOf(app);

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
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(8.sp),
                          border: Border.all(color: const Color(0xFFDED4D4)),
                          boxShadow: [BoxShadow()]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            app.name,
                            style: GoogleFonts.poppins(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: isMobile ? 9.sp : 8.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Transform.translate(
                                offset: const Offset(0, 1),
                                child: Text(
                                  'R\$',
                                  style: GoogleFonts.poppins(
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                    fontSize: isMobile ? 7.sp : 8.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Transform.translate(
                                offset: const Offset(0, 0),
                                child: Text(
                                  '${app.price}',
                                  style: GoogleFonts.poppins(
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                    fontSize: isMobile ? 9.sp : 10.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(0, -1),
                                child: Text(
                                  ',00',
                                  style: GoogleFonts.poppins(
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                    fontSize: isMobile ? 7.sp : 9.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(width: 4),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _allApps[appIndex] = app.copyWith(
                                      isSelected: false,
                                    );
                                    _selectedAppIndices.remove(appIndex);
                                    _updateSelectedCombo();
                                  });
                                },
                                child: Icon(
                                  Icons.close,
                                  size: isMobile ? 14.sp : 12.sp,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: isMobile ? 30.sp : 20.sp,
              horizontal: isMobile ? 10.sp : 10.sp,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(10.sp),
                onTap: isSpeedSelected
                    ? () {
                        final selectedAppsNames = selectedApps
                            .map((app) => app.name)
                            .join(', ');

                        final message =
                            'Olá, gostaria de saber mais sobre o plano de '
                            '${megaValues[_selectedMegaIndex]} mega com '
                            '${selectedApps.isNotEmpty ? 'os seguintes streamings: $selectedAppsNames.' : 'nenhum streaming adicional'}';

                        launchUrl(Uri.parse(
                            "https://api.whatsapp.com/send?phone=+559499260-0430&text=${Uri.encodeComponent(message)}"));
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
                            blurRadius: 5),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          PhosphorIcons.whatsappLogo(),
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

  Widget _buildSelectionIndicator(bool selected) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Padding(
      padding: isMobile
          ? EdgeInsetsGeometry.only()
          : EdgeInsetsGeometry.only(left: 7, bottom: 5),
      child: Icon(
        selected ? Icons.check_circle : Icons.radio_button_unchecked,
        color: selected
            ? const Color.fromARGB(255, 0, 34, 126)
            : const Color.fromARGB(255, 146, 146, 146),
        size: 18.sp,
      ),
    );
  }

  void _showSpeedDetails(BuildContext context, String mega, int price) {
    final isMobile = MediaQuery.of(context).size.width < 600;

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
                      border: Border.all(
                          color: const Color.fromARGB(255, 170, 170, 170)),
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

  void _showPlanDetails(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(isMobile ? 8.sp : 16.sp),
          child: Container(
            width: isMobile ? double.infinity : 400.sp,
            decoration: BoxDecoration(
              color: const Color(0xFF1A2D45),
              borderRadius: BorderRadius.circular(10.sp),
              boxShadow: [
                BoxShadow(),
              ],
            ),
            padding: EdgeInsets.all(isMobile ? 12.sp : 16.sp),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Detalhes do Plano',
                      style: GoogleFonts.poppins(
                        fontSize: isMobile ? 14.sp : 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close,
                          size: isMobile ? 16.sp : 20.sp, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                SizedBox(height: isMobile ? 4.sp : 8.sp),
                Text(
                  'Benefícios do seu combo:',
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 12.sp : 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF4A90E2),
                  ),
                ),
                SizedBox(height: isMobile ? 4.sp : 6.sp),
                Text(
                  '• Internet de alta velocidade\n'
                  '• Aplicativos de streaming inclusos\n'
                  '• Sem fidelidade obrigatória\n'
                  '• Suporte técnico especializado\n'
                  '• Pagamento único mensal\n'
                  '• Descontos exclusivos',
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 11.sp : 13.sp,
                    color: const Color(0xFFA0B3D6),
                  ),
                ),
                SizedBox(height: isMobile ? 8.sp : 12.sp),
                if (_selectedAppIndices.isNotEmpty)
                  Text(
                    'Streamings selecionados:',
                    style: GoogleFonts.poppins(
                      fontSize: isMobile ? 11.sp : 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                if (_selectedAppIndices.isNotEmpty)
                  SizedBox(height: isMobile ? 2.sp : 4.sp),
                if (_selectedAppIndices.isNotEmpty)
                  Column(
                    children: _selectedAppIndices.map((index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: isMobile ? 0.sp : 1.sp),
                        child: Row(
                          children: [
                            Icon(Icons.check_circle,
                                color: const Color(0xFF25D366),
                                size: isMobile ? 10.sp : 12.sp),
                            SizedBox(width: isMobile ? 2.sp : 4.sp),
                            Text(
                              '${appNames[index]} - R\$ ${currentAppValues[index]},00',
                              style: GoogleFonts.poppins(
                                fontSize: isMobile ? 10.sp : 12.sp,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AppPopups {
  static void showAppDetails(BuildContext context, int index) {
    // Implementação do popup de detalhes do app
  }
}