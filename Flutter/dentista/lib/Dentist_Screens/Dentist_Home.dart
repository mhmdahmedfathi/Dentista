import 'package:dentista/Authentication/AuthController.dart';
import 'package:dentista/Controllers/ProductController.dart';
import 'package:dentista/Controllers/SearchController.dart';
import 'package:dentista/Dentist_Screens/DentistAccountSetting.dart';
import 'package:dentista/Dentist_Screens/DentistCart.dart';
import 'package:dentista/Models/AuthenticationFields.dart';
import 'package:dentista/ProductScreens/ViewProduct.dart';
import 'package:dentista/SharedDesigns/LoadingCart.dart';
import 'package:dentista/UsersControllers/DentistController.dart';
import 'package:flutter/material.dart';
import 'package:dentista/Screens_Handler/mainscreen.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class DentistHome extends StatefulWidget {

  
  @override
  _DentistHomeState createState() => _DentistHomeState();
}


class _DentistHomeState extends State<DentistHome> {
  DentistController dentistController = Get.put(DentistController());
  ProductController productController = Get.put(ProductController());
  SearchController searchController = Get.put(SearchController());
  bool IsSearch = false;
  String SearchString = "";

  List<bool> fav = List<bool>.generate(10, (index) => false);


  final _formKey = GlobalKey<FormState>();
  String updatedValue = "";
  void displayBottomSheet(BuildContext context, int index) {
    String oldPassword;
    showModalBottomSheet(
        backgroundColor: Colors.blueGrey[100],
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return Container(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Form(
                      key: _formKey,
                      child: TextFormField(
                        onChanged: (val)
                        {
                          setState(() {
                            updatedValue = val;
                          });
                        },
                        autofocus: true,
                        decoration: authDecoration('duration (in Days)'),
                        validator: (val){

                          return val.isEmpty? 'Please Enter A Value' : null;
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: RaisedButton(
                        onPressed: ()async{
                          if(_formKey.currentState.validate())
                          {

                            final updatedata = await http.post(
                              'https://dentistastore.azurewebsites.net/ScheduleOrder',
                              headers: <String,String>{
                                'Content-Type': 'application/json; charset=UTF-8',
                                'Charset': 'utf-8'
                              },
                              body: json.encode({
                                "DentistID" :dentistController.DentistID.value,
                                "duration"  : updatedValue,
                                "ProductID" : productController.ProductList[index].ProductID
                              }),
                            );
                            dentistController.onInit();
                            setState(() {

                            });
                            Navigator.pop(context);
                          }
                        },
                        color: Colors.blueGrey[400],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.black87)
                        ),
                        child: Text("Update" , style: TextStyle( fontFamily: 'montserrat',
                          fontWeight: FontWeight.w600,),),
                      ),
                    ),
                  ],
                ),
              )
          );
        });
  }



  @override
  void initState() {
    super.initState();
    setState(() {
      for (int i = 0; i<20; i++)
        {
         fav.add(false);
        }

    });
  }

  void loadMore() async{
    
    await productController.FetchMore(); // Fetching More Products
    
    // increase the list of products
    int favAppend = productController.CurrentIndex.value - fav.length;
    int favStart = fav.length;
    for(int favIndex = 0; favIndex < favAppend; favIndex ++)
      fav.add(false);


    setState(() {
    });
  }
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: IsSearch == true ? Container(): Text('Dentista',
          style: TextStyle(
              fontSize: 30,
              fontFamily: "Montserrat",
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
        actions: [
          IsSearch == false ? Container() :
          Obx(()=>  TextField(
            decoration:  new InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                ),
                filled: true,
                hintStyle: new TextStyle(color: Colors.grey[800]),
                hintText: "Search",
                fillColor: Colors.white),
            onChanged: (val){SearchString = val;},
            onEditingComplete: () async
            {

              searchController.FetchProducts(SearchString);
              productController.ProductList(searchController.ProductList);
              IsSearch = false;
              setState(() {

              });
            },

          )),

/*
          IconButton(icon: Icon(Icons.search), onPressed: ()
          {
            IsSearch = true;
          }, color: Colors.white,),
          */

          IconButton(icon: Icon(Icons.shopping_cart),
              onPressed: ()
              {

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DentistCart()));
                setState(){

                }

              },
              color: Colors.white),

        ],
        backgroundColor: Colors.indigo[800],

      ),
      body: NotificationListener(
        onNotification: (ScrollNotification scrollInfo)
        {
          if (scrollInfo.metrics.pixels ==
              scrollInfo.metrics.maxScrollExtent) {
            productController.FetchMore();
          }

          return true;
        },
        child: Obx( () => productController.IsLoading.value == true  ? CardLoading(context) :
          StaggeredGridView.countBuilder(crossAxisCount: 2, staggeredTileBuilder: (index) => StaggeredTile.fit(1),


          itemCount: productController.CurrentIndex.value,


          itemBuilder: (BuildContext context, int index)
          {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  // Open the page of the product
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ViewProduct(productController.ProductList[index])));
                },
                onDoubleTap: ()
                {
                  // Add to favourites
                  fav[index] = !fav[index];
                  setState(() {

                  });

                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.grey[200]

                  ),
                  child: Column(
                    children: [
                      Hero(tag: "product_${productController.ProductList[index].ProductName}",
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image(
                              image: productController.ProductList[index].ImageURL == ""? NetworkImage('https://img.icons8.com/color/452/dentist.png') : NetworkImage(productController.ProductList[index].ImageURL),
                              fit: BoxFit.fill,
                              width: MediaQuery.of(context).size.width,
                              height: 200,

                            ),
                          )
                      ),

                      SizedBox(height: 4.0,),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "${productController.ProductList[index].ProductName}",
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Montserrat",
                              color: Colors.indigo[800]
                          ),
                          ),
                        ),
                      ),

                      SizedBox(height: 4.0,),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "${productController.ProductList[index].Category}", style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              fontFamily: "Montserrat",
                              color: Colors.lightBlueAccent[700]

                          ),
                          ),
                        ),
                      ),
                      SizedBox(height: 4.0,),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "${productController.ProductList[index].Price}EGP", style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "Montserrat",
                                  color: Colors.indigo[800],
                                  decoration: productController.ProductList[index].Discount!=0 ? TextDecoration.lineThrough : TextDecoration.none

                              ),
                              ),
                            ),
                            productController.ProductList[index].Discount!=0 ?
                            Expanded(child: Text(
                              "${productController.ProductList[index].Price - productController.ProductList[index].Discount}EGP",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                fontFamily: "Montserrat",
                                color: Colors.blueAccent[700],
                              ),

                            )) : Container(),

                          ],
                        ),

                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        IconButton(icon: Icon(Icons.add_shopping_cart,color: Colors.indigo[700]),
                          onPressed: ()async
                          {
                            final ProductRes = await http.post(
                                'https://dentistastore.azurewebsites.net/AddtoCart',
                                headers: <String,String>{
                                  'Content-Type': 'application/json; charset=UTF-8',
                                },
                                body: json.encode({"product_id" : productController.ProductList[index].ProductID, "dentist_email": dentistController.DentistEmail}));
                          },


                        ),
                        IconButton(icon: Icon(Icons.schedule, color: Colors.indigo[700],),
                          onPressed: ()
                          {
                            displayBottomSheet(context, index);
                          },

                        ),
                          fav[index] == false ?
                          IconButton(icon: Icon(Icons.favorite_border, color: Colors.indigo,),
                              onPressed: (){
                            setState(() {
                              fav[index] = true;
                            });
                              }
                          ):
                              IconButton(icon: Icon(Icons.favorite, color: Colors.red[900],), onPressed: (){
                                setState(() {
                                  fav[index] = false;
                                });
                              })
                      ],)

                    ],
                  ),
                ),
              ),
            );
          }
        )

        ),
      ),
      drawer: Drawer(

        child: Obx(() => dentistController.isLoading.value ? Container() : ListView(
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
                            image: NetworkImage(dentistController.DentistImageURL.value),
                            fit: BoxFit.fill
                        ),
                      ),
                    ),
                  ),
                  Text(dentistController.DentistFname.value + " " + dentistController.DentistLname.value,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat",
                        color: Colors.white

                    ),)
                ],
              ),
              decoration: BoxDecoration(color: Colors.indigo[800]),
            ),
            /*
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

             */
            ListTile(
              leading: Icon(Icons.account_circle_rounded, color: Colors.cyanAccent[700],),
              title: Text('Account Details',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat",
                    color: Colors.lightBlueAccent[700]
                ),
              ),
              onTap: (){
                // To Move to About Dentista Page
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DentistAccountSettings()));
              },
            ),

            ListTile(
              leading: Icon(Icons.shopping_cart, color: Colors.cyanAccent[700],),
              title: Text('My Shopping Cart',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat",
                  color: Colors.lightBlueAccent[700]
                ),
              ),
              onTap: (){
                // To Move to About Dentista Page
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DentistCart()));
              },
            ),
            /*
            ListTile(
              leading: Icon(Icons.schedule),
              title: Text('scheduled Orders',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat"
                ),
              ),
              onTap: (){
                // To Move to About Dentista Page
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ScheduleOrders()));
              },
            ),
            */
             /*
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Favorites',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat"
                ),
              ),
              onTap: (){
                // To Move to About Dentista Page
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>EmailConfirmation()));
              },
            ),
            */

            ListTile(
              leading: Icon(Icons.logout, color: Colors.cyanAccent[700],),
              title: Text('Sign Out',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat",
                  color: Colors.lightBlueAccent[700]
                ),
              ),
              onTap: (){
                AuthController authController = Get.put(AuthController());
                authController.setEmail("");
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainScreen()));
              },
            ),
          ],
        ) ),

      ),
    );
  }
}

    