import 'package:dentista/Controllers/CartController.dart';
import 'package:dentista/ProductScreens/ViewProduct.dart';
import 'package:dentista/UsersControllers/DentistController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class DentistCart extends StatefulWidget {
  @override
  _DentistCartState createState() => _DentistCartState();
}

class _DentistCartState extends State<DentistCart> {
  DentistController dentistController = Get.put(DentistController());
  CartController cartController = Get.put(CartController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartController.onInit();
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
        centerTitle: false,
        title: Text("Cart",
          style: TextStyle(
            fontSize: 25,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.bold,
          ),

        ),
        actions: [
          IconButton(icon: Icon(Icons.clear),
              onPressed: () async
              {
                final ProductRes = await http.post(
                    'http://10.0.2.2:5000/ClearCart',
                    headers: <String,String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: json.encode({"DentistID": dentistController.DentistID}));
                cartController.onInit();
                setState(() {

                });
              }
          ),
          Obx(() =>cartController.IsLoading.value == true ? CircularProgressIndicator() : IconButton(icon: Icon(Icons.local_shipping),
              onPressed: cartController.EnoughBudget.value == false ? null : () async
              {

                final ShipCart = await http.post(
                    'http://10.0.2.2:5000/ShipCart',
                    headers: <String,String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: json.encode({"DentistID": dentistController.DentistID}));


                  // To Clean the cart and screen
                  final ProductRes = await http.post(
                      'http://10.0.2.2:5000/ClearCart',
                      headers: <String,String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                      },
                      body: json.encode({"DentistID": dentistController.DentistID}));
                  cartController.onInit();
                  setState(() {

                  });


              }
          )),
          Obx(()=> cartController.IsLoading.value == true ? CircularProgressIndicator() :
          Padding(
            padding: const EdgeInsets.only(left: 2.0, top: 12.0, bottom: 12.0, right: 2.0),
            child: Text(
                "${cartController.TotalCost.value} EGP",
              style: TextStyle(
                fontSize: 25,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.normal,
                color: cartController.EnoughBudget.value == true ? Colors.white : Colors.red
              ),
            ),
          )
          )
        ],
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
        ,child: Obx( () => cartController.IsLoading.value == true ? Center(child: CircularProgressIndicator(),) :
      StaggeredGridView.countBuilder(crossAxisCount: 2, staggeredTileBuilder: (index) => StaggeredTile.fit(1),


          itemCount: cartController.NoCartElements.value,


          itemBuilder: (BuildContext context, int index)
          {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  // Open the page of the product
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ViewProduct(cartController.CartProducts[index])));
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
                      Hero(tag: "product_${cartController.CartProducts[index].ProductName}",
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image(
                              image: NetworkImage(cartController.CartProducts[index].ImageURL),
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
                            "${cartController.CartProducts[index].ProductName}", style: TextStyle(
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
                            "${cartController.CartProducts[index].Category}", style: TextStyle(
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
                              "${cartController.CartProducts[index].Price}EGP", style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat",
                                color: Colors.blueGrey[800],
                                decoration: cartController.CartProducts[index].Discount!=0 ? TextDecoration.lineThrough : TextDecoration.none

                            ),
                            ),
                            cartController.CartProducts[index].Discount!=0 ?
                            Text(
                              "${cartController.CartProducts[index].Price - cartController.CartProducts[index].Discount}EGP",
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
                                    body: json.encode({"product_id" : cartController.CartProducts[index].ProductID, "dentist_email": dentistController.DentistEmail}));
                              },
                              alignment: Alignment.topRight,

                            ),
                            IconButton(icon: Icon(Icons.remove_circle),
                                onPressed: ()async
                                {
                                  final ProductRes = await http.post(
                                      'http://10.0.2.2:5000/RemoveFromCart',
                                      headers: <String,String>{
                                        'Content-Type': 'application/json; charset=UTF-8',
                                      },
                                      body: json.encode({"ProductID" : cartController.CartProducts[index].ProductID, "DentistID": dentistController.DentistID}));

                                  cartController.onInit();
                                  setState(() {

                                  });
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

    );
  }
}
