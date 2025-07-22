import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Questions extends StatefulWidget {
  const Questions({super.key});

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> with SingleTickerProviderStateMixin {
  int expandedIndex = -1;
  List<Map<String, dynamic>> faqs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Perguntas();
  }

  Future<void> Perguntas() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.velocitynet.com.br/api/v1/perguntas'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          faqs = data
              .map((item) => {
                    'question': item['title'],
                    'answer': item['subtitle'],
                  })
              .toList();
          isLoading = false;
        });
      } else {
        throw Exception('Erro ao carregar perguntas');
      }
    } catch (e) {
      print("Erro: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
      width: double.infinity,
      color: const Color(0xFF08203E),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: SizedBox(
              width: 700,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Perguntas e Dúvidas Frequentes',
                    style: GoogleFonts.poppins(
                      fontSize: isMobile ? 22 : 36,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  if (isLoading)
                    const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  else
                    ...List.generate(faqs.length, (index) {
                      final isExpanded = expandedIndex == index;
                      return TweenAnimationBuilder<double>(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                        tween: Tween<double>(begin: 0, end: isExpanded ? 1.0 : 0.0),
                        builder: (context, value, child) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    expandedIndex = isExpanded ? -1 : index;
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeOut,
                                  width: double.infinity,
                                  constraints: const BoxConstraints(maxWidth: 600),
                                  margin: const EdgeInsets.symmetric(vertical: 6),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: const Color(0xFFE1E6EE), width: 1),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      AnimatedRotation(
                                        duration: const Duration(milliseconds: 300),
                                        turns: isExpanded ? 0.5 : 0,
                                        child: const Icon(
                                          Icons.add_circle_outline,
                                          color: Color(0xff13294E),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          faqs[index]['question']!,
                                          style: GoogleFonts.poppins(
                                            fontSize: isMobile ? 16 : 18,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xff13294E),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ClipRect(
                                child: AnimatedAlign(
                                  alignment: Alignment.topCenter,
                                  heightFactor: value,
                                  duration: const Duration(milliseconds: 300),
                                  child: Opacity(
                                    opacity: value,
                                    child: Container(
                                      constraints: const BoxConstraints(maxWidth: 600),
                                      margin: const EdgeInsets.only(top: 5, bottom: 15),
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFAFAFA),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: const Color(0xFFE1E6EE),
                                          width: 1,
                                        ),
                                      ),
                                      child: Text(
                                        faqs[index]['answer']!,
                                        style: GoogleFonts.poppins(
                                          fontSize: isMobile ? 14 : 16,
                                          color: const Color(0xFF444444),
                                          height: 1.6,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }),
                ],
              ),
            ),
          ),
          if (!isMobile) const SizedBox(width: 80),
          if (MediaQuery.of(context).size.width > 1100)
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(250),
                child: Image.asset(
                  'assets/velocitynet_image.jpg',
                  height: 400,
                  width: 400,
                  fit: BoxFit.cover,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
