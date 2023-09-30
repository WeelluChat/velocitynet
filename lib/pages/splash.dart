import 'package:flutter/material.dart';
import 'package:velocity_net/pages/home.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(50),
      color: const Color.fromARGB(255, 8, 19, 112),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/logo.png", width: 500),
          Expanded(
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    "Escolha sua cidade",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        decoration: TextDecoration.none),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Home(),
                              ));
                        },
                        child: const Text(
                          "Parauapebas",
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 30,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Home(),
                              ));
                        },
                        child: const Text(
                          "Canaã dos Carajás",
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 30,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
