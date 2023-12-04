import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>?> fetchUsers() async {
  final response =
      await http.get(Uri.parse('http://your-server-address:3000/users'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load users');
  }
}

Future<Map<String, dynamic>?> createUser(Map<String, dynamic> userData) async {
  final response = await http.post(
    Uri.parse('http://your-server-address:3000/users'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(userData),
  );

  if (response.statusCode == 201) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to create user');
  }
}
