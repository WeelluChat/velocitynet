import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:velocity_net/constants/api_constants.dart';
import 'package:velocity_net/helpers/url.dart';
import 'package:velocity_net/modules/specialOffer/model/offer_model.dart';
import 'package:velocity_net/service/api.dart';

class SpecialOffer extends StatefulWidget {
  const SpecialOffer({super.key});

  @override
  State<SpecialOffer> createState() => _SpecialOfferState();
}

class _SpecialOfferState extends State<SpecialOffer> {
  List<OfferModel> offerList = [];

  offer() async {
    final offerData = await Api().getOffer();
    final jsonData = json.decode(offerData);

    setState(() {
      offerList.add(OfferModel.fromJson(jsonData[0]));
    });
  }

  @override
  void initState() {
    super.initState();
    offer();
  }

  @override
  Widget build(BuildContext context) {
    var offerData = offerList.isNotEmpty
        ? offerList[0]
        : OfferModel(title: '', description: '', value: '', image: '');

    return Container(
      padding: const EdgeInsets.only(top: 50, bottom: 50, left: 20, right: 20),
      // alignment: Alignment.center,
      width: double.infinity,
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: SizedBox(
              width: 750,
              child: Column(
                crossAxisAlignment: MediaQuery.of(context).size.width < 700
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    offerData.title,
                    textAlign: MediaQuery.of(context).size.width < 600
                        ? TextAlign.center
                        : TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:
                          MediaQuery.of(context).size.width < 600 ? 30 : 40,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    offerData.description,
                    textAlign: MediaQuery.of(context).size.width < 600
                        ? TextAlign.center
                        : TextAlign.start,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "R\$ ${offerData.value}",
                          style: const TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                              color: Color(0XFF13294E)),
                          children: const <TextSpan>[
                            TextSpan(
                              text: ' / Mês',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15),
                            )
                          ],
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.router_outlined,
                          color: Color(0XFF13294E),
                          size: 45,
                        ),
                        label: const SizedBox(
                          // color: Colors.amber,
                          width: 230,
                          child: Text(
                            "Instalação por apenas R\$ 50,00",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xffFFB000)),
                    ),
                    onPressed: () {
                      Url().urlWhatsApp();
                    },
                    child: const Text(
                      "SABER MAIS",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: MediaQuery.of(context).size.width > 1200,
            child: SizedBox(
                width: 510,
                child: FutureBuilder(
                  future: () async {
                    try {
                      final response = await http.get(Uri.parse(
                          "${ApiConstants.baseUrlUploads}/${offerData.image}"));
                      if (response.statusCode == 200) {
                        return response.bodyBytes;
                      }
                    } catch (e) {
                      print("Erro ao carregar imagem: $e");
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
                )),
          ),
        ],
      ),
    );
  }
}
