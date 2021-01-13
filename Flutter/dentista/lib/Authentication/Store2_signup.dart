import 'package:dentista/Authentication/EmailConfirmation.dart';
import 'package:dentista/Models/AuthButtons.dart';
import 'package:dentista/Models/AuthenticationFields.dart';
import 'package:dentista/Screens_Handler/mainscreen.dart';
import 'package:dentista/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dentista/Authentication/Store_Signup.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dentista/Auth/Validations.dart';
import 'package:dentista/Models/Alerts.dart';

class Store2signup extends StatefulWidget {
  final String StoreName;

  Store2signup(this.StoreName);

  @override
  _Store2signupState createState() => _Store2signupState();
}

class _Store2signupState extends State<Store2signup> {
  TextEditingController _formsController1 = TextEditingController();
  TextEditingController _formsController2 = TextEditingController();
  TextEditingController _formsController3 = TextEditingController();
  TextEditingController _formsController4 = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Used to validating the form
  String zip = "";
  String City = "";
  String Region = "";
  String Address = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      SafeArea(
          child: Container(
        color: Colors.grey[200],
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello",
              style: TextStyle(
                  fontSize: 60.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat"),
            ),
            Row(
              children: [
                Text(
                  "Store Owner",
                  style: TextStyle(
                    fontSize: 60.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ".",
                  style: TextStyle(
                      fontSize: 60.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
              ],
            )
          ],
        ),
      )),
      Expanded(
          child: Container(
        padding: EdgeInsets.only(left: 30, right: 30, top: 20),
        child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                     TextFormField(
                      controller:  _formsController1,
                      decoration: authDecoration("City"),
                      onChanged: (val) {
                        setState(() {
                          City = (val);
                        });
                      },
                      validator: (val) {
                        return val.isEmpty ? "Please Enter Your City" : null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller:  _formsController3,
                      decoration: authDecoration("ZIP Number"),
                      onChanged: (val) {
                        setState(() {
                          zip = (val);
                        });
                      },
                      validator: (val) {
                        if (val.isEmpty)
                          return "Please Enter Your ZIP Number";
                        else
                          return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller:  _formsController2,
                      decoration: authDecoration("Region"),
                      onChanged: (val) {
                        setState(() {
                          Region = (val);
                        });
                      },
                      validator: (val) {
                        return val.isEmpty ? "Please Enter Region" : null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller:  _formsController4,
                      decoration: authDecoration("Address"),
                      onChanged: (val) {
                        setState(() {
                          Address = (val);
                        });
                      },
                      validator: (val) {
                        return val.isEmpty ? "Please Enter Your Address" : null;
                      },
                    ),
                  ],
                ))),
      )),
      Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  if (_formKey.currentState.validate()) {
                    // Sending to Database
                    final response = await http.post(
                      'http://10.0.2.2:5000/Store2_signup',
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                      },
                      body: json.encode({
                        'STORE_ID': widget.StoreName,
                        'ADDRESS': Address,
                        'REGION': Region,
                        'CITY': City,
                        'ZIP_CODE': zip
                      }),
                    );
                    Alert(context, "Request sent to Mangers successfully",
                        "Press ok ",
                        message2: "");

                  }
                  _formsController1.clear();
                  _formsController2.clear();
                  _formsController3.clear();
                  _formsController4.clear();
                },
                child: drawButton("Add another bransh", Colors.grey),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => StoreSignUp()));
              },
              child: drawButton("Back to Prev page", Colors.grey),
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
        child: GestureDetector(
          onTap: () async {
            if (_formKey.currentState.validate()) {
                // Sending to Database
                final response = await http.post(
                  'http://10.0.2.2:5000/Store2_signup',
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: json.encode({
                    'STORE_ID': widget.StoreName,
                    'ADDRESS': Address,
                    'REGION': Region,
                    'CITY': City,
                    'ZIP_CODE': zip
                  }),
                );
                //Navigator.of(context).push(
                  //  MaterialPageRoute(builder: (context) => MainScreen()));

                Alert(context, "Signed up successfully",
                    "Press ok to complete the verification",
                    message2: "");
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context)=>EmailConfirmation()));
            }
          },
          child: drawButton("Sign Up", Colors.grey),

        ),
      ),
        ]));
  }
}
