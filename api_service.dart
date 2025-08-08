// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class ApiService {
//   static const String baseUrl = "http://your-flask-server-ip:5000"; // Update with your server IP

//   Future<List<Map<String, dynamic>>> getLocationData(String lid) async {
//     final Uri url = Uri.parse("$baseUrl/get_location?id=$lid");

//     try {
//       final response = await http.get(url);

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = jsonDecode(response.body);

//         if (data['task'] == 'success') {
//           return List<Map<String, dynamic>>.from(data['alerts']);
//         } else {
//           return []; // Return empty list if task is invalid
//         }
//       } else {
//         throw Exception("Failed to load location data");
//       }
//     } catch (e) {
//       throw Exception("Error fetching data: $e");
//     }
//   }
// }
