import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart'; 

class CardModel {
  final String title;
  final String description;
  final IconData icon;

  CardModel({
    required this.title,
    required this.description,
    required this.icon,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    IconData iconData = PhosphorIcons.question; 

    if (json['logo'] is num) {
      final int codePoint = (json['logo'] as num).toInt();
      
      iconData = IconData(
        codePoint,
        fontFamily: 'Phosphor',
        fontPackage: 'flutter_phosphor_icons',
      );
    }

    return CardModel(
      title: json['name'] ?? 'Título Indisponível',
      description: json['description'] ?? 'Descrição Indisponível',
      icon: iconData,
    );
  }
}