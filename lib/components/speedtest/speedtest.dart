import 'package:flutter/material.dart';

class SpeedTest extends StatefulWidget {
  const SpeedTest({super.key});

  @override
  State<SpeedTest> createState() => _SpeedTestState();
}

class _SpeedTestState extends State<SpeedTest> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: const BoxDecoration(
         color: Color.fromARGB(255, 17, 23, 77)),
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Imagem de fundo
          Image.asset(
            'speedtest/banner_01.jpg',
            width: double.infinity,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height < 600 ? 450 : 250,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width < 600 ? 140 : 130,
                  ),
                   Text(
                     'Teste a velocidade da sua internet',
                     textAlign: TextAlign.center,
                     style: TextStyle(
                       color: Colors.white,
                       fontSize: MediaQuery.of(context).size.width < 600 ? 30 : 40,
                       fontWeight: FontWeight.bold,
                     ),
                     overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                   ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                          0xffFFB000),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0),
                      ),
                    ),
                    child:  Text(
                      'Testar',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width < 600 ? 20 : 30,
                          color: const Color(0xff13294E),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
