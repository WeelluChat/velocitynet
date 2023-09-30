import 'package:flutter/material.dart';

class AppBarComponent extends AppBar {
  AppBarComponent({super.key});

  @override
  State<AppBarComponent> createState() => _AppBarComponentState();
}

class _AppBarComponentState extends State<AppBarComponent> {
  // final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // var mobile = MediaQuery.of(context).size.width > 1200 ? false : true;

    return Container(
        constraints: const BoxConstraints(
          maxWidth: 500.0,
        ),
        child: Column(
          children: [
            Container(
              color: const Color(0xFF080F54),
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.location_pin,
                      color: Color(0xFFDE7642),
                    ),
                    label: const Text(
                      "Av: B QD: 298 LT:23 - Cidade Jardim, Parauapebas - PA, 68515-000",
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Image.asset(
                      "whatsapp.png",
                      width: 20,
                    ),
                    label: const Text("+55 (94) 99132-6169"),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.facebook,
                      color: Colors.blue,
                    ),
                    label: const Text("@velocitynettelecom"),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Image.asset(
                      "instagram.png",
                      width: 20,
                    ),
                    label: const Text("@velocitynet_oficial"),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: 1280,
              child: Expanded(
                child: Flex(
                  mainAxisAlignment: MainAxisAlignment.center,
                  direction: Axis.horizontal,
                  children: [
                    Image.asset(
                      'logo.png',
                      width: 200,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'INÍCIO',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'INTERNET',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'TV',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'SOBRE NÓS',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'CONTATOS',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          Color(0xFF0C13A2),
                        ),
                      ),
                      onPressed: () {},
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextButton.icon(
                          onPressed: () {},
                          label: const Text("ASSINE JÁ"),
                          icon: const Directionality(
                            textDirection: TextDirection.ltr,
                            child: Icon(
                              Icons.arrow_right_sharp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          Color(0xFF0C13A2),
                        ),
                      ),
                      onPressed: () {},
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextButton.icon(
                          onPressed: () {},
                          label: const Text("CENTRAL DO ASSINANTE"),
                          icon: const Directionality(
                            textDirection: TextDirection.ltr,
                            child: Icon(
                              Icons.arrow_right_sharp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
    // return AppBar(
    //   centerTitle: true,
    //   title: mobile
    //       ? null
    //       : SizedBox(
    //           width: 1280,
    //           child: Flex(
    //             direction: Axis.horizontal,
    //             children: [
    //               Image.asset(
    //                 'logo.png',
    //                 width: 200,
    //               ),
    //               const SizedBox(
    //                 width: 10,
    //               ),
    //               TextButton(
    //                 onPressed: () {},
    //                 child: const Text(
    //                   'INÍCIO',
    //                   style: TextStyle(
    //                     color: Colors.black,
    //                   ),
    //                 ),
    //               ),
    //               const SizedBox(
    //                 width: 10,
    //               ),
    //               TextButton(
    //                 onPressed: () {},
    //                 child: const Text(
    //                   'INTERNET',
    //                   style: TextStyle(color: Colors.black),
    //                 ),
    //               ),
    //               const SizedBox(
    //                 width: 10,
    //               ),
    //               TextButton(
    //                 onPressed: () {},
    //                 child: const Text(
    //                   'TV',
    //                   style: TextStyle(color: Colors.black),
    //                 ),
    //               ),
    //               const SizedBox(
    //                 width: 10,
    //               ),
    //               TextButton(
    //                 onPressed: () {},
    //                 child: const Text(
    //                   'SOBRE NÓS',
    //                   style: TextStyle(color: Colors.black),
    //                 ),
    //               ),
    //               const SizedBox(
    //                 width: 10,
    //               ),
    //               TextButton(
    //                 onPressed: () {},
    //                 child: const Text(
    //                   'CONTATOS',
    //                   style: TextStyle(color: Colors.black),
    //                 ),
    //               ),
    //               const SizedBox(
    //                 width: 10,
    //               ),
    //               ElevatedButton(
    //                 style: const ButtonStyle(
    //                   backgroundColor: MaterialStatePropertyAll(
    //                     Color(0xFF0C13A2),
    //                   ),
    //                 ),
    //                 onPressed: () {},
    //                 child: Directionality(
    //                   textDirection: TextDirection.rtl,
    //                   child: TextButton.icon(
    //                     onPressed: () {},
    //                     label: const Text("ASSINE JÁ"),
    //                     icon: const Directionality(
    //                       textDirection: TextDirection.ltr,
    //                       child: Icon(
    //                         Icons.arrow_right_sharp,
    //                         color: Colors.white,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               const SizedBox(
    //                 width: 20,
    //               ),
    //               ElevatedButton(
    //                 style: const ButtonStyle(
    //                   backgroundColor: MaterialStatePropertyAll(
    //                     Color(0xFF0C13A2),
    //                   ),
    //                 ),
    //                 onPressed: () {},
    //                 child: Directionality(
    //                   textDirection: TextDirection.rtl,
    //                   child: TextButton.icon(
    //                     onPressed: () {},
    //                     label: const Text("CENTRAL DO ASSINANTE"),
    //                     icon: const Directionality(
    //                       textDirection: TextDirection.ltr,
    //                       child: Icon(
    //                         Icons.arrow_right_sharp,
    //                         color: Colors.white,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    // );
  }
}
