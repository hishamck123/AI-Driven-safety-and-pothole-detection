import 'package:flutter/material.dart';
import 'package:mic_pothole/api/loginpageapi.dart';

class AreaDetailWidget extends StatelessWidget {
  final List<Map<String, dynamic>> areaDetail;

  AreaDetailWidget({required this.areaDetail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Area Details'),
      ),
      body: ListView.builder(
        itemCount: areaDetail.length,  // Set the item count to the length of the areaDetail list
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display area
                  Row(
                    children: [
                      Icon(Icons.location_pin),
                      SizedBox(width: 10,),
                      Text(
                        areaDetail[index]['area'],  // Use index to access each item's area
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  // Display description
                  Text(
                    areaDetail[index]['description'],  // Use index to access each item's description
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),

                  // Display image
                  // Image.network('$baseUrl/static/images/${areaDetail[index]['image']??""}'),  // Use index to access each item's image
                    // Use index to access each item's image
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
