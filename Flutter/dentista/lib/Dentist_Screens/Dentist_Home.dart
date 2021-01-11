import 'package:dentista/Authentication/AuthController.dart';
import 'package:dentista/Authentication/EmailConfirmation.dart';
import 'package:dentista/Controllers/ProductController.dart';
import 'package:dentista/Controllers/SearchController.dart';
import 'package:dentista/Dentist_Screens/DentistAccountSetting.dart';
import 'package:dentista/Dentist_Screens/DentistCart.dart';
import 'package:dentista/Dentist_Screens/scheduleOrder.dart';
import 'package:dentista/Models/AuthenticationFields.dart';
import 'package:dentista/ProductScreens/ViewProduct.dart';
import 'package:dentista/UsersControllers/DentistController.dart';
import 'package:flutter/material.dart';
import 'package:dentista/Screens_Handler/mainscreen.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class DentistHome extends StatefulWidget {
  final String fname;
  final String lname;
  final String email;
  DentistHome(this.fname, this.lname, this.email);
  @override
  _DentistHomeState createState() => _DentistHomeState(fname, lname, email);
}


class _DentistHomeState extends State<DentistHome> {
  DentistController dentistController = Get.put(DentistController());
  ProductController productController = Get.put(ProductController());
  int products = 20;
  int present = 20;
  int perPage = 20;
  List<bool> fav = List<bool>.generate(20, (index) => false);


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
                              'http://10.0.2.2:5000/ScheduleOrder',
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





  String email;
  String fname = "";
  String lname = "";
  _DentistHomeState(this.fname, this.lname, this.email);

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
  SearchController searchController = Get.put(SearchController());
  bool IsSearch = false;
  String SearchString = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Dentista',
          style: TextStyle(
              fontSize: 30,
              fontFamily: "Montserrat",
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
        actions: [

          IconButton(icon: Icon(Icons.add_shopping_cart_outlined),
              onPressed: ()
              {

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DentistCart()));
              setState(){

              }

              },
              color: Colors.white),
          IconButton(icon: Icon(Icons.search), onPressed: ()
          {
            IsSearch = true;
          }, color: Colors.white,),
          IsSearch == false ? Container() :
          Obx(()=> searchController.IsLoading.value == true ? CircularProgressIndicator() : TextField(
            decoration:  new InputDecoration(
    border: new OutlineInputBorder(
    borderRadius: const BorderRadius.all(
    const Radius.circular(10.0),
    ),
    ),
    filled: true,
    hintStyle: new TextStyle(color: Colors.grey[800]),
    hintText: "Type in your text",
    fillColor: Colors.white70),
            onChanged: (val){SearchString = val;},
            onEditingComplete: () async
            {
              IsSearch = false;
              searchController.FetchProducts(SearchString);
              productController.ProductList(searchController.ProductList);
              setState(() {

              });
            },

          ))

        ],
        backgroundColor: Colors.blueGrey[800],

      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification ScrollInfo){
          /*
          if (ScrollInfo.metrics.pixels == ScrollInfo.metrics.maxScrollExtent)
            {
              loadMore();
            }
            */

          return true;
        }
        ,child: Obx( () => productController.IsLoading.value == true ? Center(child: CircularProgressIndicator(),) :
          StaggeredGridView.countBuilder(crossAxisCount: 2, staggeredTileBuilder: (index) => StaggeredTile.fit(1),


          itemCount: productController.NoProducts.value,


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
                              image: NetworkImage(productController.ProductList[index].ImageURL),
                              fit: BoxFit.fill,
                              width: MediaQuery.of(context).size.width,
                              height: 200,


                            ),
                          )
                      ),
                      SizedBox(height: 8.0,),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "${productController.ProductList[index].ProductName}", style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Montserrat",
                              color: Colors.blueGrey[800]

                          ),
                          ),
                        ),
                      ),

                      SizedBox(height: 8.0,),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "${productController.ProductList[index].Category}", style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Montserrat",
                              color: Colors.black

                          ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${productController.ProductList[index].Price}EGP", style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat",
                                color: Colors.blueGrey[800],
                                decoration: productController.ProductList[index].Discount!=0 ? TextDecoration.lineThrough : TextDecoration.none

                            ),
                            ),
                            productController.ProductList[index].Discount!=0 ?
                            Text(
                              "${productController.ProductList[index].Price - productController.ProductList[index].Discount}EGP",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat",
                                color: Colors.black,
                              ),

                            ) : Container(),
                            IconButton(icon: Icon(Icons.add_shopping_cart),
                              onPressed: ()async
                              {
                                final ProductRes = await http.post(
                                    'http://10.0.2.2:5000/AddtoCart',
                                    headers: <String,String>{
                                      'Content-Type': 'application/json; charset=UTF-8',
                                    },
                                    body: json.encode({"product_id" : productController.ProductList[index].ProductID, "dentist_email": dentistController.DentistEmail}));
                              },
                              alignment: Alignment.topRight,

                            ),
                            IconButton(icon: Icon(Icons.schedule),
                                onPressed: ()
                                {
                                  displayBottomSheet(context, index);
                                }
                            )
                          ],
                        ),
                      ),


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
              decoration: BoxDecoration(color: Colors.blueGrey[800]),
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
              leading: Icon(Icons.account_circle_rounded),
              title: Text('Account Details',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat"
                ),
              ),
              onTap: (){
                // To Move to About Dentista Page
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DentistAccountSettings()));
              },
            ),

            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('My Shopping Cart',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat"
                ),
              ),
              onTap: (){
                // To Move to About Dentista Page
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DentistCart()));
              },
            ),
            ListTile(
              leading: Icon(Icons.schedule),
              title: Text('scheduled Orders',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat"
                ),
              ),
              onTap: (){
                // To Move to About Dentista Page
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ScheduleOrder()));
              },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Favorites',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat"
                ),
              ),
              onTap: (){
                // To Move to About Dentista Page
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>EmailConfirmation()));
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
                AuthController authController = Get.put(AuthController());
                authController.setEmail("");
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainScreen()));
              },
            ),
          ],
        ),

      ),
    );
  }
}

    