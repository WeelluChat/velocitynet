import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        : TvModel(title: '', description: '', value: '', image: '');

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 40,
        runSpacing: 40,
        children: [
          SizedBox(
            width: 500,
            height: 400,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
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
                    return Image.memory(
                      snapshot.data!,
                      fit: BoxFit.contain,
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    );
                  }
                },
              ),
            ),
          ),
          SizedBox(
            width: 750,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    tvData.title,
                    key: ValueKey(tvData.title),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize:
                          MediaQuery.of(context).size.width < 600 ? 20 : 36,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  tvData.description,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: MediaQuery.of(context).size.width < 600 ? 12 : 18,
                    color: Colors.black87,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 30),
                Wrap(
                  spacing: 24,
                  runSpacing: 20,
                  alignment: WrapAlignment.center,
                  children: [
                    // Botão Valor
                    _HoverButton(
                      onPressed: () {},
                      borderRadius: 16,
                      backgroundColor: Colors.transparent,
                      borderColor: Colors.black,
                      hoverBackgroundColor: Colors.black.withOpacity(0.05),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.monetization_on_outlined,
                              color: Colors.black),
                          const SizedBox(width: 12),
                          Text(
                            "R\$ ${tvData.value}",
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Botão TV
                    _HoverButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/tvplanos');
                      },
                      borderRadius: 16,
                      backgroundColor: const Color(0xFFFFB000),
                      hoverBackgroundColor: const Color(0xFFFFD54F),
                      shadowColor: Colors.orangeAccent.withOpacity(0.6),
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 24),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.tv_outlined,
                              color: Color(0xff13294E)),
                          const SizedBox(width: 12),
                          Text(
                            "TV",
                            style: GoogleFonts.poppins(
                              color: const Color(0xff13294E),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
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

class _HoverButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color backgroundColor;
  final Color? hoverBackgroundColor;
  final Color? borderColor;
  final Color? shadowColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  const _HoverButton({
    required this.onPressed,
    required this.child,
    required this.backgroundColor,
    this.hoverBackgroundColor,
    this.borderColor,
    this.shadowColor,
    this.borderRadius = 12,
    this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
  });

  @override
  State<_HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<_HoverButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final bgColor = _hovering
        ? (widget.hoverBackgroundColor ?? widget.backgroundColor)
        : widget.backgroundColor;

    final border = widget.borderColor != null
        ? Border.all(color: widget.borderColor!)
        : null;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: widget.padding,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: border,
          boxShadow: _hovering && widget.shadowColor != null
              ? [
                  BoxShadow(
                    color: widget.shadowColor!,
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  )
                ]
              : [],
        ),
        child: InkWell(
          onTap: widget.onPressed,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: widget.child,
        ),
      ),
    );
  }
}
