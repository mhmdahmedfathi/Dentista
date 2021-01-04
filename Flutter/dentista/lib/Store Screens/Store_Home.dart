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

class StoreHome extends StatefulWidget {
  final String Store_name;
  final String ID;
  final String email;
  StoreHome(this.Store_name, this.email, this.ID);
  @override
  _StoreHomeState createState() => _StoreHomeState(Store_name, email, ID);
}


class _StoreHomeState extends State<StoreHome> {
  int products = 20;
  int present = 20;
  int perPage = 20;
  List<bool> fav = List<bool>.generate(20, (index) => false);


  String email;
  String Store_name = "";
  String ID = "";
  _StoreHomeState(this.Store_name, this.email, this.ID);

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
          IconButton(icon: Icon(Icons.search), onPressed: (){}, color: Colors.white,),
          IconButton(icon: Icon(Icons.add), onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddItem(ID)));}, color: Colors.white,),
        ],
        backgroundColor: Colors.deepPurpleAccent,
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
        children: List.generate(present, (index) {
          return Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: (){},
                child: Card(
                  child: Column(
                    children: [
                      Text('Product Name',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.deepPurpleAccent,
                            fontFamily: "Montserrat"
                        ),

                      )
                      ,
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage('https://googleflutter.com/sample_image.jpg'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius:
                            BorderRadius.all(Radius.circular(20.0),),
                          ),
                        ),

                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text('15EGP',
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

                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => MainScreen()));
                          },
                          child: drawButton("add to store", Colors.green),
                        ),
                      )

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
                  Text( Store_name,
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
              leading: Icon(Icons.whatshot_sharp),
              title: Text('About Dentist',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat"
                ),
              ),
              onTap: (){
                // To Move to About Dentista Page
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle_rounded),
              title: Text('To your Products',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat"
                ),
              ),
              onTap: (){
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) =>MyProduct(Store_name, email,ID)  ));
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

