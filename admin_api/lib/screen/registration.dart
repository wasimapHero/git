import 'dart:convert';

import 'package:admin_api/http/http.dart';
import 'package:admin_api/screen/login.dart';
import 'package:admin_api/url.dart';
import 'package:admin_api/widgets/google_fonts.dart';
import 'package:admin_api/widgets/toast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

class Registration_ extends StatefulWidget {
  const Registration_({ Key? key }) : super(key: key);

  @override
  State<Registration_> createState() => _Registration_State();
}

class _Registration_State extends State<Registration_> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();


  connectionType() async {
        var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      print("I am connected to a mobile network.");
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      print("I am connected to a wifi.");
    }
    else{
      print("no connection");
    }
  }

  registration() async {
    // connectionType();
    print(nameController.text);
    // var connection = await InternetConnectionChecker().hasConnection;
    // if(connection == true){
          try{
      var map = Map<String, dynamic>();
    map["name"] = nameController.text.toString();
    map["email"] = emailController.text.toString();
    map["password"] = passwordController.text.toString();
    map["password_confirmation"] = confirmPasswordController.text.toString();

    var response = await http.post(Uri.parse(createAdmin),
    body: map,
    headers: CustomHttpRequest.defaultHeader
    );
    print(response.body);
    // email@gmail.com

    if(response.statusCode == 201) {
      showInToast("Registration Successfull.");
      showInToast("New Admin has been created");
      // esty12@gmail.com
      Future.delayed(Duration(seconds: 4), () {
        Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Login()));
      });
      
    }
    else{
      showInToast("Resgistraiton Failed");
      print(response.statusCode);
      var a = jsonDecode(response.body);
      print("---------------------------${a["errors"]}");
      showInToast("${a["errors"]}");
    }


    }catch(e){
      print("......................$e");
    }
    // }
    // else{
    //   showInToast("No Internet Connection");
    // }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 66, 45, 124),
        title: Center(child: Text("Registration", style: myStyle(25, Color.fromARGB(255, 255, 255, 255), FontWeight.w400),)),
        elevation: 0,
        actions: const [
          Icon(FontAwesomeIcons.bars, color: Color.fromARGB(255, 255, 255, 255),),
          SizedBox(width: 20,)
        ],
        toolbarHeight: 75,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Container(
              width: double.infinity,
              child: Image.asset("assets/images/reg.jpg", fit: BoxFit.cover, height: 150,)),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, bottom: 5, top: 10),
                      child: Text("Name:", style: myStyle(17, Colors.grey, FontWeight.w400),),
                    ),
                TextField(
                  controller: nameController,
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
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, bottom: 5, top: 10),
                  child: Text("Confirm Password:", style: myStyle(17, Colors.grey, FontWeight.w400),),
                ),
                TextField(
                  controller: confirmPasswordController,
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
                  ],
                ),
              ),
              Center(
                child: Container(
                  height: 45,
                  width: 200,
                  margin: EdgeInsets.only(top:30, bottom: 20, left: 50, right: 50),
                  child: ElevatedButton(onPressed: () {
                    registration();
                  }, child: Text("Register", style: myStyles16(),), style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 107, 84, 170),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(color: Color.fromARGB(255, 70, 20, 92), )
                    )
                  ),),
                ),
              ),
              Center(
                child: Container(
                  height: 45,
                  width: 200,
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  child: TextButton(onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Login()));
                  }, child: Text("Have an account? Login here", style: myStyle(14, Colors.black),), style: TextButton.styleFrom(
                    primary: Color.fromARGB(255, 107, 84, 170),
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(5),
                    //   side: BorderSide(color: Color.fromARGB(255, 70, 20, 92), )
                    // )
                  ),),
                ),
              )
          ]),
        ),
      ),
    );
  }
}