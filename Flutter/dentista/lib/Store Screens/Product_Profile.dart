import 'dart:convert';
import 'package:dentista/Store%20Screens/My_Products.dart';
import'package:dentista/UsersControllers/StoreController.dart';
import 'package:dentista/Authentication/AuthController.dart';
import 'package:dentista/Models/AuthButtons.dart';
import 'package:dentista/Models/AuthenticationFields.dart';
import 'package:dentista/Models/SharedTextStyle.dart';
import 'package:dentista/UsersControllers/ManagerController.dart';
import 'package:dentista/UsersControllers/StoreProductController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http ;
import'Store_Home.dart';
class Product_Profile extends StatefulWidget {
  final int index;
  Product_Profile(this.index);
  @override
  _Product_ProfileState createState() => _Product_ProfileState(index);
}

class _Product_ProfileState extends State<Product_Profile> {
  int index=0;
  _Product_ProfileState(this.index);


  final AuthController authController = Get.put(AuthController());
  final StoreProductController ProductController = Get.put(StoreProductController());

  String updatedValue;
  final _formKey = GlobalKey<FormState>();
  void displayBottomSheet(BuildContext context,String hintText,String ColumnName) {
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
                        decoration: authDecoration('Enter new '+hintText),
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
                            Map dict;
                            final updatedata = await http.post(
                              'http://10.0.2.2:5000/Product_Update',
                              headers: <String,String>{
                                'Content-Type': 'application/json; charset=UTF-8',
                                'Charset': 'utf-8'
                              },
                              body: json.encode({
                                "dic" :{"$hintText":"$updatedValue"},
                                "ID"  : authController.StoreID,
                                "PRODUCT_NAME"  : ProductController.Products[index].Product_Name
                              }),
                            );
                            ProductController.onInit();
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Account Settings" , style: TextStyle(
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
        ),
        actions: [
          IconButton(icon: Icon(Icons.arrow_back_sharp), onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> StoreHome()));}, color: Colors.white,),
        ],
        backgroundColor: Colors.blueGrey[800],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.grey[300],
            padding: EdgeInsets.all(20),
            child: Center(
              child: CircleAvatar(
                backgroundColor: Colors.blueGrey,
                radius: 85,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text("Product INFO" , style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'montserrat',
                  letterSpacing: 2.5
              ) ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 12),
                child: Container(
                    child: Obx(()=>Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.app_blocking_outlined ),
                            SizedBox(width: 16),
                            Expanded(child:Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Product ID " , style: requestInfoStyle(color: Colors.blueGrey[500])),
                                Text(ProductController.Products[index].ProductID.toString() ,style: requestInfoStyle()  ),
                              ],
                            )),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(Icons.app_blocking_outlined ),
                            SizedBox(width: 16),
                            Expanded(child:Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Category " , style: requestInfoStyle(color: Colors.blueGrey[500])),
                                Text(ProductController.Products[index].Category ,style: requestInfoStyle()  ),
                              ],
                            )),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(Icons.app_blocking_outlined ),
                            SizedBox(width: 16),
                            Expanded(child:Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Brand " , style: requestInfoStyle(color: Colors.blueGrey[500])),
                                Text(ProductController.Products[index].Brand ,style: requestInfoStyle()  ),
                              ],
                            )),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(Icons.app_blocking_outlined ),
                            SizedBox(width: 16),
                            Expanded(child:Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("DESCRIPTION" , style: requestInfoStyle(color: Colors.blueGrey[500])),
                                Text(ProductController.Products[index].DESCRIPTION ,style: requestInfoStyle()  ),
                              ],
                            )),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(Icons.app_blocking_outlined ),
                            SizedBox(width: 16),
                            Expanded(child:Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Rate" , style: requestInfoStyle(color: Colors.blueGrey[500])),
                                Text(ProductController.Products[index].RATE.toString() ,style: requestInfoStyle()  ),
                              ],
                            )),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(Icons.person),
                            SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Paid Price " , style: requestInfoStyle(color: Colors.blueGrey[500])),
                                Text(ProductController.Products[index].ProductBoughtCost.toString(),style: requestInfoStyle()),
                              ],
                            ),
                            Spacer(),
                            IconButton(icon: Icon(Icons.edit), onPressed: (){
                              return displayBottomSheet(context,'PRICE',"");
                            })

                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(Icons.alternate_email),
                            SizedBox(width: 16),
                            Expanded(child:Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Sell Price " , style: requestInfoStyle(color: Colors.blueGrey[500])),
                                Text(ProductController.Products[index].ProductCost.toString(),style: requestInfoStyle()  ),
                              ],
                            )),
                            Spacer(),
                            IconButton(icon: Icon(Icons.edit), onPressed: (){
                              return displayBottomSheet(context,'SELLING_PRICE',"");
                            })
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(Icons.credit_card),
                            SizedBox(width: 16),
                            Expanded(child:Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Quantity " , style: requestInfoStyle(color: Colors.blueGrey[500])),
                                Text(ProductController.Products[index].ProductCount.toString(),style: requestInfoStyle()  ),
                              ],
                            )),
                            Spacer(),
                            IconButton(icon: Icon(Icons.edit), onPressed: (){
                              return displayBottomSheet(context,'NUMBER_OF_UNITS',"");
                            })
                          ],
                        ),
                        SizedBox(height: 20),

                      ],
                    ),)
                ),
              ),
            ),
          ),



        ],
      ),
    );
  }
}
