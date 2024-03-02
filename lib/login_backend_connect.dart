import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:travel_app_client/UserProvider.dart';
import 'httpService.dart';

// final storage = FlutterSecureStorage('auth');
final FlutterSecureStorage storage = FlutterSecureStorage();
Future<bool> loginUser(String email, String password) async {
  final HttpService httpService = HttpService();

  final response = await httpService.postRequest(
    '/login',
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
    // await storage.setItem('token', data['token']);
    await storage.write(key: 'token', value: data['token']);
    print('It has entered the login backend');
    print(await storage.read(key: 'token'));
    print('It has read');
    // UserProvider();S
    // await storage.setItem('name', data['name']);
    // await storage.setItem('key', value)
    return true;
  } else {
    // Login error
    return false;
  }
}
