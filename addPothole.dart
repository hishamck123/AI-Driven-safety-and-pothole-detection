import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mic_pothole/api/loginpageapi.dart';
import 'package:mic_pothole/api/registrationapi.dart';

// Custom SnackBar styling
const _successColor = Color(0xFF1976D2); // Primary blue
const _errorColor = Color(0xFF1565C0); // Darker blue for errors
const _textColor = Colors.white;

final dio = Dio();

// Custom SnackBar style
class SnackBarStyle {
  final Color backgroundColor;
  final Color textColor;
  final IconData icon;
  final BorderRadiusGeometry borderRadius;

  const SnackBarStyle({
    required this.backgroundColor,
    required this.textColor,
    required this.icon,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
  });
}

final successStyle = SnackBarStyle(
  backgroundColor: _successColor,
  textColor: _textColor,
  icon: Icons.check_circle,
);

final errorStyle = SnackBarStyle(
  backgroundColor: _errorColor,
  textColor: _textColor,
  icon: Icons.error,
);

void _showCustomSnackBar(BuildContext context, String message, SnackBarStyle style) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: style.backgroundColor,
      content: Row(
        children: [
          Icon(style.icon, color: style.textColor),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: style.textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: style.borderRadius,
      ),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
    ),
  );
}

Future<void> addPothole(_image, context, data) async {
  if (_image == null) {
    _showCustomSnackBar(
      context,
      '📸 Please select an image and location',
      errorStyle,
    );
    return;
  }

  try {
    FormData formData = FormData.fromMap({
      ...data,
      'file': await MultipartFile.fromFile(_image!.path),
    });

    final response = await dio.post(
      '$baseUrl/insertpothole',
      data: formData,
    );

    if (response.statusCode == 200) {
      print('Data uploaded successfully');
      _showCustomSnackBar(
        context,
        '✅ Data uploaded successfully!',
        successStyle,
      );
      Navigator.pop(context);
    } else {
      print('Upload failed: ${response.statusCode}');
      _showCustomSnackBar(
        context,
        '⚠️ Failed to upload data',
        errorStyle,
      );
    }
  } catch (e) {
    print('Error: $e');
    _showCustomSnackBar(
      context,
      '❌ Error: ${e.toString().replaceAll(RegExp(r'^Exception: '), '')}',
      errorStyle,
    );
  }
}