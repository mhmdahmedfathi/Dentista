import 'package:dentista/Authentication/AuthController.dart';
import 'package:dentista/Store%20Screens/Add_bransh.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dentista/Store%20Screens/All_Products.dart';
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

class StoreHome extends StatefulWidget {
  @override
  _StoreHomeState createState() => _StoreHomeState();
}


class _StoreHomeState extends State<StoreHome> {
  int products = 20;
  int present = 20;
  int perPage = 20;
  int _page=0;
  List<bool> fav = List<bool>.generate(20, (index) => false);
  final AuthController authController = Get.put(AuthController());

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(

        index: 0,
        buttonBackgroundColor: Colors.grey,
        height: 50,
        color: Colors.blueGrey[800],
        backgroundColor: Colors.white,
        items: <Widget>[
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.home, size: 30,color: Colors.white),
                Text("My products" , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10,color: Colors.white),)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.account_circle, size: 30,color: Colors.white),
                Text("My Account" , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10,color: Colors.white),)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.store, size: 30,color: Colors.white),
                Text("All Products" , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 10,color: Colors.white),)
              ],
            ),
          ),

        ],
        onTap: (val){
          setState(() {
            _page = val;
          });
        },
      ),
      body:  _page ==1 ?Store_Profile(): _page==0 ? MyProduct() : _page==2 ? All_Products():Container(),

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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage('https://googleflutter.com/sample_image.jpg'),
                            fit: BoxFit.fill
                        ),
                      ),
                    ),
                  ),
                  Text( authController.StoreName,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat",
                        color: Colors.white

                    ),)
                ],
              ),
              decoration: BoxDecoration(color: Colors.deepPurpleAccent),
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

