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
  final String ID;
  final String Email;
  final String Store_name;
  MyProduct( this.Store_name,this.Email,this.ID);
  @override
  _MyProductState createState() => _MyProductState(Store_name,Email ,ID);
}


class _MyProductState extends State<MyProduct> {
  int products = 20;
  int present = 20;
  int perPage = 20;
  List<bool> fav = List<bool>.generate(20, (index) => false);
  String ID = "";
  String Store_name = "";
  String Email = "";
  _MyProductState(this.Store_name,this.Email,this.ID);

  
  final StoreProductController ProductController = Get.put(StoreProductController());


  

  @override
  void initState() {
    super.initState();
    setState(() {
      for (int i = 0; i<20; i++)
      {
        fav.add(false);
      }
      ProductController.onInit();
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

          })
    ],

    backgroundColor: Colors.deepPurpleAccent,
    ),

    body: NotificationListener<ScrollNotification>(
    onNotification: (ScrollNotification ScrollInfo){
    if (ScrollInfo.metrics.pixels == ScrollInfo.metrics.maxScrollExtent)
    {
      ProductController.onInit();
      loadMore();
    }
    ProductController.onInit();
    return true;
    }
    ,child:GridView.count(
    crossAxisCount: 2,
    crossAxisSpacing: 0.0,
    mainAxisSpacing: 0.0,
    shrinkWrap: true,
    children: List.generate(ProductController.ProductCount.value , (index) {
    return Padding(
    padding: const EdgeInsets.all(10.0),
    child: InkWell(
    onTap: (){},
    child: Card(
    child: Column(
    children: [
    Obx(()=>
       Text(ProductController.Products[index].Product_Name,
        style: TextStyle(
        fontSize: 20,
        color: Colors.deepPurpleAccent,
        fontFamily: "Montserrat"
        ),
      ),
    ),
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
    child: Text(ProductController.Products[index].ProductCost.toString(),

      style: TextStyle(

    fontSize: 20,
    fontFamily: "Montserrat"
    ),
    textAlign: TextAlign.left,

    ),
    ),
    SizedBox(width: 30,),
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
      Align(
          child: IconButton(icon: Icon(Icons.more), onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Product_Profile(index) ));}, color: Colors.grey)
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
          title: Text('Return Back',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "Montserrat"
            ),
          ),
          onTap: (){
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) =>StoreHome(Store_name, Email, ID)  ));
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