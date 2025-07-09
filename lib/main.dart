import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_net/modules/plans/provider/plan_provider.dart';
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
      child: MaterialApp(
        title: 'VelocityNet - Telecom',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scrollbarTheme: const ScrollbarThemeData(
            thumbColor: WidgetStatePropertyAll(
              Colors.black,
            ),
          ),
          colorScheme: const ColorScheme.light(surface: Colors.white),
          useMaterial3: true,
        ),
        home: const Home(),
        initialRoute: '/',
        routes: {
          '/contatos': (context) => const ContactPage(),
          '/tvplanos': (context) => Oletv(),
          '/missao-visao': (context) => const CompanyValues(),
        },
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.unknown
          },
        ),
      ),
    );
  }
}
