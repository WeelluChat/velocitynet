import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Importação necessária
import 'package:velocity_net/modules/plans/provider/plan_provider.dart';
import 'package:velocity_net/modules/plans/repository/curriculo.dart';
import 'package:velocity_net/pages/company_values.dart';
import 'package:velocity_net/pages/contact.dart';
import 'package:velocity_net/pages/home.dart';
import 'package:velocity_net/pages/tv_plans.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PlanProvider>(
          create: (context) => PlanProvider(),
        )
      ],
      // ENVOLVA SEU MATERIALAPP COM ScreenUtilInit AQUI!
      child: ScreenUtilInit( // <-- Adicione ScreenUtilInit aqui
        // Defina o designSize com base no tamanho de tela que você usou no Figma/design.
        // Um valor comum é 360 de largura por 690 de altura para mobile.
        designSize: const Size(360, 690),
        minTextAdapt: true, // Crucial para resolver o LateInitializationError
        splitScreenMode: true, // Permite que o ScreenUtil se ajuste a modos de tela dividida

        // O builder é onde você coloca o widget que será inicializado
        builder: (context, child) {
          return MaterialApp(
            title: 'VelocityNet - Telecom',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scrollbarTheme: const ScrollbarThemeData(
                thumbColor: MaterialStatePropertyAll(
                  Colors.black,
                ),
              ),
              colorScheme: const ColorScheme.light(surface: Colors.white),
              useMaterial3: true,
            ),
            initialRoute: '/',
            routes: {
              '/': (context) => const Home(),
              '/contatos': (context) => const ContactPage(),
              '/tvplanos': (context) => const Oletv(),
              '/missao-visao': (context) => const CompanyValues(),
              '/trabalhe-conosco': (context) => const TrabalheConosco(),
              // Certifique-se de que se Monteseucombo for uma rota, ele também está aqui
              // Exemplo: '/monteseucombo': (context) => Monteseucombo(onComboSelected: (c){}),
            },
            scrollBehavior: const MaterialScrollBehavior().copyWith(
              dragDevices: {
                PointerDeviceKind.mouse,
                PointerDeviceKind.touch,
                PointerDeviceKind.stylus,
                PointerDeviceKind.unknown
              },
            ),
          );
        },
      ),
    );
  }
}