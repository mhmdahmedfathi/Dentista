import 'dart:async';
import 'dart:ui';
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
import 'package:flutter/material.dart';
import 'dart:math';

class EmailConfirmation extends StatefulWidget {
  final String FieldName;
  final String Email;
  EmailConfirmation(this.FieldName,this.Email);
  @override
  _EmailConfirmationState createState() => _EmailConfirmationState();

}

class _EmailConfirmationState extends State<EmailConfirmation> {
  final _formKey = GlobalKey<FormState>(); // Used to validating the form
  final random =new Random();
  int CODEoutput ;
  int _counter = 60;
  bool count = false;
  bool start = true;

  Timer _timer;
  int inputcode;
  void Randomizor()
  {
    inputcode(int min, int max) => 100000 + random.nextInt(899999);
  _counter =60;
  }
  void starttimer(){
   _counter = 60;
   _timer =new Timer.periodic(Duration(seconds: 1), (timer) {
     if(_counter>0) {
       setState(() {
         _counter--;
       });
     }else{
        _timer.cancel();
        count=true;
     }
   });

 }

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
                    "Let's",
                    style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat"),
                  ),
                  Row(
                    children: [
                      Text(
                        "Verify email",
                        style: TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        ".",
                        style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                    ],
                  )
                ],
              ),
            )),
        Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
             new Text('$_counter',
              style:TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 48,

              )
              )
            ],
          )
        ),
        Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 30, right: 30, top: 20),
              child: SingleChildScrollView(
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: authDecoration("Code"),
                            onChanged: (val) {
                              setState(() {
                                CODEoutput = int.parse(val);
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
                  onTap:start? () async {
                   Randomizor();
                   starttimer();
                   start=false;
                  }:null,
                  child: drawButton("Send Code", Colors.green),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    if (inputcode == CODEoutput) {
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
                  onTap: count? () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => StoreSignUp()));
                  }:null,
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
