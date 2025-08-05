import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_net/modules/plans/repository/selectedapp.dart';

class AppDialogs {
  // Métodos específicos para cada streaming
  static void showGloboplayDetails(BuildContext context, SelectedApp app) {
    _showStreamingDialog(
      context,
      app,
      primaryColor: const Color(0xFFED1C24), // Vermelho Globoplay
      benefits: [
        'Acesso a todos os programas da Globo',
        'Jornais e novelas na íntegra',
        'Transmissão ao vivo da Globo',
        'Conteúdo exclusivo para assinantes',
        'Programação infantil'
      ],
      icon: Icons.live_tv,
    );
  }

  static void showMAXDetails(BuildContext context, SelectedApp app) {
    _showStreamingDialog(
      context,
      app,
      primaryColor: const Color.fromARGB(255, 43, 46, 226), // Roxo HBO Max (MAX)
      benefits: [
        'Filmes da Warner Bros. e HBO',
        'Séries originais exclusivas',
        'Conteúdo infantil dedicado',
        'Novos episódios no mesmo dia da TV',
        'Até 3 telas simultâneas'
      ],
      icon: Icons.movie_filter,
    );
  }

  static void showTelecineDetails(BuildContext context, SelectedApp app) {
    _showStreamingDialog(
      context,
      app,
      primaryColor: const Color.fromARGB(255, 155, 41, 26), // Azul Telecine
      benefits: [
        'Lançamentos de cinema em casa',
        'Catálogo com mais de 1.000 filmes',
        'Conteúdo em Full HD e 4K',
        'Até 3 dispositivos simultâneos',
        'Sem intervalos comerciais'
      ],
      icon: Icons.local_movies,
    );
  }

  static void showPremiereDetails(BuildContext context, SelectedApp app) {
    _showStreamingDialog(
      context,
      app,
      primaryColor: const Color.fromARGB(255, 25, 94, 29), // Azul escuro Premiere
      benefits: [
        'Jogos ao vivo do Brasileirão',
        'Lances e replays em tempo real',
        'Estúdios e programas esportivos',
        'Transmissões exclusivas',
        'Multiplas câmeras disponíveis'
      ],
      icon: Icons.sports_soccer,
    );
  }

  static void showDeezerDetails(BuildContext context, SelectedApp app) {
    _showStreamingDialog(
      context,
      app,
      primaryColor: const Color(0xFFA12F89), // Roxo Deezer
      benefits: [
        'Catálogo com +90 milhões de músicas',
        'Playlists personalizadas',
        'Letras das músicas sincronizadas',
        'Modo offline disponível',
        'Qualidade de áudio FLAC'
      ],
      icon: Icons.music_note,
    );
  }

  static void showDefaultDetails(BuildContext context, SelectedApp app) {
  _showStreamingDialog(
    context,
    app,
    primaryColor: const Color(0xFF7C3AED), // Roxo bonito (Deep Violet)
    benefits: [
      'Acesso ao melhor do entretenimento',
      'Perfis personalizados para toda a família',
      'Disponível em todos os dispositivos',
      'Modo offline incluso',
      'Atualizações automáticas de conteúdo'
    ],
    icon: Icons.stream, // Ícone genérico moderno
  );
}


  

  static void _showStreamingDialog(
    BuildContext context,
    SelectedApp app, {
    required Color primaryColor,
    required List<String> benefits,
    IconData? icon,
  }) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(isMobile ? 16 : 24),
          child: Container(
            width: isMobile ? double.infinity : 350,
            padding: EdgeInsets.all(isMobile ? 16 : 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        app.name.toUpperCase(),
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 18 : 20,
                          fontWeight: FontWeight.w700,
                          color: primaryColor,
                          letterSpacing: 0.5,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, size: isMobile ? 24 : 28),
                        onPressed: () => Navigator.of(context).pop(),
                        color: Colors.grey[600],
                      ),
                    ],
                  ),
                  SizedBox(height: isMobile ? 16 : 20),
                  Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.2),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: _buildAppImage(app.image, icon: icon),
                      ),
                    ),
                  ),
                  SizedBox(height: isMobile ? 20 : 24),
                  Text(
                    'INCLUI:',
                    style: GoogleFonts.poppins(
                      fontSize: isMobile ? 14 : 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1A2D45),
                      letterSpacing: 0.3,
                    ),
                  ),
                  SizedBox(height: 12),
                  Column(
                    children: benefits
                        .map((benefit) => Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.check_circle_rounded,
                                      size: 20, color: primaryColor),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      benefit,
                                      style: GoogleFonts.poppins(
                                        fontSize: isMobile ? 13 : 14,
                                        color: const Color(0xFF5A6C88),
                                        height: 1.4,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                  SizedBox(height: isMobile ? 20 : 24),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: primaryColor.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'PREÇO MENSAL',
                          style: GoogleFonts.poppins(
                            fontSize: isMobile ? 12 : 13,
                            fontWeight: FontWeight.w500,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'R\$ ${app.price},00',
                          style: GoogleFonts.poppins(
                            fontSize: isMobile ? 20 : 22,
                            fontWeight: FontWeight.w700,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  

  static Widget _buildAppImage(String imageData, {IconData? icon}) {
    try {
      if (imageData.isEmpty && icon != null) {
        return Icon(icon, size: 40, color: Colors.grey[600]);
      }
      return Image.memory(
        base64Decode(imageData),
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
      );
    } catch (e) {
      return Icon(icon ?? Icons.apps, size: 40, color: Colors.grey[600]);
    }
  }
}