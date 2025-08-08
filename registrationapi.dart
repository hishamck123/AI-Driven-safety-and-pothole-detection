
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mic_pothole/api/loginpageapi.dart';


final dio = Dio();
Future<void> regapi(data,context) async {
  try {

    Response response = await dio.post('$baseUrl/user_info',data: data);
   

    
    print(response);
    print(response.statusCode);
    if (response.statusCode == 200) {
     print('success');
     Navigator.pop(context);
    } else { // List<dynamic> products = response.data;
      // List<Map<String, dynamic>> listdata =
      //     List<Map<String, dynamic>>.from(products);
      // return listdata;
      throw Exception('failed to get');
    }
  } catch (e) {
    print(e.toString());
    
  }
}
