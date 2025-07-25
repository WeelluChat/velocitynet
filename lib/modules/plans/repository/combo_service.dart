// services/plano_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:velocity_net/modules/plans/repository/combo-model.dart';

class PlanoService {
  static Future<List<PlanoModel>> fetchPlanos() async {
    try {
      final response = await http.get(
        Uri.parse("https://api.velocitynet.com.br/api/v1/planos"),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => PlanoModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load planos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load planos: $e');
    }
  }
}