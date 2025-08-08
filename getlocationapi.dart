import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mic_pothole/api/loginpageapi.dart';

Future<List<Map<String, dynamic>>> getLications() async {
  final Uri url = Uri.parse('$baseUrl/get_location'); // Update with your actual Flask server URL

  try {
    final response = await http.get(
      url,
      
    );
print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> dataaa=jsonDecode(response.body);
      print(dataaa['alerts']);
      return List<Map<String, dynamic>>.from(dataaa['alerts']);
    } else {
      return [];
    }
  } catch (e) {
    print(e);
    return [];
  }
}
