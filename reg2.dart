
import 'package:flutter/material.dart';
import 'package:mic_pothole/user/navigator.dart';


class regform2 extends StatefulWidget {
  const regform2({super.key});

  @override
  State<regform2> createState() => _regform2State();
}

class _regform2State extends State<regform2> {
  TextEditingController emailcontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://png.pngtree.com/thumb_back/fh260/background/20220218/pngtree-hand-painted-small-fresh-and-simple-chinese-style-illustration-mobile-phone-image_964864.jpg'),
                  fit: BoxFit.fill)),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "CREATE ACCOUNT",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 30,
                      color: Colors.blue),
                ),
                SizedBox(
                  height: 100,
                ),
                TextFormField(
                  controller: emailcontroller,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'invalid';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32)),
                      labelText: 'Email',
                      fillColor: Colors.white,
                      filled: true),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32)),
                      labelText: 'OTP',
                      fillColor: Colors.white,
                      filled: true),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: passwordcontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Invalid:  value cannot be empty';
                    } else if (value.length < 8) {
                      return 'Invalid: value must be atleast 8 characters';
                    } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
                      return 'Invalid: Must contain one uppercase';
                    } else if (!RegExp(r'[a-z]').hasMatch(value)) {
                      return 'Invalid: must contain one lowercase';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32)),
                      labelText: 'Password',
                      fillColor: Colors.white,
                      filled: true),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32)),
                      labelText: 'Confirm password',
                      fillColor: Colors.white,
                      filled: true),
                ),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                    onPressed: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>navstate()));
                      if (formkey.currentState!.validate()) {
                        
                        print("submitted");
                      }
                    },
                    child: Text('Submit')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
