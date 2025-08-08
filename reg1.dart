import 'package:flutter/material.dart';
import 'package:mic_pothole/user/reg2.dart';


class registrationform extends StatelessWidget {
  const registrationform({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      height: double.infinity,
      decoration: BoxDecoration(
       
        image: DecorationImage(image: NetworkImage('https://png.pngtree.com/thumb_back/fh260/background/20220218/pngtree-hand-painted-small-fresh-and-simple-chinese-style-illustration-mobile-phone-image_964864.jpg',),fit: BoxFit.fill)

      ),
      
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("CREATE ACCOUNT",style: TextStyle(fontWeight: FontWeight.bold,fontStyle:FontStyle.italic,fontSize: 30,color: Colors.blue  ),),
            SizedBox(height: 50,),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
                labelText: 'Full Name',
                fillColor: Colors.white,
                filled: true
          
              ),
            ),
            SizedBox(height: 30,),
            TextFormField(
              decoration: InputDecoration(
                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
                labelText: 'Age',
                fillColor: Colors.white,
                filled: true
              ),
            ),
            SizedBox(height: 30,),
            TextFormField(
              decoration: InputDecoration(
                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
                labelText: 'Gender',
                fillColor: Colors.white,
                filled: true
              ),
            ),SizedBox(height: 30,),
            TextFormField(
              decoration: InputDecoration(
                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
                labelText: 'Address',
                fillColor: Colors.white,
                filled: true
                
              ),
            ),
            SizedBox(height:30),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>regform2()));
            }, child: Text('Next'))
          ],
          
          
          
          ),
        ),
      )
        
    );
    
    
  }
}