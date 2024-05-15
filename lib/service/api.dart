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

    final response = await http.get(
      uri,
      // headers: {
      //   "Content-Type": "application/json",
      //   'Authorization':
      //       'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1ZTYwZWRkY2ExZWI5MzM0NzYyZDdlOCIsImVtYWlsIjoidmVsb2NpdHluZXRmaW5hbmNlaXJvQGdtYWlsLmNvbSIsImlhdCI6MTcwOTU3NjM0M30.A-k4SowLsSISogNm5TREo2a80Ogb7ewPtXbIIFkOpcA',
      // },
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Falha na solicitação: ${response.statusCode}');
    }
  }

  getCards() async {
    final Uri uri = Uri.parse("${ApiConstants.baseApi}/card");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Falha na solicitação: ${response.statusCode}');
    }
  }

  getOffer() async {
    final Uri uri = Uri.parse("${ApiConstants.baseApi}/offer");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Falha na solicitação: ${response.statusCode}');
    }
  }

  getTv() async {
    final Uri uri = Uri.parse("${ApiConstants.baseApi}/tv");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Falha na solicitação: ${response.statusCode}');
    }
  }
}
