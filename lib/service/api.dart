import 'package:http/http.dart' as http;

void main(List<String> args) {
  Api().getSlider();
}

class Api {
  final String url = "http://10.0.0.149:3000/api/v1/slider";

  getSlider() async {
    final Uri uri = Uri.parse(url);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Falha na solicitação: ${response.statusCode}');
    }
  }
}
