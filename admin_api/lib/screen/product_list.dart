import 'dart:convert';

import 'package:admin_api/http/http.dart';
import 'package:admin_api/model/order_model.dart';
import 'package:admin_api/model/productModel.dart';
import 'package:admin_api/url.dart';
import 'package:admin_api/widgets/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class ProductList extends StatefulWidget {
  const ProductList({ Key? key }) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {

    List<ProductModel> productList = [];
  late ProductModel productModel;


  getAllProducts() async {
    var response = await http.get(Uri.parse(getAllProductsLink),
        headers: await CustomHttpRequest().HeaderWithToken());
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      for (var data in body) {
        productModel = ProductModel.fromJson(data);
        setState(() {
          productList.add(productModel);
        });
      }
      print("Number of products is ${productList.length}");
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    getAllProducts();
    super.initState();
  }


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 66, 45, 124),
        title: Center(child: Text("Products", style: myStyle(25, Color.fromARGB(255, 255, 255, 255), FontWeight.w400),)),
        elevation: 0,
        actions: const [
          Icon(FontAwesomeIcons.bars, color: Color.fromARGB(255, 255, 255, 255),),
          SizedBox(width: 20,)
        ],
        toolbarHeight: 75,
      ),
      body: Container(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: productList.length,
          itemBuilder: (context, index) {
            return Center(
              child: Column(
                children: [
                  Text("${productList[index].name}", style: myStyle(25, Color.fromARGB(255, 106, 31, 62)),),
                  // Image.network("${productList[index].image}"),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      height: 150,
                      color: Color.fromARGB(255, 222, 219, 227),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Category: ${productList[index].foodItemCategory?[0].name}", style: myStyle(14, Colors.black,FontWeight.w500),),
                          Text("Price: ${productList[index].price?[0].originalPrice}\$"),
                          Text("Quantity: ${productList[index].stockItems?[0].quantity}\$"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 25,)
                ],
              ),
              
            );
          },
        ),
      ),
    );
  }
}