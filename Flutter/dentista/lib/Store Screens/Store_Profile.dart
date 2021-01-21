import 'dart:convert';
import 'package:dentista/Store%20Screens/Add_bransh.dart';
import'package:dentista/UsersControllers/StoreController.dart';
import 'package:dentista/Authentication/AuthController.dart';
import 'package:dentista/Models/AuthButtons.dart';
import 'package:dentista/Models/AuthenticationFields.dart';
import 'package:dentista/Models/SharedTextStyle.dart';
import 'package:dentista/UsersControllers/ManagerController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http ;
import'Store_Home.dart';
class Store_Profile extends StatefulWidget {
  @override
  _Store_ProfileState createState() => _Store_ProfileState();
}

class _Store_ProfileState extends State<Store_Profile> {
  final AuthController authController = Get.put(AuthController());
  final StoreController storecontroller = Get.put(StoreController());
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
                            if(hintText == 'STORE_NAME')
                            {
                              authController.setStoreName(updatedValue);
                            }
                            else if(hintText == 'EMAIL')
                            {
                              authController.setEmail(updatedValue);
                            }
                            final updatedata = await http.post(
                              'http://10.0.2.2:5000/Store_UpdateInformations',
                              headers: <String,String>{
                                'Content-Type': 'application/json; charset=UTF-8',
                                'Charset': 'utf-8'
                              },
                              body: json.encode({
                                "dic" :{"$hintText":"$updatedValue"},
                               "ID"  : authController.StoreID
                              }),
                            );
                           storecontroller.onInit();
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
        backgroundColor: Colors.blueGrey[800],
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              color: Colors.white,
              onPressed: () async {
                setState(() {
                  storecontroller.onInit();
                });

              }),
        ],),

      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text("PERSONAL INFO" , style: TextStyle(
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
                            Icon(Icons.person ),
                            SizedBox(width: 16),
                            Expanded(child:Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Store ID " , style: requestInfoStyle(color: Colors.blueGrey[500])),
                                Text(authController.StoreID,style: requestInfoStyle()  ),
                              ],
                            )),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(Icons.person_pin),
                            SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name " , style: requestInfoStyle(color: Colors.blueGrey[500])),
                                Text(storecontroller.STORE_NAME.value,style: requestInfoStyle()),
                              ],
                            ),
                            Spacer(),
                            IconButton(icon: Icon(Icons.edit), onPressed: (){
                              return displayBottomSheet(context,'STORE_NAME',"");
                            })
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(Icons.phone),
                            SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Store Phone " , style: requestInfoStyle(color: Colors.blueGrey[500])),
                                Text(storecontroller.PHONE_NUMBER.value,style: requestInfoStyle()),
                              ],
                            ),
                            Spacer(),
                            IconButton(icon: Icon(Icons.edit), onPressed: (){
                              return displayBottomSheet(context,'PHONE_NUMBER',"");
                            })

                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(Icons.alternate_email),
                            SizedBox(width: 16),
                            Container(
                              child: SizedBox(
                                width: 300,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Email " , style: requestInfoStyle(color: Colors.blueGrey[500])),
                                    Text(storecontroller.EMAIL.value,style: requestInfoStyle()  ),
                                  ],
                                ),
                              ),
                            ),
                            Spacer(),
                            IconButton(icon: Icon(Icons.edit), onPressed: (){
                              return displayBottomSheet(context,'email',"Store_EMAIL");
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
                                Text("CreditCard " , style: requestInfoStyle(color: Colors.blueGrey[500])),
                                Text(storecontroller.CREDIT_CARD_NUMBER.value,style: requestInfoStyle()  ),
                              ],
                            )),
                            Spacer(),
                            IconButton(icon: Icon(Icons.edit), onPressed: (){
                              return displayBottomSheet(context,'CREDIT_CARD_NUMBER',"");
                            })
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(Icons.store),
                            SizedBox(width: 16),
                            Expanded(child:Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Branshes " , style: requestInfoStyle(color: Colors.blueGrey[500])),
                                Text( storecontroller.Branch.value ,style: requestInfoStyle()  ),

                              ],
                            )),
                            Spacer(),
                            IconButton(icon: Icon(Icons.edit), onPressed: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Add_bransh()));
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
