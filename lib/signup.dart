import 'package:flutter/material.dart';
import 'main.dart';

void main(){
  runApp(Signup());
}

class Signup extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     home: SignupPage(),
   );
  }
}

class SignupPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexToColor("#121212"),
      body: Container(
        padding: EdgeInsets.only(top: 100),
        child: Center(
          child: Column(
              children: [SizedBox(
                height: 200,
                width: 200,
                child: IconButton(onPressed: () {},
                    icon: Image.asset("assets/user.png")),
              ),
              SizedBox(height: 20,),
                signupInfo()
            ],
          ),
        ),
      ),
    );
  }
}

Widget signupInfo(){
  return Container(
    padding: EdgeInsets.all(20),
    margin: EdgeInsets.symmetric(horizontal: 40),
    decoration: BoxDecoration(
      color: hexToColor("#1e1e1e")
    ),
    child: Column(
    children: [
      Text("Full Name",style: TextStyle(color: Colors.white),),
      TextField(decoration: InputDecoration(
        hintText: "Enter Full Name"
      ),)
    ],
  ),
  );
}