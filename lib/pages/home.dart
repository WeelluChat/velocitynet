import 'package:flutter/material.dart';
import 'package:velocity_net/components/appbar/app_bar_component.dart';
import 'package:velocity_net/components/drawer/drawer_component.dart';
import 'package:velocity_net/pages/main.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool mobile = false;

  @override
  Widget build(BuildContext context) {
    mobile = MediaQuery.of(context).size.width > 1300 ? false : true;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: AppBarComponent(),
      ),
      body: const Main(),
      endDrawer: SizedBox(
          width: 200, child: mobile ? DrawerComponent(mobile: mobile) : null),
      // appBar: PreferredSize(
      //   preferredSize: const Size.fromHeight(80),
      //   child: Container(
      //     width: double.maxFinite,
      //     margin:
      //         const EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 10),
      //     child: AppBar(
      //       // elevation: 0,
      //       // backgroundColor: Colors.white,
      //       iconTheme: const IconThemeData(color: Colors.black),
      //       // leading: SizedBox(
      //       //   width: 250,
      //       //   child: Image.asset(
      //       //     'assets/logo.png',
      //       //     width: 500,
      //       //   ),
      //       // ),
      //       centerTitle: true,
      //       title: mobile
      //           ? null
      //           : SizedBox(
      //               width: 1280,
      //               child: Flex(
      //                 direction: Axis.horizontal,
      //                 children: [
      //                   Image.asset(
      //                     'logo.png',
      //                     width: 200,
      //                   ),
      //                   const SizedBox(
      //                     width: 10,
      //                   ),
      //                   TextButton(
      //                     onPressed: () {},
      //                     child: const Text(
      //                       'INÍCIO',
      //                       style: TextStyle(
      //                         color: Colors.black,
      //                       ),
      //                     ),
      //                   ),
      //                   const SizedBox(
      //                     width: 10,
      //                   ),
      //                   TextButton(
      //                     onPressed: () {},
      //                     child: const Text(
      //                       'INTERNET',
      //                       style: TextStyle(color: Colors.black),
      //                     ),
      //                   ),
      //                   const SizedBox(
      //                     width: 10,
      //                   ),
      //                   TextButton(
      //                     onPressed: () {},
      //                     child: const Text(
      //                       'TV',
      //                       style: TextStyle(color: Colors.black),
      //                     ),
      //                   ),
      //                   const SizedBox(
      //                     width: 10,
      //                   ),
      //                   TextButton(
      //                     onPressed: () {},
      //                     child: const Text(
      //                       'SOBRE NÓS',
      //                       style: TextStyle(color: Colors.black),
      //                     ),
      //                   ),
      //                   const SizedBox(
      //                     width: 10,
      //                   ),
      //                   TextButton(
      //                     onPressed: () {},
      //                     child: const Text(
      //                       'CONTATOS',
      //                       style: TextStyle(color: Colors.black),
      //                     ),
      //                   ),
      //                   const SizedBox(
      //                     width: 10,
      //                   ),
      //                   ElevatedButton(
      //                     style: const ButtonStyle(
      //                       backgroundColor: MaterialStatePropertyAll(
      //                         Color(0xFF0C13A2),
      //                       ),
      //                     ),
      //                     onPressed: () {},
      //                     child: Directionality(
      //                       textDirection: TextDirection.rtl,
      //                       child: TextButton.icon(
      //                         onPressed: () {},
      //                         label: const Text("ASSINE JÁ"),
      //                         icon: const Directionality(
      //                           textDirection: TextDirection.ltr,
      //                           child: Icon(
      //                             Icons.arrow_right_sharp,
      //                             color: Colors.white,
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                   const SizedBox(
      //                     width: 20,
      //                   ),
      //                   ElevatedButton(
      //                     style: const ButtonStyle(
      //                       backgroundColor: MaterialStatePropertyAll(
      //                         Color(0xFF0C13A2),
      //                       ),
      //                     ),
      //                     onPressed: () {},
      //                     child: Directionality(
      //                       textDirection: TextDirection.rtl,
      //                       child: TextButton.icon(
      //                         onPressed: () {},
      //                         label: const Text("CENTRAL DO ASSINANTE"),
      //                         icon: const Directionality(
      //                           textDirection: TextDirection.ltr,
      //                           child: Icon(
      //                             Icons.arrow_right_sharp,
      //                             color: Colors.white,
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //     ),
      //   ),
      // ),
      // endDrawer: SizedBox(
      //     width: 200,
      //     child: mobile
      //         ? Drawer(
      //             child: ListView(children: [
      //               Padding(
      //                 padding: const EdgeInsets.only(left: 15, top: 15),
      //                 child: InkWell(
      //                   hoverColor: Colors.transparent,
      //                   splashColor: Colors.transparent,
      //                   highlightColor: Colors.transparent,
      //                   onTap: () {
      //                     // _scrollController.animateTo(
      //                     //     _scrollController.position.minScrollExtent,
      //                     //     duration: const Duration(milliseconds: 1000),
      //                     //     curve: Curves.easeInQuad);
      //                     Navigator.pop(context);
      //                   },
      //                   child: const Text(
      //                     "Home",
      //                     style: TextStyle(fontSize: 18, color: Colors.black),
      //                   ),
      //                 ),
      //               ),
      //               const SizedBox(
      //                 width: 20,
      //                 height: 10,
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.only(left: 15),
      //                 child: InkWell(
      //                   hoverColor: Colors.transparent,
      //                   splashColor: Colors.transparent,
      //                   highlightColor: Colors.transparent,
      //                   onTap: () {
      //                     // _scrollController.animateTo(
      //                     //     _scrollController.position.minScrollExtent + 580,
      //                     //     duration: const Duration(milliseconds: 1000),
      //                     //     curve: Curves.easeInQuad);
      //                     Navigator.pop(context);
      //                   },
      //                   child: const Text(
      //                     "Novidades",
      //                     style: TextStyle(fontSize: 18, color: Colors.black),
      //                   ),
      //                 ),
      //               ),
      //               const SizedBox(
      //                 width: 20,
      //                 height: 10,
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.only(left: 15),
      //                 child: InkWell(
      //                   hoverColor: Colors.transparent,
      //                   splashColor: Colors.transparent,
      //                   highlightColor: Colors.transparent,
      //                   onTap: () {
      //                     // _scrollController.animateTo(
      //                     //     _scrollController.position.minScrollExtent + 950,
      //                     //     duration: const Duration(milliseconds: 1000),
      //                     //     curve: Curves.easeInQuad);
      //                     Navigator.pop(context);
      //                   },
      //                   child: const Text(
      //                     "Recursos",
      //                     style: TextStyle(fontSize: 18, color: Colors.black),
      //                   ),
      //                 ),
      //               ),
      //               const SizedBox(
      //                 width: 20,
      //                 height: 10,
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.only(left: 15),
      //                 child: InkWell(
      //                   hoverColor: Colors.transparent,
      //                   splashColor: Colors.transparent,
      //                   highlightColor: Colors.transparent,
      //                   onTap: () {
      //                     // _scrollController.animateTo(
      //                     //     _scrollController.position.maxScrollExtent,
      //                     //     duration: const Duration(milliseconds: 1000),
      //                     //     curve: Curves.easeInQuad);
      //                     Navigator.pop(context);
      //                   },
      //                   // style: TextButton.styleFrom(
      //                   //   side: const BorderSide(
      //                   //     width: 1.0,
      //                   //     color: Color(0xFF05AC90),
      //                   //   ),
      //                   // ),
      //                   child: const Text(
      //                     "Fale Conosco",
      //                     style:
      //                         TextStyle(color: Color(0xFF05AC90), fontSize: 18),
      //                   ),
      //                 ),
      //               ),
      //               const SizedBox(
      //                 width: 20,
      //                 height: 10,
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.only(left: 15, right: 15),
      //                 child: TextButton(
      //                   style: TextButton.styleFrom(
      //                       backgroundColor: const Color(0xFF05AC90)),
      //                   onPressed: () {},
      //                   child: const Text(
      //                     "Weellu Web",
      //                     style: TextStyle(color: Colors.white, fontSize: 18),
      //                   ),
      //                 ),
      //               ),
      //             ]),
      //           )
      //         : null),
    );
  }
}
