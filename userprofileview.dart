import 'package:flutter/material.dart';
import 'package:mic_pothole/user/profile_edit.dart';

class UserProfilePage extends StatelessWidget {
  final Map<String, dynamic> userData; // The profile data that will be passed

  // Constructor to accept userData
  UserProfilePage({required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Image at the top
            // CircleAvatar(
            //   radius: 50,
            //   backgroundImage: AssetImage('assets/images/road.jpg'), // Placeholder image
            // ),
            SizedBox(height: 20),

            // User Details Section
           _buildProfileInfo(Icons.person, (userData['name'] ?? "John Doe").toString(), "Name"),
_buildProfileInfo(Icons.calendar_today, (userData['dob'] ?? "01/01/1990").toString(), "Date of Birth"),
_buildProfileInfo(Icons.male, (userData['gender'] ?? "Male").toString(), "Gender"),
_buildProfileInfo(Icons.phone, (userData['mobileno'] ?? "+1 234 567 890").toString(), "Mobile Number"),
_buildProfileInfo(Icons.location_on, (userData['address'] ?? "New York, USA").toString(), "Place"),


            SizedBox(height: 30),

            // Edit Profile Button
            IconButton(
              icon: Icon(Icons.edit, size: 30),
              onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileEditPage(userData: userData),
                  ),
                );

                // Add functionality to edit profile here
                print("Edit profile clicked");
              },
            ),
          ],
        ),
      ),
    );
  }

  // Reusable widget for displaying profile information with icons
  Widget _buildProfileInfo(IconData icon, String value, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 30,color: const Color.fromARGB(255, 196, 103, 69),),
          SizedBox(width: 15),
          Expanded(
            child: Text(
              '$label: $value',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
