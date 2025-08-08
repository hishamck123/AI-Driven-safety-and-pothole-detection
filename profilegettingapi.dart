import 'package:dio/dio.dart';
import 'package:mic_pothole/api/loginpageapi.dart';

final dio = Dio();

Future<Map<String, dynamic>> userprofileview() async {
  try {
    // Make the API call
    final response = await dio.post('${baseUrl}/userprofile?lid=$lid');
    
    // Print the response data
    print('Response data: ${response.data}');
    
    if (response.statusCode == 200 || response.statusCode == 201) {
      // Ensure the response is treated as a Map<String, dynamic>
      Map<String, dynamic> resData = response.data as Map<String, dynamic>;
      return resData;
    } else {
      // Handle cases where the response status is not successful
      print('Failed to fetch user profile');
      return {};
    }
  } catch (e) {
    // Print and handle errors
    print('Error occurred: $e');
    return {};
  }
}
