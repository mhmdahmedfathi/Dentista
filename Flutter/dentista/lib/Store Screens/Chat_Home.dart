import 'package:dentista/Authentication/AuthController.dart';
import 'package:dentista/Store%20Screens/Add_bransh.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dentista/Store%20Screens/All_Products.dart';
import 'package:dentista/Store%20Screens/Delivery_chat.dart';
import 'package:dentista/Store%20Screens/Dentist_chat.dart';
import 'package:dentista/Store%20Screens/Manager_chat.dart';
import 'package:dentista/Store%20Screens/Store_Home.dart';
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

class ChatHome extends StatefulWidget {
  @override
  _ChatHomeState createState() => _ChatHomeState();
}


class _ChatHomeState extends State<ChatHome> {
  int _page=0;
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
                Icon(Icons.chat, size: 30,color: Colors.white),
                Text("Managers Chat" , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10,color: Colors.white),)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.chat, size: 30,color: Colors.white),
                Text("Deliveries Chat" , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 10,color: Colors.white),)
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
      body:   _page==0 ? Manager_Chat() : _page==1 ? Delivery_Chat() :Container(),

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
              leading: Icon(Icons.keyboard_return),
              title: Text('Return Back',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat"
                ),
              ),
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>StoreHome()));
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

