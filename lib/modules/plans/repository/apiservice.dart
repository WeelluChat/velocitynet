import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://api.velocitynet.com.br/api/v1';
  // static const String baseImageUrl = "https://api.velocitynet.com.br/";
  static const String uploadsUrl =
      'https://api.velocitynet.com.br/uploads/category/';

  Future<List<dynamic>> getPlanos() async {
    try {
      final url = Uri.parse('$baseUrl/planos');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        if (decodedResponse is List) return decodedResponse;
        throw Exception('Formato de resposta inválido');
      }
      throw Exception('Falha ao carregar dados: ${response.statusCode}');
    } catch (e) {
      throw Exception('Erro na requisição: $e');
    }
  }

  Future<List<dynamic>> getCategoryPlans() async {
    try {
      final url = Uri.parse('$baseUrl/category-plan');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      throw Exception('Falha ao carregar dados: ${response.statusCode}');
    } catch (e) {
      throw Exception('Erro na requisição: $e');
    }
  }

  List<dynamic> filterPlans(List<dynamic> plans, String keyword) {
    return plans.where((item) {
      final nome = (item['nome'] ?? '').toString().toLowerCase();
      final isVisible = item['isVisible'] ?? true;
      return nome == keyword.toLowerCase() && isVisible;
    }).toList();
  }

  String getImageUrl(String? path) {
    if (path == null || path.isEmpty) return '';
    return '$uploadsUrl$path';
  }
}