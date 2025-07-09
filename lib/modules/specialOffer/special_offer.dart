import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xffF3F6FB), Color(0xffE9EDF5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Flex(
        direction: MediaQuery.of(context).size.width < 800
            ? Axis.vertical
            : Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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
                    style: GoogleFonts.poppins(
                      fontSize:
                          MediaQuery.of(context).size.width < 600 ? 28 : 30,
                      fontWeight: FontWeight.w700,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    offerData.description,
                    textAlign: MediaQuery.of(context).size.width < 600
                        ? TextAlign.center
                        : TextAlign.start,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: const Color(0xff4A4A4A),
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Wrap(
                    alignment: WrapAlignment.center,
                    runSpacing: 12,
                    spacing: 20,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "R\$ ${offerData.value}",
                          style: GoogleFonts.poppins(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          children: [
                            TextSpan(
                              text: ' / Mês',
                              style: GoogleFonts.poppins(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w300,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.router_outlined,
                          color: Color(0XFF13294E),
                          size: 40,
                        ),
                        label: Text(
                          "Instalação por apenas R\$ 50,00",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffFFB000),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Url().urlWhatsApp(); // descomente quando estiver pronto
                    },
                    child: Text(
                      "SABER MAIS",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 40, height: 40),
          Visibility(
            visible: MediaQuery.of(context).size.width > 1000,
            child: SizedBox(
              width: 500,
              child: FutureBuilder(
                future: () async {
                  try {
                    final response = await http.get(Uri.parse(
                        "${ApiConstants.baseUrlUploads}/${offerData.image}"));
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
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.memory(
                        snapshot.data!,
                        fit: BoxFit.cover,
                      ),
                    );
                  } else {
                    return const SizedBox(
                      height: 300,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
