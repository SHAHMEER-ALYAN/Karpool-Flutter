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
                child: IconButton(onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Funcationality to be added"),
                        duration:Duration(seconds: 2),));
                },
                    icon: Image.asset("assets/user.png")),
              ),
              SizedBox(height: 20,),
                signupInfo(),
                SizedBox(height: 20,),
                ElevatedButton(onPressed: () {}, child: Text("Create Account"),
                style: ElevatedButton.styleFrom(backgroundColor: hexToColor("#1E847F"),
                fixedSize: Size(130, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
                )),)
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
        borderRadius: BorderRadius.circular(20),
        color: hexToColor('#1e1e1e')
    ),
    child: Column(
    children: [
      Align(
        alignment: Alignment.centerLeft,
          child: Text("Full Name",
        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
      )
      ),
      TextField(decoration: textfieldstyle("Enter Full Name"),
      ),
      SizedBox(height: 20,),
      Align(
        alignment: Alignment.centerLeft,
        child: Text("Phone Number",
        style: textstyle(),
        ),
      ),
      TextField(decoration: textfieldstyle("Enter Phone Number"),),
      SizedBox(height: 20,),
      Align(
          alignment: Alignment.centerLeft,
          child: Text("Email",style: textstyle(),)
      ),
      TextField(decoration: textfieldstyle("Enter Email")
      ),
      SizedBox(height: 20,),
      Align(alignment: Alignment.centerLeft,
      child: Text("Password",style: textstyle(),
      ),
      ),
      TextField(decoration: textfieldstyle("Enter Password")),
      SizedBox(height: 20,),
      Align(
          alignment: Alignment.centerLeft,
          child: Text("Confirm Password",style: textstyle(),)
      ),
      TextField(decoration: textfieldstyle("Confirm Password"),
      )
    ],
  ),
  );
}

TextStyle textstyle(){
  return TextStyle(color: Colors.white,fontWeight: FontWeight.bold);
}

InputDecoration textfieldstyle(String abc){
  return InputDecoration(
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(width: 3)),hintText: abc,
      hintStyle: TextStyle(color: hexToColor("#777777"))
    );
}