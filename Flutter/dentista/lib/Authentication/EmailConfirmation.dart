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

class EmailConfirmation extends StatefulWidget {
  final String FieldName;
  EmailConfirmation(this.FieldName);
  @override
  _EmailConfirmationState createState() => _EmailConfirmationState();
}

class _EmailConfirmationState extends State<EmailConfirmation> {
  final _formKey = GlobalKey<FormState>(); // Used to validating the form
  String CODEinput = "";
  String CODEoutput = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(children:[
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
                        "Verifying email",
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
                            decoration: authDecoration("City"),
                            onChanged: (val) {
                              setState(() {
                                CODEoutput = (val);
                              });
                            },
                            validator: (val) {
                              return val.isEmpty ? "Please Enter the right code" : null;
                            },
                          ),
                          SizedBox(height: 20)
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
                        'http://10.0.2.2:5000/Email_Confirmation',
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: json.encode({
                        }),
                      );
                      Alert(context, "Email has been Signed up successfully",
                          "Press ok ",
                          message2: "");
                      }
                    },
                  child: drawButton("Submit Code", Colors.green),
                ),
    ),
    GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => StoreSignUp()));
                  },
                  child: drawButton("Resend Code", Colors.grey),
                ),
            ],
          ),
        ),

      ]
    )
    );
  }
}
