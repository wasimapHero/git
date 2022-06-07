import 'dart:io';

import 'package:admin_api/screen/category)page.dart';
import 'package:admin_api/screen/individual_product_page.dart';
import 'package:admin_api/screen/order_page.dart';
import 'package:admin_api/screen/product_list.dart';
import 'package:admin_api/screen/profile.dart';
import 'package:admin_api/widgets/colors.dart';
import 'package:admin_api/widgets/google_fonts.dart';
import 'package:admin_api/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage_ extends StatefulWidget {
  const HomePage_({ Key? key }) : super(key: key);

  @override
  State<HomePage_> createState() => _HomePage_State();
}

class _HomePage_State extends State<HomePage_> {

 int currentIndex = 0;

  List<Widget> pages = [
    ProductList(),
    Individual_product_page(),
    Order_page(),
    Category_page(),
    Profile_page(),
  ];


  

  onBackPressed() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13.0)),
            title: Text(
              "Are You Sure ?",
              style: myStyle(16, Colors.white, FontWeight.w500),
            ),
            content: Text("You are going to exit the app !"),
            titlePadding:
                EdgeInsets.only(top: 30, bottom: 12, right: 30, left: 30),
            contentPadding: EdgeInsets.only(
              left: 30,
              right: 30,
            ),
            backgroundColor: BrandColors.colorPrimaryDark,
            contentTextStyle: myStyle(
                14, BrandColors.colorText.withOpacity(0.7), FontWeight.w400),
            titleTextStyle: myStyle(18, Colors.white, FontWeight.w500),
            actionsPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            actions: <Widget>[
              MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    "No",
                    style: myStyle(14, BrandColors.colorText),
                  )),
              MaterialButton(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 22),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                color: BrandColors.colorPurple,
                child: Text(
                  'Yes',
                  style: myStyle(14, Colors.white, FontWeight.w500),
                ),
                onPressed: () {
                  exit(0);
                },
              ),
            ],
          );
        });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return onBackPressed();
        },
        child: Container(child: pages[currentIndex]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Color.fromARGB(255, 156, 75, 172),
        unselectedItemColor: Colors.blueGrey,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.listUl),
            label: "Category",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.basketShopping),
            label: "Products",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.cartArrowDown),
            label: "Orders",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.userPen),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}