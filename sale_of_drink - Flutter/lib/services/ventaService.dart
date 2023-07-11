import 'dart:convert' show jsonEncode;
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../modelo/venta.dart';

class VentaService {
  static const _baseUrls = 'http://localhost:9191/venta/';

  static final client = http.Client();

  Future<List<Venta>> fetchVenta() async {
    print('Iniciando');
    print(Uri.parse(_baseUrls));
    final response = await client.get(
      Uri.parse(_baseUrls),
      headers: {'Access-Control-Allow-Origin': '*'},
    );
    print(convert.jsonDecode(response.body));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = convert.jsonDecode(response.body);
      return jsonData.map((json) => Venta.fromJson(json)).toList();
    } else {
      throw Exception('Error al listar');
    }
  }

  Future<void> createVenta(Venta ven) async {
    final response = await http.post(
      Uri.parse(_baseUrls),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(ven.toJson()), // Convertir a JSON utilizando toJson()
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to create venta${response.body}');
    }
  }

  Future<void> updateVenta(Venta ven) async {
    final response = await http.put(
      Uri.parse('$_baseUrls/update/${ven.idven}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(ven),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update venta');
    }
  }

  Future<void> deleteVenta(int idven) async {
    final response = await http.delete(Uri.parse('$_baseUrls/venta/$idven'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete venta');
    }
  }
}
