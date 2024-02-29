import 'dart:convert';
import 'package:localstorage/localstorage.dart';
import 'httpService.dart';

final storage = LocalStorage('auth');

Future<bool> loginUser(String email, String password) async {
  print(email);
  final HttpService httpService = HttpService();

  final response = await httpService.post(
    'http://10.0.2.2:3000/login',
    {
      'email': email,
      'password': password,
    },
  );

  if (response.statusCode == 200) {
    // Homepage
    final data = jsonDecode(response.body);
    // print("printing the token and name");
    // print(data['token']);
    print(data);
    await storage.setItem('token', data['token']);
    await storage.setItem('name', data['name']);
    // await storage.setItem('key', value)
    return true;
  } else {
    // Login error
    return false;
  }
}
