import 'dart:convert';

import 'package:dentista/Models/AuthButtons.dart';
import 'package:dentista/Models/AuthenticationFields.dart';
import 'package:dentista/Screens_Handler/Temp_Home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:dentista/Dentist_Screens/Dentist_Home.dart';
import 'package:dentista/Models/Alerts.dart';
class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  Future setSharedpref() async
  {
    //Shared Prefrences is used as a local database for each app user
    //we store boolen value indicates whether the user is logged in or not
    //to decide which screen that he should view
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('loggedin', true);
  }
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool rememberme = false;
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
                            color: Colors.green
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
                        decoration: authDecoration("Last Name"),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap:()async
                      {
                        final account = await http.post(
                          'http://10.0.2.2:5000/LogIn',
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
                            setSharedpref();
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>(DentistHome())));
                          }
                        else if (AccountType == "Delivery")
                          {

                          }
                        else if (AccountType == "Store")
                          {

                          }
                        else if (AccountType == "Manager")
                          {

                          }
                        else
                          {
                            Alert(context, "Log in Failed", "This is an invalid email or account", message2: "Please Try again");
                          }
                        //setSharedpref();
                        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TempHome()));
                      },
                    child: drawButton("Sign in", Colors.green),
                  ),
                ),
                SizedBox(width: 2),
                Expanded(
                  child: GestureDetector(
                    onTap: (){},
                    child: drawButton("Create Account", Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
