import 'package:http/http.dart' as http;
import 'package:velocity_net/constants/api_constants.dart';

void main(List<String> args) {
  Api().getSlider();
}

class Api {
  getSlider() async {
    final Uri uri = Uri.parse("${ApiConstants.baseApi}/slider");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Falha na solicitação: ${response.statusCode}');
    }
  }

  getPlans() async {
    final Uri uri = Uri.parse("${ApiConstants.baseApi}/plans");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Falha na solicitação: ${response.statusCode}');
    }
  }
}
