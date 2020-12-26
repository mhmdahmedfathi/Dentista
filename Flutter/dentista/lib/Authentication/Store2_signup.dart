import 'package:dentista/Models/AuthButtons.dart';
import 'package:dentista/Models/AuthenticationFields.dart';
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
  TextEditingController _formsController = TextEditingController();
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
                      controller:  _formsController,
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
                    SizedBox(height: 20.0),
                    TextFormField(
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
                    SizedBox(height: 20),
                    TextFormField(
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
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  _formsController.clear();
                },
                child: drawButton("Add new bransh", Colors.green),
              ),
            ),
            SizedBox(width: 2.0),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => StoreSignUp()));
              },
              child: drawButton("Back to Prev page", Colors.grey),
            ),
            SizedBox(width: 2.0),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 12, right: 12, bottom: 12),
        child: GestureDetector(
          onTap: () async {
            if (_formKey.currentState.validate()) {
              final City_response = await http.post(
                'http://10.0.2.2:5000/Store_CITY_validation',
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                },
                body: json.encode({
                  'CITY': City,
                }),
              );

              final Address_response = await http.post(
                'http://10.0.2.2:5000/Store_ADDRESS_Validation',
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                },
                body: json.encode({
                  'ADDRESS': Address,
                }),
              );

              final ZIP_response = await http.post(
                'http://10.0.2.2:5000/Store_ZIP_validation',
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                },
                body: json.encode({
                  'ZIP': zip,
                }),
              );

              final Region_validator = await http.post(
                'http://10.0.2.2:5000/Store_Region_validation',
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                },
                body: json.encode({'REGION': Region}),
              );

              String ValidationRegion = Region_validator.body;
              String ValidationZIP = ZIP_response.body;
              String ValidationAddress = Address_response.body;
              String ValidationCity = City_response.body;

              if (ValidationRegion == "0") {
                //EmailAlert(context);
                Alert(context, "Invalid Region",
                    "Please make sure you type it correctly");
              } else if (ValidationZIP == "0") {
                Alert(context, "Invalid ZIP number",
                    "Please make sure you type it correctly");
              } else if (ValidationAddress == "0") {
                Alert(context, "Invalid Address",
                    "Please make sure you type it correctly");
              } else if (ValidationCity == "0") {
                Alert(context, "Invalid City",
                    "Please make sure you type it correctly");
              } else {
                // Sending to Database
                final response = await http.post(
                  'http://10.0.2.2:5000/Store2_signup',
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: json.encode({
                    'Store_Name': widget.StoreName,
                    'ADDRESS': Address,
                    'REGION': Region,
                    'CITY': City,
                    'ZIP_CODE': zip
                  }),
                );
                Alert(context, "Signed up successfully",
                    "Press next to continue the verification",
                    message2: "");
              }
            }
          },
          child: drawButton("Sign Up", Colors.green),
        ),
      ),
    ]));
  }
}
