import 'package:http/http.dart' as http;

Future<void> registerUser(String email, String password) async {
  final response = await http.post(
    Uri.parse('http://backend_url/register'),
    body: {
      'email': email,
      'password': password,
    },
  );

  if (response.statusCode == 200) {
    // Homepage
  }
  else {
    // Registration error
  }
}
