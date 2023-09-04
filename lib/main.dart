import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'signup.dart';
import 'home.dart';
import 'homewithmap.dart';

void main() {
  runApp(MyApp());
}

TextEditingController nameController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class MyApp extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
      backgroundColor: hexToColor("#121212"),
      body: Container(
        color: hexToColor('#121212'),
        alignment: Alignment.centerLeft,
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 80),
              Image.asset('assets/logo.png', width: 200, height: 200),
              Text("KARPOOL",style: TextStyle(color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold),),
              loginBox(),
              SizedBox(height:20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: hexToColor("#1E847F"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  fixedSize: Size(180, 40)
                ),
                  onPressed: () {

                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Signup()));
                  // MaterialPageRoute(builder: (context) => Signup())

                  },
                  child:Text("SIGN UP"))
            ],
          ),
        ),
      ),
    );
  }



  Widget loginBox() {
    return Container(
      margin: const EdgeInsets.fromLTRB(40, 30, 40, 0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: hexToColor('#1e1e1e'),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: const Text("Phone Number",style:
            TextStyle(color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18
            ),
            ),
          ),
          TextField(
              controller: nameController ,decoration: InputDecoration(hintText: "Enter Phone Number",
              hintStyle: TextStyle(color: hexToColor("#777777")),
              border: const UnderlineInputBorder( borderSide: BorderSide(color: Colors.black))
          )
          ),
          const SizedBox(height: 20,),
          Align(
            alignment: Alignment.centerLeft,
            child: const Text("Password",style: TextStyle(color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,),
            ),
          ),
          TextField(controller: passwordController,
              decoration: InputDecoration(hintText: "Enter Password",
              hintStyle: TextStyle(color: hexToColor('#777777')),
              border: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black,))
          ),
          ),
          Align(alignment: Alignment.center,
              child: TextButton(onPressed: () {},
                  child: Text("Forget Password?",
                    style: TextStyle(color: hexToColor("#1E847F"),
                        fontWeight: FontWeight.bold),),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.only(top: 15),)
              )
          ),
          checkboxWidget(),
          ElevatedButton(onPressed: () {

            if(nameController.text=="123456" && passwordController.text == "123456"){
            Navigator.push(
              context,MaterialPageRoute(builder: (context) => home()),
          );
            }else{
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("INVALID CREDENTIALS"),
                  duration:Duration(seconds: 2),)
              );
            }

          },
          child: const Text("LOGIN"),
            style: ElevatedButton.styleFrom(
              backgroundColor: hexToColor("#1E847F"),
                fixedSize: Size(130, 40),
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
              )
            ),
          ),
        ],
      ),
    );
  }

  Widget checkboxWidget() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Checkbox(
            value: rememberMe,
            onChanged: (newValue) {
              setState(() {
                rememberMe = newValue ?? false;
              });
            },
            activeColor: hexToColor("#1e847f"),
          ),
          const SizedBox(width: 6), // Adjust the width as needed
          const Text(
            "Remember Me",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

}

Color hexToColor(String hexColor) {
  return Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);
}

