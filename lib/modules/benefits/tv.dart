import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:velocity_net/constants/api_constants.dart';
import 'package:velocity_net/modules/benefits/model/tv_model.dart';
import 'package:velocity_net/service/api.dart';

class Tv extends StatefulWidget {
  const Tv({super.key});

  @override
  State<Tv> createState() => _TvState();
}

class _TvState extends State<Tv> {
  List<TvModel> tvList = [];

  tv() async {
    final tvData = await Api().getTv();
    final jsonData = json.decode(tvData);

    setState(() {
      tvList.add(TvModel.fromJson(jsonData[0]));
    });
  }

  @override
  void initState() {
    super.initState();
    tv();
  }

  @override
  Widget build(BuildContext context) {
    var tvData = tvList.isNotEmpty
        ? tvList[0]
        : TvModel(
            title: '',
            description: '',
            value: '',
            image: '',
          );
    return Container(
      padding: const EdgeInsets.only(bottom: 50, left: 20, right: 20, top: 50),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color(0xff08203E),
        Color(0xff06141C),
      ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SizedBox(
            height: 400,
            width: 500,
            child: FutureBuilder(
              future: () async {
                try {
                  final response = await http.get(Uri.parse(
                      "${ApiConstants.baseUrlUploads}/${tvData.image}"));
                  if (response.statusCode == 200) {
                    return response.bodyBytes;
                  }
                } catch (e) {
                  if (kDebugMode) {
                    print("Erro ao carregar imagem: $e");
                  }
                }
                return null;
              }(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.data != null) {
                  return Image.memory(snapshot.data!, fit: BoxFit.cover);
                } else {
                  return const Placeholder();
                }
              },
            ),
          ),
          SizedBox(
            width: 750,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  tvData.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize:
                          MediaQuery.of(context).size.width < 600 ? 30 : 40,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  tvData.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    ElevatedButton(
                      style: const ButtonStyle(
                        padding: WidgetStatePropertyAll(
                          EdgeInsets.only(
                              top: 20, bottom: 20, right: 40, left: 40),
                        ),
                        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            side: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                        ),
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.transparent),
                      ),
                      onPressed: () {},
                      child: Text(
                        "R\$ ${tvData.value}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: const ButtonStyle(
                        padding: WidgetStatePropertyAll(
                          EdgeInsets.only(
                              top: 20, bottom: 20, right: 40, left: 40),
                        ),
                        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        backgroundColor:
                            WidgetStatePropertyAll(Color(0XFFFFB000)),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/tvplanos');
                      },
                      child: const Text(
                        "TV",
                        style: TextStyle(
                            color: Color(0xff13294E),
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
