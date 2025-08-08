import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mic_pothole/api/addPothole.dart';
import 'package:mic_pothole/api/loginpageapi.dart';

class UploadScreen extends StatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  XFile? _image;
  Position? position;
  final TextEditingController _locationController = TextEditingController();
   final TextEditingController _descriptionController= TextEditingController();
    final TextEditingController _areaController= TextEditingController();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
  }

  Future<void> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      print('Permission Denied');
    } else if (permission == LocationPermission.deniedForever) {
      print('Permission Denied Forever');
    }
  }

  Future<void> _chooseLocation() async {
    await requestLocationPermission();
    try {
      position = await Geolocator.getCurrentPosition(
        locationSettings: AndroidSettings(accuracy: LocationAccuracy.high),
      );
      setState(() {
        _locationController.text =
            'Lat: ${position!.latitude}, Lon: ${position!.longitude}';
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  Future<void> _submit() async {
    if (_image == null || position == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an image and location.')),
      );
      return;
    }

    Map data = {
      'lat': position!.latitude,
      'log': position!.longitude,
      'id': lid,
      'area':_areaController.text,
      'des':_descriptionController.text



    };

    await addPothole(_image, context, data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: _image == null
                  ? Center(child: Text('No Image Selected'))
                  : Image.file(File(_image!.path), fit: BoxFit.cover),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Upload Image'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _chooseLocation,
              child: Text('Choose Location'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'Chosen Location',
                border: OutlineInputBorder(),
              ),
              readOnly: true,
            ),
            SizedBox(height: 16),
              TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'description',
                border: OutlineInputBorder(),
              ),
            ),
              SizedBox(height: 16),
              TextFormField(
              controller: _areaController,
              decoration: InputDecoration(
                labelText: 'Pothole Area',
                border: OutlineInputBorder(),
              ),
        
            ),

            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submit,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
