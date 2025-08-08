
// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mic_pothole/api/loginpageapi.dart';
import 'package:mic_pothole/api/profilegettingapi.dart';
import 'package:mic_pothole/api/registrationapi.dart';
import 'package:mic_pothole/user/userprofileview.dart';


final dio = Dio();

Future<void> udateapi(data,context) async {
  try {

    Response response = await dio.post('$baseUrl/userupdateddata',data: data);
   

    
    print(response);
    print(response.statusCode);
    if (response.statusCode == 200) {
     print('success');
      Map<String, dynamic> profileData = await userprofileview();
      print('object');
     Navigator.push(context, MaterialPageRoute(builder: (ctxt)=>UserProfilePage(userData: profileData)));
     
    } else { 
      throw Exception('failed to get');
    }
  } catch (e) {
    print(e.toString());
    
  }
}
