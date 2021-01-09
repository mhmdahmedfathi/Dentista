import 'package:dentista/Controllers/ProductController.dart';
import 'package:dentista/Dentist_Screens/DentistCart.dart';
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
          IconButton(icon: Icon(Icons.search), onPressed: (){}, color: Colors.white,),
          IconButton(icon: Icon(Icons.add_shopping_cart_outlined),
              onPressed: ()
              {

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DentistCart()));
              setState(){

              }

              },
              color: Colors.white)
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
                            image: NetworkImage('https://googleflutter.com/sample_image.jpg'),
                            fit: BoxFit.fill
                        ),
                      ),
                    ),
                  ),
                  Text(fname + " " + lname,
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
              title: Text('Account Details',
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
              leading: Icon(Icons.credit_card),
              title: Text('Payment Methods',
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

    