import 'package:flutter/material.dart';

class CardData {
  final String title;
  final String description;
  final IconData icon;

  CardData({
    required this.title,
    required this.description,
    required this.icon,
  });

  factory CardData.fromJson(Map<String, dynamic> json) {
    final Map<String, IconData> iconMappings = {
      "Icons.wifi_rounded": Icons.wifi_rounded,
      "Icons.connected_tv": Icons.connected_tv,
      "Icons.router_outlined": Icons.router_outlined,
      "Icons.construction": Icons.construction,
      "Icons.groups": Icons.groups,
    };

    IconData iconData = Icons.error;

    if (json.containsKey('logo')) {
      final String logoString = json['logo'];
      if (iconMappings.containsKey(logoString)) {
        iconData = iconMappings[logoString]!;
      }
    }

    return CardData(
      title: json['name'],
      description: json['description'],
      icon: iconData,
    );
  }
}
