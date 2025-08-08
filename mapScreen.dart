import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPopupScreen extends StatelessWidget {
  const MapPopupScreen({super.key,required this.locations});
  final List<Map<String, dynamic>>locations;

  @override
  Widget build(BuildContext context) {
    //    List<Map<String, dynamic>> locations = [
    //   {'latitude': 11.115885, 'longitude': 76.039734},
    //   {'latitude': 11.120830, 'longitude': 76.050058},
    //    {'latitude': 11.125000, 'longitude': 76.045000},
    //  ];

    return Scaffold(
      
      appBar: AppBar(title: const Text("Map with Popups")),
      body: FlutterMap(
        
        options: MapOptions(
          initialCenter: LatLng(locations[0]['lat'],locations[0]['log']),
          initialZoom: 15,
          onTap: (_, __) {},
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: locations.map((location) {
              return Marker(
                
                point: LatLng(location['lat'], location['log']),
                width: 80,
                height: 80,
                child: Container(
                  child: Stack(
                    children: [
                      // Shadow layer
                      Positioned(
                        bottom: 0,
                        left: 10,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      // Main marker
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.blueAccent,
                              Colors.lightBlue.shade400
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.location_pin,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}