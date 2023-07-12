import 'dart:convert' show jsonEncode;
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../modelo/Persona.dart';

class PersonaService {
  static const _baseUrls = 'http://localhost:9191/persona/';

  static final client = http.Client();

  Future<List<Persona>> fetchPersona() async {
    print('Iniciando');
    print(Uri.parse(_baseUrls));
    final response = await client.get(
      Uri.parse("$_baseUrls"),
      headers: {'Access-Control-Allow-Origin': '*'},
    );
    print(convert.jsonDecode(response.body));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = convert.jsonDecode(response.body);
      return jsonData.map((json) => Persona.fromJson(json)).toList();
    } else {
      throw Exception('Error al listar');
    }
  }

  Future<void> createPersona(Persona per) async {
    final response = await http.post(
      Uri.parse(_baseUrls),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(per.toJson()), // Convertir a JSON utilizando toJson()
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to create person${response.body}');
    }
  }

  Future<void> updatePersona(Persona per) async {
    final response = await http.put(
      Uri.parse('$_baseUrls/update/${per.idper}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(per),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update persona');
    }
  }

  Future<void> deletePersona(int idper) async {
    final response = await http.delete(Uri.parse('$_baseUrls/persona/$idper'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete persona');
    }
  }
}
