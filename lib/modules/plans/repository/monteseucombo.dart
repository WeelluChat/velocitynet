// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:phosphor_flutter/phosphor_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';

// // ==================== MODEL CLASSES ====================
// class SelectedApp {
//   final String name;
//   final int price;

//   SelectedApp({required this.name, required this.price});

//   String get image => null;
// }

// class SelectedCombo {
//   final String mega;
//   final int megaPrice;
//   final List<SelectedApp> apps;
//   final int total;

//   SelectedCombo({
//     required this.mega,
//     required this.megaPrice,
//     required this.apps,
//     required this.total,
//   });
// }

// // ==================== MAIN WIDGET ====================
// class Monteseucombo extends StatefulWidget {
//   final Function(dynamic) onComboSelected;
//   final dynamic initialCombo;

//   const Monteseucombo({
//     required this.onComboSelected,
//     this.initialCombo,
//   });

//   @override
//   State<Monteseucombo> createState() => _MonteseucomboState();

//   static of(BuildContext context) {}
// }

// class _MonteseucomboState extends State<Monteseucombo> with TickerProviderStateMixin {
//   List<dynamic> apiResponse = [];
//   TabController? _tabController;
//   bool _isLoading = true;
//   String _errorMessage = '';
//   SelectedCombo? selectedCombo;

//   @override
//   void initState() {
//     super.initState();
//     _initializeData();
//   }

//   @override
//   void dispose() {
//     _tabController?.dispose();
//     super.dispose();
//   }

//   Future<void> _initializeData() async {
//     try {
//       _setLoadingState(true);
//       final data = await ApiService().getData();

//       if (data != null && mounted) {
//         _handleSuccessResponse(data);
//       } else {
//         _handleEmptyResponse();
//       }
//     } catch (e) {
//       _handleErrorResponse(e);
//     }
//   }

//   void _setLoadingState(bool isLoading) {
//     setState(() {
//       _isLoading = isLoading;
//     });
//   }

//   void _handleSuccessResponse(List<dynamic> data) {
//     setState(() {
//       apiResponse = data;
//       _tabController = TabController(length: apiResponse.length, vsync: this);
//       _isLoading = false;
//       _errorMessage = '';
//     });
//   }

//   void _handleEmptyResponse() {
//     setState(() {
//       _isLoading = false;
//       _errorMessage = 'Nenhum dado disponível';
//     });
//   }

//   void _handleErrorResponse(dynamic error) {
//     setState(() {
//       _isLoading = false;
//       _errorMessage = 'Erro ao carregar dados: ${error.toString()}';
//     });
//   }

//   void _onComboSelected(dynamic selected) {
//     widget.onComboSelected(selected);
//     setState(() {
//       selectedCombo = SelectedCombo(
//         mega: selected['plano']['nome'],
//         megaPrice: (selected['plano']['valor'] as num).toInt(),
//         apps: (selected['beneficios'] as List).map<SelectedApp>((b) => SelectedApp(
//           name: b['nome'],
//           price: (b['valor'] as num).toInt(),
//         )).toList(),
//         total: (selected['plano']['valor'] as num).toInt() +
//             (selected['beneficios'] as List).fold<int>(
//               0, 
//               (sum, b) => sum + (b['valor'] as num).toInt()
//             ),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading) return _buildLoadingState();
//     if (_errorMessage.isNotEmpty) return _buildErrorState();
//     if (_tabController == null) return const Center(child: CircularProgressIndicator());

//     return Scaffold(
//       backgroundColor: Colors.grey[900],
//       appBar: _buildAppBar(),
//       body: TabBarView(
//         controller: _tabController,
//         children: apiResponse.map<Widget>((combo) {
//           return ComboMaker(
//             combo: combo,
//             onComboSelected: _onComboSelected,
//           );
//         }).toList(),
//       ),
//     );
//   }

//   PreferredSizeWidget _buildAppBar() {
//     return AppBar(
//       backgroundColor: Colors.grey[850],
//       title: Text(
//         'Montador de Combo', 
//         style: GoogleFonts.poppins(color: Colors.white)
//       ),
//       centerTitle: true,
//       bottom: PreferredSize(
//         preferredSize: const Size.fromHeight(kToolbarHeight),
//         child: TabBar(
//           controller: _tabController,
//           indicator: const UnderlineTabIndicator(
//             borderSide: BorderSide(width: 3.0, color: Colors.white),
//           ),
//           labelColor: Colors.white,
//           unselectedLabelColor: Colors.grey[500],
//           labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
//           tabs: apiResponse.map<Widget>((combo) => Tab(text: combo['title'])).toList(),
//         ),
//       ),
//     );
//   }

//   Widget _buildLoadingState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const CircularProgressIndicator(color: Colors.white),
//           const SizedBox(height: 16),
//           Text(
//             'Carregando combos...', 
//             style: GoogleFonts.poppins(
//               color: Colors.white70, 
//               fontSize: 16
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildErrorState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(Icons.error_outline, size: 48, color: Colors.red),
//           const SizedBox(height: 16),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 32),
//             child: Text(
//               _errorMessage, 
//               style: GoogleFonts.poppins(
//                 fontSize: 16, 
//                 color: Colors.white
//               ), 
//               textAlign: TextAlign.center,
//             ),
//           ),
//           const SizedBox(height: 16),
//           ElevatedButton(
//             onPressed: _initializeData,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.blue, 
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8)
//               ),
//             ),
//             child: Text(
//               'Tentar novamente', 
//               style: GoogleFonts.poppins(
//                 color: Colors.white, 
//                 fontWeight: FontWeight.w500
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ==================== COMBO MAKER WIDGET ====================
// class ComboMaker extends StatefulWidget {
//   final Map<String, dynamic> combo;
//   final Function(dynamic) onComboSelected;

//   const ComboMaker({
//     required this.combo, 
//     required this.onComboSelected,
//   });

//   @override
//   State<ComboMaker> createState() => _ComboMakerState();
// }

// class _ComboMakerState extends State<ComboMaker> {
//   late List plans;
//   int selectedPlanIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     plans = widget.combo['planos'];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         _buildPlansList(),
//         _buildBenefitsList(),
//         _buildContractButton(),
//       ],
//     );
//   }

//   Widget _buildPlansList() {
//     return Expanded(
//       child: ListView(
//         children: plans.asMap().entries.map<Widget>((entry) {
//           return _buildPlanCard(entry.key, entry.value);
//         }).toList(),
//       ),
//     );
//   }

//   Widget _buildPlanCard(int index, dynamic plan) {
//     return Card(
//       margin: const EdgeInsets.all(8),
//       color: Colors.grey[850],
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: ListTile(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         tileColor: selectedPlanIndex == index 
//             ? Colors.grey[700] 
//             : Colors.grey[850],
//         title: Text(
//           plan['nome'], 
//           style: GoogleFonts.poppins(
//             fontSize: 16, 
//             fontWeight: FontWeight.w500, 
//             color: Colors.white
//           ),
//         ),
//         trailing: Text(
//           'R\$ ${plan['valor'].toStringAsFixed(2)}',
//           style: GoogleFonts.poppins(
//             fontSize: 16, 
//             fontWeight: FontWeight.bold, 
//             color: Colors.greenAccent
//           ),
//         ),
//         onTap: () => _selectPlan(index),
//       ),
//     );
//   }

//   void _selectPlan(int index) {
//     setState(() => selectedPlanIndex = index);
//     widget.onComboSelected({
//       'plano': plans[selectedPlanIndex],
//       'beneficios': plans[selectedPlanIndex]['beneficios'] ?? []
//     });
//   }

//   Widget _buildBenefitsList() {
//     return Expanded(
//       child: ListView(
//         children: (plans[selectedPlanIndex]['beneficios'] ?? [])
//             .map<Widget>((beneficio) => _buildBenefitCard(beneficio))
//             .toList(),
//       ),
//     );
//   }

//   Widget _buildBenefitCard(dynamic beneficio) {
//     String base64String = beneficio['image'];
//     if (base64String.contains(',')) {
//       base64String = base64String.split(',').last;
//     }

//     try {
//       final imageBytes = base64Decode(base64String);
//       return _buildValidBenefitCard(beneficio, imageBytes);
//     } catch (e) {
//       return _buildInvalidBenefitCard(beneficio);
//     }
//   }

//   Widget _buildValidBenefitCard(dynamic beneficio, Uint8List imageBytes) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
//       color: Colors.grey[800],
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       elevation: 3,
//       child: Padding(
//         padding: const EdgeInsets.all(8),
//         child: Row(
//           children: [
//             CircleAvatar(
//               backgroundColor: Colors.grey[700],
//               backgroundImage: MemoryImage(imageBytes),
//               radius: 24,
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Text(
//                 beneficio['nome'], 
//                 style: GoogleFonts.poppins(
//                   color: Colors.white, 
//                   fontSize: 14
//                 ),
//               ),
//             ),
//             Text(
//               'R\$ ${beneficio['valor'].toStringAsFixed(2)}',
//               style: GoogleFonts.poppins(
//                 color: Colors.greenAccent, 
//                 fontWeight: FontWeight.bold
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInvalidBenefitCard(dynamic beneficio) {
//     return ListTile(
//       leading: const Icon(Icons.broken_image, color: Colors.red),
//       title: Text(
//         beneficio['nome'], 
//         style: GoogleFonts.poppins(color: Colors.white)
//       ),
//     );
//   }

//   Widget _buildContractButton() {
//     return Expanded(
//       child: Center(
//         child: ElevatedButton.icon(
//           onPressed: _launchWhatsApp,
//           icon: Icon(PhosphorIcons.whatsappLogo(), color: Colors.white),
//           label: Text(
//             'Contratar', 
//             style: GoogleFonts.poppins(
//               color: Colors.white, 
//               fontWeight: FontWeight.w600
//             ),
//           ),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.green[700],
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10)
//             ),
//             padding: const EdgeInsets.symmetric(
//               horizontal: 24, 
//               vertical: 14
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _launchWhatsApp() {
//     final selectedPlan = plans[selectedPlanIndex];
//     final message = '''
//       Olá, gostaria de contratar o plano ${selectedPlan['nome']} 
//       no valor de R\$ ${selectedPlan['valor'].toStringAsFixed(2)} 
//       com os benefícios selecionados
//     ''';
    
//     launchUrl(Uri.parse(
//       "https://api.whatsapp.com/send?phone=+5594992600430&text=${Uri.encodeComponent(message)}"
//     ));
//   }
// }

// // ==================== API SERVICE ====================
// class ApiService {
//   Future<List<dynamic>?> getData() async {
//     try {
//       final url = Uri.parse('https://api.velocitynet.com.br/api/v1/planos');
//       final response = await http.get(url);
      
//       if (response.statusCode == 200) {
//         final decodedResponse = jsonDecode(response.body);
//         if (decodedResponse is List) return decodedResponse;
//       }
//       return null;
//     } catch (e) {
//       throw Exception('Erro ao buscar dados: $e');
//     }
//   }
// }