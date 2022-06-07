import 'dart:convert';


import 'package:admin_api/screen/homepage.dart';
import 'package:admin_api/screen/registration.dart';
import 'package:admin_api/url.dart';
import 'package:admin_api/widgets/google_fonts.dart';
import 'package:admin_api/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  String? token;
  SharedPreferences? sharedPreferences;

  isLogin() async {
    sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences!.getString("token");
    if (token!.isNotEmpty) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomePage_()));
    } 
  }

  getLogin() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var map = Map<String, dynamic>();
    map["email"] = emailController.text.toString();
    map["password"] = passwordController.text.toString();
    var response = await http.post(
      Uri.parse(loginAdmin),
      body: map,
    );
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        sharedPreferences!.setString("token", data["access_token"]);
      });
      token = sharedPreferences!.getString("token");
      print("Token Saved $token");
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomePage_()));
      showInToast("Login Succesfull");
    } else {
      showInToast("Login Failed");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    isLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                backgroundColor: Color.fromARGB(255, 66, 45, 124),
        title: Center(child: Text("Login", style: myStyle(25, Color.fromARGB(255, 255, 255, 255), FontWeight.w400),)),
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Registration_()));
          },
          child: Icon(FontAwesomeIcons.arrowLeft, color: Color.fromARGB(255, 255, 255, 255),)),
        toolbarHeight: 75,
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                  padding: const EdgeInsets.only(left: 10.0, bottom: 5, top: 10),
                  child: Text("Email:", style: myStyle(17, Colors.grey, FontWeight.w400),),
                ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    style: BorderStyle.solid,
                    width: 3,
                    color: Color.fromARGB(255, 197, 51, 63),
                  ),
                  borderRadius:  BorderRadius.circular(25.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    style: BorderStyle.solid,
                    width: 2,
                    color: Color.fromARGB(255, 197, 51, 63),
                  ),
                  borderRadius:  BorderRadius.circular(25.0),
                ),
              ),
            ),
            Padding(
                  padding: const EdgeInsets.only(left: 10.0, bottom: 5, top: 10),
                  child: Text("Password:", style: myStyle(17, Colors.grey, FontWeight.w400),),
                ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    style: BorderStyle.solid,
                    width: 3,
                    color: Color.fromARGB(255, 197, 51, 63),
                  ),
                  borderRadius:  BorderRadius.circular(25.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    style: BorderStyle.solid,
                    width: 2,
                    color: Color.fromARGB(255, 197, 51, 63),
                  ),
                  borderRadius:  BorderRadius.circular(25.0),
                ),
              ),
            ),

            Center(
            child: Container(
              height: 45,
              width: 200,
              margin: EdgeInsets.all(50),
              child: ElevatedButton(onPressed: () {
                getLogin();
              }, child: Text("Login", style: myStyles16(),), style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 107, 84, 170),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(color: Color.fromARGB(255, 70, 20, 92), )
                )
              ),),
            ),
          ),
          ],
        ),
      ),
    );
  }
}
