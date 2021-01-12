import 'dart:convert';

import 'package:dentista/Authentication/AuthController.dart';
import 'package:dentista/Delivery_Screens/DeliveryHome.dart';
import 'package:dentista/Manager%20Screens/Manager_Home.dart';
import 'package:dentista/Models/AuthButtons.dart';
import 'package:dentista/Models/AuthenticationFields.dart';
import 'package:dentista/Screens_Handler/Temp_Home.dart';
import 'package:dentista/Screens_Handler/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dentista/Dentist_Screens/Dentist_Home.dart';
import 'package:dentista/Delivery_Screens/DeliveryHome.dart';
import 'package:dentista/Store Screens/Store_Home.dart';
import 'package:dentista/Models/Alerts.dart';
import 'package:get/get.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthController authController = Get.put(AuthController());
  /*Future setSharedpref() async
  {
    //Shared Prefrences is used as a local database for each app user
    //we store boolen value indicates whether the user is logged in or not
    //to decide which screen that he should view
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('loggedin', true);
  }*/
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool rememberme = false;

  void SuccessfulSignIn(String AccountType){
    if(rememberme)
    {
      authController.ChangeState();
      authController.setEmail(email);
      authController.setAccountType(AccountType);
    }
    else
    {
      authController.setEmail(email);
      authController.setAccountType(AccountType);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //We used safearea widget to avoid rendering under notification bar
          SafeArea(
            child: Container(
              color: Colors.grey[200],
              padding: EdgeInsets.fromLTRB(30, 30, 30, 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Dentista" ,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat",
                          fontSize: 60.0,
                        ),
                      ),
                      Text("." ,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 90.0,
                            color: Colors.blueGrey[800]
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 30,right: 30 , top: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: authDecoration("Email"),
                        onChanged: (val){
                          setState(() {
                            email = val;
                          });
                        },
                        validator: (val)
                        {
                          return val.isEmpty ? "Please Enter Your Email" : null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        obscureText: true,
                        decoration: authDecoration("Password", icon: Icons.lock),
                        onChanged: (val){
                          setState(() {
                            password = val;
                          });
                        },
                        validator: (val)
                        {
                          return val.length < 6 ? "Please Enter valid password" : null;
                        },
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Checkbox(
                            activeColor: Colors.blueGrey[800],
                            onChanged: (bool val) {
                              setState(() {
                                this.rememberme = val;

                              });
                            },
                            value: this.rememberme,
                          ),
                          Text("Remember Me",
                            style: TextStyle(
                                fontSize: 13.0,
                                fontFamily: "Montserrat"
                            ),
                          )
                        ],

                      )
                    ],
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
      bottomNavigationBar:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
                child: GestureDetector(
                  onTap:()async
                  {
                    final account = await http.post(
                      'https://dentistastore.azurewebsites.net/LogIn',
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                      },
                      body: json.encode({
                        'email': email,
                        'password': password
                      }),
                    );
                    String AccountType = account.body;

                    if(AccountType == "Dentist")
                    {
                      SuccessfulSignIn(AccountType);
                      final getdata = await http.post(
                        'https://dentistastore.azurewebsites.net/GetData',
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: json.encode({
                          'email': email,
                          'AccountType': 'Dentist'
                        }),
                      );


                      final result = json.decode(getdata.body);;

                      String fname = result['fname'];
                      String lname = result['lname'];





                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>(DentistHome(fname, lname, email))));
                    }
                    else if (AccountType == "Delivery")
                    {
                      final statusresponse = await http.post(
                        'https://dentistastore.azurewebsites.net/delivery_getdeliverystatus',
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: json.encode(
                            {'email': email}),
                      );
                      String status = statusresponse.body;

                      if (status=="Accepted")
                      {
                        SuccessfulSignIn(AccountType);
                        final getdata = await http.post(
                          'https://dentistastore.azurewebsites.net/GetData',
                          headers: <String,String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body: json.encode({
                            'email':email,
                            'AccountType':'Delivery'
                          }),
                        );
                        final AcountData = json.decode(getdata.body);
                        authController.setID(AcountData['id']);
                        authController.setAccountType('Delivery');
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>(DeliveryHome())));
                          }
                        else{
                          Alert(context, "Request Status", "Your sign up request is "+ status,message2: "");
                        }



                    }
                      else if (AccountType == "Store")
                      {


                        final statusresponse = await http.post(
                          'https://dentistastore.azurewebsites.net/StoreStatus',
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body: json.encode(
                              {'email': email}),
                        );
                        String status = statusresponse.body;
                        if (status=="Accepted") {
                          SuccessfulSignIn(AccountType);
                          final getdata = await http.post(
                            'https://dentistastore.azurewebsites.net/GetData',
                            headers: <String, String>{
                              'Content-Type': 'application/json; charset=UTF-8',
                            },
                            body: json.encode({
                              'email': email,
                              'AccountType': 'Store'
                            }),
                          );

                          final AcountData = json.decode(getdata.body);
                          String store_name = AcountData['Store_Name'];
                          String id = AcountData['STORE_ID'].toString();
                          authController.setStoreID(id);
                          authController.setEmail(email);
                          authController.setStoreName(store_name);
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context) => (StoreHome())));
                        } else{
                          Alert(context, "Request Status", "Your sign up request is "+ status,message2: "");
                        }

                    }
                    else if (AccountType == "Manager")
                    {
                      SuccessfulSignIn(AccountType);
                      final getdata = await http.post(
                        'https://dentistastore.azurewebsites.net/GetData',
                        headers: <String,String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: json.encode({
                          'email':email,
                          'AccountType':'Manager'
                        }),
                      );
                      final AcountData = json.decode(getdata.body);
                      authController.setID(AcountData['M_ID']);

                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ManagerHome()));
                    }
                    else
                    {
                      Alert(context, "Log in Failed", "This is an invalid email or account", message2: "Please Try again");
                    }
                    //setSharedpref();
                    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TempHome()));
                  },

                  child: drawButton("Sign in", Colors.blueGrey[800]),
                )),
            SizedBox(width: 2),
            Expanded(
              child: GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainScreen()));
                },
                child: drawButton("Create Account", Colors.blueGrey[200]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
