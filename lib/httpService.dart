import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HttpService {
  HttpService._privateConstructor() {
    _initialize();
  }

  final _baseURL = "http://10.0.2.2:3000";

  static final HttpService _instance = HttpService._privateConstructor();
  final FlutterSecureStorage _storage =
      FlutterSecureStorage(); // Instance of FlutterSecureStorage
  String? token;

  factory HttpService() {
    return _instance;
  }

  _initialize() async {
    token = await _storage.read(key: 'token'); // Read token from secure storage
    print('token read-hhtpservice');
    print(token);
  }

  Future<dynamic> getRequest(String path) async {
    Response response;
    print('getrequest is getting called');
    try {
      response = await get(Uri.parse(_baseURL + path), headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader.toString(): token.toString()
      }
          // );
          // headers: {'token': 'token=$token', "Content-Type": "application/json"},
          );
      print('response.body:${response.body}');
      return jsonDecode(response.body);
      print('entered response try of getrequest');
    } catch (e) {
      print('error in getrequest');
      print(e);
    }
  }

  Future<dynamic> postRequest(String path, dynamic data) async {
    Response response;

    try {
      print('trying...');
      print(data);
      response = await post(
        Uri.parse(_baseURL + path),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(data),
      );
      final statusCode = response.statusCode;
      if (statusCode >= 200 && statusCode < 299) {
        return response;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> putRequest(String path, dynamic data, String? type) async {
    Response response;

    try {
      print(data);
      try {
        response = await put(
          Uri.parse(path),
          headers: {
            "Content-Type": type ?? "application/json",
            'cookie': 'token=$token'
          },
          body: type == null ? json.encode(data) : data,
        );
        final statusCode = response.statusCode;
        if (statusCode >= 200 && statusCode < 299) {
          return response;
        }
      } catch (e) {
        print(e);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<Response?> multipartRequest(
      String path, dynamic data, List<MultipartFile>? files) async {
    Response? res;
    print('data');
    print(data);
    try {
      var request = MultipartRequest("POST", Uri.parse(_baseURL + path));
      request.headers['cookie'] = 'token=$token';

      Map<String, String> stringData = {};
      data.forEach((key, value) {
        if (value is List) {
          stringData[key] = jsonEncode(value);
        } else {
          stringData[key] = value.toString();
        }
      });
      request.fields.addAll(stringData);

      if (files != null) request.files.addAll(files);

      final response = await request.send();
      print(response.statusCode);

      final responseBody = await Response.fromStream(response);
      print(responseBody.body);

      return responseBody;
    } catch (e) {
      print(e);
    }
  }

  String getCookie(Map<String, String> headers) {
    var cookie = headers['set-cookie'];
    List<String> cookieData = cookie!.split(';');

    String tokenData = cookieData.firstWhere(
      (part) => part.trim().startsWith('token='),
      orElse: () => '',
    );
    String token = tokenData.substring('token='.length);
    print('got token');

    return token;
  }

  Future<void> setToken(String token) async {
    await _storage.write(
        key: 'token', value: token); // Write token to secure storage
  }
}
//import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import ''
// class HttpService {
//   final String URL = "http://localhost:8001";
//   final FlutterSecureStorage _storage = FlutterSecureStorage();

//   Future<Map<String, String>> getHeaders() async {
//     final String? token = await _storage.read(key: 'token');
//     return {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $token',
//     };
//   }

//   Future<dynamic> get(String path) async {
//     try {
//       final response =
//           await http.get(Uri.parse(URL + path), headers: await getHeaders());
//       return jsonDecode(response.body);
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<dynamic> post(String path, dynamic data) async {
//     try {
//       final response = await http.post(Uri.parse(URL + path),
//           headers: await getHeaders(), body: jsonEncode(data));
//       return jsonDecode(response.body);
//     } catch (e) {
//       print(e);
//     }
//   }
// }
