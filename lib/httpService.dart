import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HttpService {
  final String URL = "http://localhost:8001";
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<Map<String, String>> getHeaders() async {
    final String? token = await _storage.read(key: 'token');
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<dynamic> get(String path) async {
    try {
      final response =
          await http.get(Uri.parse(URL + path), headers: await getHeaders());
      return jsonDecode(response.body);
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> post(String path, dynamic data) async {
    try {
      final response = await http.post(Uri.parse(URL + path),
          headers: await getHeaders(), body: jsonEncode(data));
      return jsonDecode(response.body);
    } catch (e) {
      print(e);
    }
  }
}
