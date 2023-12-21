import 'package:http/http.dart' as http;

Future<bool> loginUser(String email, String password) async {
  final response = await http.post(
    Uri.parse('http://backend_url/login'),
    body: {
      'email': email,
      'password': password,
    },
  );

  if (response.statusCode == 200) {
    // Homepage
    return true;
  }
  else {
    // Login error
    return false;
  }
}
