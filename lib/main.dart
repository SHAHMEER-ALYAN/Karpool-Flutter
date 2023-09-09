import 'dart:convert';
import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'signup.dart';
import 'home.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //final prefs = await SharedPreferences.getInstance();
  runApp(MyApp());
}

DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users");
DatabaseReference RouteRef = FirebaseDatabase.instance.ref().child("Route");
final FirebaseAuth _auth = FirebaseAuth.instance;
String userId = '';

TextEditingController emailMainController = TextEditingController();
TextEditingController passwordController = TextEditingController();


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: MyLoginPage.idScreen,
        routes:
        {
          SignupPage.idScreen: (context) => SignupPage(),
          MyLoginPage.idScreen: (context) => MyLoginPage(),
          MyHomePage.idScreen: (context) => MyHomePage(),
        },
    );
  }
}

class MyLoginPage extends StatefulWidget {
  static const String idScreen = "login";

  const MyLoginPage({super.key});
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
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
              Text(
                "KARPOOL",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              loginBox(),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: hexToColor("#1E847F"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  fixedSize: Size(180, 40),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignupPage()));
                },
                child: Text("SIGN UP"),
              ),
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
            child: const Text(
              "Email",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          TextField(
            controller: emailMainController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Enter Your Email",
              hintStyle: TextStyle(color: hexToColor("#777777")),
              border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: const Text(
              "Password",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          TextField(
            controller: passwordController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Enter Password",
              hintStyle: TextStyle(color: hexToColor('#777777')),
              border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () {},
              child: Text(
                "Forget Password?",
                style: TextStyle(
                    color: hexToColor("#1E847F"), fontWeight: FontWeight.bold),
              ),
              style: TextButton.styleFrom(
                padding: EdgeInsets.only(top: 15),
              ),
            ),
          ),
          checkboxWidget(),
          ElevatedButton(
            onPressed: () {
             /* if(!email.text.contains("@")){
              displayToastMessage("Email address is not valid", context);
              }
              else if(password.text.length<7){
                displayToastMessage("Password is mandatory", context);
              }*/
              //else {
                loginUser(context);
               //}
            },
            child: const Text("LOGIN"),
            style: ElevatedButton.styleFrom(
              backgroundColor: hexToColor("#1E847F"),
              fixedSize: Size(130, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
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
          const SizedBox(width: 6),
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

  // Move the loginUser function outside of the build method
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    void loginUser(BuildContext context) async{

      try {
        final userCredential = await _auth.signInWithEmailAndPassword(
          email: emailMainController.text.trim(),
          password: passwordController.text.trim(),
        );

        final user = userCredential.user;
        if (user != null) {
          setState(() {
            // print("%%%%%%%%%%% ${user.uid}");
            userId = user.uid;
            Navigator.pushNamedAndRemoveUntil(context, MyHomePage.idScreen, (route) => false);

          });
        } else {
          setState(() {
            userId = 'User not found';
          });
        }
      } catch (e) {
        setState(() {
          userId = 'Error: $e';
        });
      }

      // print('%%%%%%%%%%% ${emailMainController.text}  %%%% ${passwordController.text} %%%%');
      //
      // final User? firebaseUser = (await _firebaseAuth
      //     .signInWithEmailAndPassword(
      //
      //     email: emailMainController.text.trim(),
      //     password: passwordController.text.trim()
      // ).catchError((errMsg){
      //   displayToastMessage("Error: "+errMsg.toString(), context);
      // })).user;
      //
      // if(firebaseUser!.uid != null  )
      // {
      //
      //   usersRef.child(firebaseUser.uid).once()
      //       .then((value) => (DataSnapshot snap){
      //         print("========= ${usersRef} ============");
      //     if(snap.value != null){
      //       Navigator.pushNamedAndRemoveUntil(context, MyHomePage.idScreen, (route) => false);
      //       displayToastMessage("you are logged in successfully", context);
      //     }
      //
      //     else{
      //       _firebaseAuth.signOut();
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         const SnackBar(content: Text("USER DOES NOT EXIST"),
      //           duration: Duration(seconds: 5),)
      //       );
      //       displayToastMessage("User does not exist. Please create new account.", context);
      //     }
      //   });
      //
      // }
      // else
      // {
      //   displayToastMessage("Error Occurred, can not be signed in", context);
      // }

    }
  /*void loginUser() async {
    dynamic responseJson;
    String userId = '';
    String errorMessage = '';

    final String url = 'http://10.0.2.2/practice_api/check.php'; // Replace with your PHP script's URL

    final response = await http.post(
      Uri.parse(url),
      body: {
        'name': nameController.text,
        'password': passwordController.text,
      },
    );
    print("--------------------");

    if (response.statusCode == 200) {
      try {
        // Extract the JSON string from the response
        final jsonString = response.body.substring(response.body.indexOf('{'));
        responseJson = jsonDecode(jsonString);
        if (responseJson != null && responseJson['success']) {
          // Successful response
          setState(() {
            userId = 'User ID: ${responseJson['userId']}';

          });
          print("################ $userId");
          // Navigate to the home screen
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => home()),
          // );
          print("After navigation====");
        } else {
          setState(() {
            userId = '';
            errorMessage = 'Invalid credentials';
          });
        }
      } catch (e) {
    print("JSON decoding error: $e");
    // Handle JSON decoding error...
    }

      if (responseJson['success']) {
        print("***************");
        try {
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('userId', userId);
          print(" ******************* ");
        } catch (e) {
          print('Error: $e');
        }

        // final prefs = await SharedPreferences.getInstance();
        // prefs.setString('userId', userId);
        // print("before nav");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => home()),
        );
        setState(() async {
          userId = 'User ID: ${responseJson['userId']}';
        });
        // final prefs = await SharedPreferences.getInstance();
        // prefs.setString('userId', userId);

        // Navigate to the home screen

        print("After navigation");
      } else {
        setState(() {
          userId = '';
          errorMessage = 'Invalid credentials';
        });
      }
    } else {
      setState(() {
        userId = '';
        errorMessage = 'Error connecting to the server';
      });
    }
  }*/

}
  Color hexToColor(String hexColor) {
    return Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);
  }

