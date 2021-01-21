import 'package:dentista/Authentication/AuthController.dart';
import 'package:dentista/Store%20Screens/Add_bransh.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dentista/Store%20Screens/Chat_Home.dart';
import 'package:dentista/UsersControllers/Product_Controller.dart';
import 'package:flutter/material.dart';
import 'package:dentista/Screens_Handler/mainscreen.dart';
import 'package:dentista/Store Screens/Add_Item.dart';
import 'dart:convert';
import 'package:dentista/Models/AuthButtons.dart';
import 'package:dentista/Models/AuthenticationFields.dart';
import 'package:dentista/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dentista/Auth/Validations.dart';
import 'package:dentista/Models/Alerts.dart';
import 'package:dentista/Store Screens/My_Products.dart';
import'package:dentista/Store Screens/Store_Profile.dart';
import'package:get/get.dart';

class All_Products extends StatefulWidget {
  @override
  _All_ProductsState createState() => _All_ProductsState();
}
class _All_ProductsState extends State<All_Products> {
  int products = 20;
  int present = 20;
  int perPage = 20;
  int _page=0;
  List<bool> fav = List<bool>.generate(20, (index) => false);
  String email;
  String Store_name = "";
  String ID = "";

  final Products_controller ProductController = Get.put(Products_controller());
  final AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    setState(() {
      for (int i = 0; i<20; i++)
      {
        fav.add(false);
      }
      present = present + perPage;
    });
  }

  void loadMore() {
    setState(() {
      for (int i = 0; i<20; i++)
      {
        fav.add(false);
      }
      present = present + perPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: false,
        title: Text('Dentista',
          style: TextStyle(
              fontSize: 30,
              fontFamily: "Montserrat"
          ),
          textAlign: TextAlign.left,
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              color: Colors.white,
              onPressed: () async {
                setState(() {
                  ProductController.onInit();
                });

              }),
        ],
        backgroundColor: Colors.blueGrey[800],
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification ScrollInfo){
          if (ScrollInfo.metrics.pixels == ScrollInfo.metrics.maxScrollExtent)
          {
            loadMore();
          }
          return true;
        }
        ,child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 0.0,
        mainAxisSpacing: 0.0,
        shrinkWrap: true,
        children: List.generate(ProductController.ProductCount.value, (index) {
          return Padding(
              padding: const EdgeInsets.all(0.0),
              child: InkWell(
                onTap: (){},
                child: Card(
                  child: Column(
                    children: [
                      Expanded(
                        child: Text(ProductController.Products[index].Product_Name,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.deepPurpleAccent,
                              fontFamily: "Montserrat"
                          ),

                        ),
                      )
                      ,
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage('https://googleflutter.com/sample_image.jpg'),
                              fit: BoxFit.fill,

                            ),
                            borderRadius:
                            BorderRadius.all(Radius.circular(20.0)),
                          ),
                        ),

                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(ProductController.Products[index].ProductCost.toString(),
                                style: TextStyle(

                                    fontSize: 15,
                                    fontFamily: "Montserrat"
                                ),
                                textAlign: TextAlign.left,

                              ),
                            ),
                            SizedBox(width: 60,),
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                alignment: Alignment.centerRight,
                                icon: Icon(Icons.star, color: !fav[index] ? Colors.grey: Colors.amber, ),

                                onPressed: (){setState(() {
                                  fav[index] = !fav[index];
                                });},
                              ),
                            )
                          ],
                        ),
                      ),


                    ],
                  ),

                ),
              )
          );
        },
        ),

      ),
      ),
      drawer: Drawer(

        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  Text("Welcome to Dentista",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat",
                        color: Colors.white
                    ),
                  ),
                  SizedBox(height: 50),
                  Text( authController.StoreName,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat",
                        color: Colors.white

                    ),)
                ],
              ),
              decoration: BoxDecoration(color: Colors.blueGrey),
            ),
            ListTile(
              leading: Icon(Icons.chat),
              title: Text('Chats',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat"
                ),
              ),
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ChatHome() ));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sign Out',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat"
                ),
              ),
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainScreen()));
              },
            ),
          ],
        ),

      ),
    );
  }
}

