
// import 'package:flutter/material.dart';
// import 'package:mic_pothole/homepg.dart';

// class navstate extends StatefulWidget {
//   const navstate({super.key});

//   @override
//   State<navstate> createState() => _navstateState();
// }

// class _navstateState extends State<navstate> {
//   int currentindex=0;
// List<Widget>screens=[HomePagenew(),LgPagenew()];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: screens[currentindex],
//       bottomNavigationBar: BottomNavigationBar(currentIndex:currentindex,items: [
//         BottomNavigationBarItem(icon:Icon(Icons.home),label: "Home"),
//         BottomNavigationBarItem(icon: Icon(Icons.person_2_outlined),label: "Login"),
//       ],
//       onTap: (value) {
//         currentindex=value;
//         setState(() {
          
//         });
//       },
//       ),
//     );
//   }
// }