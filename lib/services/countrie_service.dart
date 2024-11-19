import 'dart:convert';
import 'package:autentocacao/models/Countrie.dart';
import 'package:http/http.dart' as http;

class CountrieService {
  final String urlBase = "https://restcountries.com/v3.1/all";

  Future<List<Countrie>> getCountries() async {
    final response = await http.get(Uri.parse(urlBase));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => Countrie.fromJson(item)).toList();
    } else {
      throw Exception("Erro ao buscar países");
    }
  }
}