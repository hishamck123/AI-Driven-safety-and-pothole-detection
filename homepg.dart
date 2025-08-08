import 'package:flutter/material.dart';
import 'package:mic_pothole/api/getalertapi.dart';
import 'package:mic_pothole/api/getlocationapi.dart';
import 'package:mic_pothole/api/loginpageapi.dart';
import 'package:mic_pothole/api/profilegettingapi.dart';
import 'package:mic_pothole/authentication/loginpage.dart';
import 'package:mic_pothole/user/imgpg.dart';
import 'package:mic_pothole/user/mapScreen.dart';
import 'package:mic_pothole/user/userprofileview.dart';
import 'package:mic_pothole/user/viewAlertScreen.dart';
// ... keep your existing imports ...

class HomePagenew extends StatefulWidget {
  const HomePagenew({super.key});

  @override
  State<HomePagenew> createState() => _HomePageState();
}

class _HomePageState extends State<HomePagenew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Driven Safety",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 26,
            color: Colors.white,
            letterSpacing: 1.2,
            shadows: [
              Shadow(
                blurRadius: 2.0,
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(1.0, 1.0),
              ),
            ],
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade800, Colors.blue.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>LoginPage(),
                        ),
                      );
            },
            icon: Icon(Icons.logout, color: Colors.white, size: 28),
            tooltip: 'Logout',
          ),
        ],
        toolbarHeight: 88,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      drawer: _buildModernDrawer(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/road.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.2),
              BlendMode.darken,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
          child: Column(
            children: [
              _buildFeatureCard(
                children: [
                  // _buildFeatureButton(
                  //   icon: Icons.add_location_alt_outlined,
                  //   label: "Add Trip",
                  //   onTap: () {},
                  // ),
                 _buildFeatureButton(
  icon: Icons.notifications_active_outlined,
  label: "View Alerts",
  onTap: () async {
    List< Map<String, dynamic>> alerts = await getAlertMessage();  // Assuming this returns a list of AreaDetail
    if (alerts.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AreaDetailWidget(areaDetail: alerts),  // Pass a specific AreaDetail from the list
        ),
      );
    }
  },
)

                ],
              ),
              SizedBox(height: 25),
              _buildFeatureCard(
                children: [
                  _buildFeatureButton(
                    icon: Icons.map_outlined,
                    label: "Live Map",
                    onTap: () async{
             List<Map<String, dynamic>>locations=   await      getLications();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MapPopupScreen(locations:locations),
                        ),
                      );
                    },
                  ),
                  _buildFeatureButton(
                    icon: Icons.camera_alt_outlined,
                    label: "Capture Image",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UploadScreen()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModernDrawer() {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade800, Colors.blue.shade600],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.1,
                ),
              ),
            ),
          ),
          _buildDrawerTile(
            icon: Icons.home_filled,
            title: 'Home',
            onTap: () => Navigator.pop(context),
          ),
         
          _buildDrawerTile(
            icon: Icons.person_2_rounded,
            title: 'Profile',
            onTap: () async {
              Map<String, dynamic> profileData = await userprofileview();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserProfilePage(userData: profileData),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue.shade800, size: 28),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.blue.shade900,
        ),
      ),
      onTap: onTap,
      hoverColor: Colors.blue.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildFeatureCard({required List<Widget> children}) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.shade100,
              blurRadius: 12,
              spreadRadius: 2,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: children,
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Material(
          borderRadius: BorderRadius.circular(15),
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(15),
            splashColor: Colors.blue.shade100,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.blue.shade100, width: 2),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    size: 40,
                    color: Colors.blue.shade800,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue.shade900,
                      letterSpacing: 0.8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

