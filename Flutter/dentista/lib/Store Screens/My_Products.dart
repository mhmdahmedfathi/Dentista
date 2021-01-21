import 'package:dentista/Authentication/AuthController.dart';
import 'package:dentista/Store%20Screens/Chat_Home.dart';
import 'package:dentista/Store%20Screens/Delivery_chat.dart';
import 'package:dentista/Store%20Screens/Manager_chat.dart';
import 'package:dentista/Store%20Screens/Product_Profile.dart';
import 'package:dentista/Store%20Screens/Store_Home.dart';
import 'package:dentista/UsersControllers/StoreProductController.dart';
import 'package:dentista/Views/StoreProductView.dart';
import 'package:flutter/material.dart';
import 'package:dentista/Screens_Handler/mainscreen.dart';
import 'package:dentista/Store Screens/Add_Item.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:dentista/Models/AuthButtons.dart';
import 'package:dentista/Models/AuthenticationFields.dart';
import 'package:dentista/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import'package:dentista/utility class/Product.dart';
import 'package:dentista/Auth/Validations.dart';
import 'package:dentista/Models/Alerts.dart';
import'package:dentista/Store Screens/Store_Home.dart';
import'package:get/get.dart';

class MyProduct extends StatefulWidget {
  @override
  _MyProductState createState() => _MyProductState();
}


class _MyProductState extends State<MyProduct> {
  int products = 20;
  int present = 20;
  int perPage = 20;
  List<bool> fav = List<bool>.generate(20, (index) => false);
  _MyProductState();


  final StoreProductController ProductController = Get.put(StoreProductController());

  final AuthController authController = Get.put(AuthController());

  String ID = "";
  String Store_name = "";
  String Email = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      for (int i = 0; i<20; i++)
      {
        fav.add(false);
      }
      ProductController.onInit();
      ID= authController.StoreID;
      Store_name=authController.StoreName;
      Email=authController.GetEmail;
      present = present + perPage;
    });
  }


  void loadMore() {
    setState(() {
      for (int i = 0; i<20; i++)
      {
        fav.add(false);
      }
      ProductController.onInit();
      present = present + perPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
        centerTitle: false,
        title: Text('My Products',
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
          IconButton(icon: Icon(Icons.add), onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddItem()));}, color: Colors.white,),

        ],

      ),

      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification ScrollInfo){
          if (ScrollInfo.metrics.pixels == ScrollInfo.metrics.maxScrollExtent)
          {
            ProductController.onInit();
            loadMore();
          }
          setState(() async{
            ProductController.onInit();
          });
          return true;
        }
        ,child:GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 0.0,
        mainAxisSpacing: 0.0,
        shrinkWrap: true,
        children: List.generate(ProductController.ProductCount.value , (index) {
          return Padding(
              padding: const EdgeInsets.all(0.0),
              child: InkWell(
                onTap: (){},
                child: Card(
                  child: Column(
                    children: [
                      Obx(()=>
                          Expanded(
                            child: Text(ProductController.Products[index].Product_Name,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.deepPurpleAccent,
                                  fontFamily: "Montserrat"
                              ),
                            ),
                          ),
                      ),
                      Expanded(

                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(ProductController.Products[index].IMAGE_URL),
                              fit: BoxFit.cover,

                        child: SizedBox(
                          height: 100,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage('https://googleflutter.com/sample_image.jpg'),
                                fit: BoxFit.fill,
                              ),
                              borderRadius:
                              BorderRadius.all(Radius.circular(20.0),),

                            ),
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

                                    fontSize: 20,
                                    fontFamily: "Montserrat"
                                ),
                                textAlign: TextAlign.left,

                              ),
                            ),
                            SizedBox(width: 10,),
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                alignment: Alignment.centerRight,
                                icon: Icon(Icons.star, color: !fav[index] ? Colors.grey: Colors.amber, ),

                                onPressed: (){setState(() {

                                  fav[index] = !fav[index];
                                });},
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Align(
                                  child: IconButton(icon: Icon(Icons.more), onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Product_Profile(index) ));}, color: Colors.grey)
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
                  Text( Store_name,
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