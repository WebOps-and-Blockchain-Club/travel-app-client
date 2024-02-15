import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

final storage = LocalStorage('auth');

Future<bool> loginUser(String email, String password) async {
  print(email);
  final response = await http.post(
    Uri.parse('http://10.0.2.2:3000/login'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    // Homepage
    final data = jsonDecode(response.body);
    print(data['token']);
    await storage.setItem('token', data['token']);
    await storage.setItem('name', data['name']);
    return true;
  } else {
    // Login error
    return false;
  }
}
