//import 'dart:html';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:dentista/Models/AuthButtons.dart';
import 'package:dentista/Models/AuthenticationFields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dentist
{
  String fname;
  String lname;
  String email;
  String password;
  String repassword;
  String phone_number;
  String address;
  int ZipCode;
  String Region;
  String City;
  String CreditCardNumber;
  String ImageURL;

}



class DentistSignup extends StatefulWidget {
  @override
  _DentistSignupState createState() => _DentistSignupState();
}

bool validate_password(String password)
{
  bool special_character = false;
  bool numbers = false;
  bool capical_character = false;
  bool small_character = false;
  bool password_length = false;
  if (password.length >= 6)
    {
      password_length = true;
    }
  for (int i=0; i < password.length; i++)
    {
      var C = password[i];

      int c_val = password.codeUnitAt(i);
      //print(c_val);
      if (c_val >= 65 && c_val <=90)
        {
          capical_character = true;
        }
      if(c_val >= 97 && c_val <= 122)
        {
          small_character = true;
        }
      if (c_val >= 48 && c_val <= 57)
        {
          numbers = true;
        }
      if (c_val >=58 && c_val <=64)
        {
          special_character = true;
        }
    }
  return special_character && numbers && small_character && capical_character && password_length;
  //return true;
}

class _DentistSignupState extends State<DentistSignup> {

  final _formKey = GlobalKey<FormState>();  // Used to validating the form
  String fname;
  String lname;
  String email;
  String password;
  String repassword;
  String phone_number;
  String address;
  int ZipCode;
  String Region;
  String City;
  String CreditCardNumber;
  String ImageURL;

  bool policy_check = false;

  Color btn_color = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
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
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Montserrat"
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Dentist",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
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
              padding: EdgeInsets.only(left: 30, right: 30, top: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: authDecoration("First Name"),
                        onChanged: (val){
                          setState(() {
                            fname = val;
                          });
                        },
                        validator: (val){ return val.isEmpty ? "Please Enter Your FirstName ": null;},
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        decoration: authDecoration("Last Name"),
                        onChanged: (val){
                          setState(() {
                            lname = val;
                          });
                        },
                        validator: (val){return val.isEmpty ? "Please Enter Your LastName ": null;},
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        decoration: authDecoration("Email"),
                        onChanged: (val){
                          setState(() {
                            email = val;
                          });
                        },
                        validator: (val){
                          return val.isEmpty ? "Enter Your Email" : null;
                        },
                      )
                      ,
                      SizedBox(height: 20,),
                      TextFormField(
                        obscureText: true,
                        decoration: authDecoration("Enter Password"),
                        onChanged: (val){
                          setState(() {
                            password = val;

                          });
                        },
                        validator: (val){return validate_password(val) == false ? "Invalid Password" : null;},
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        obscureText: true,
                        decoration: authDecoration("Re-Enter password"),
                        onChanged: (val){
                          setState(() {
                            repassword = val;
                          });
                        },
                        validator: (val) {return val != password ? "The Password doesn't match" : null;}
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        decoration: authDecoration("Phone Number"),
                        onChanged: (val){
                          setState(() {
                            phone_number = val;
                          });
                        },
                        validator: (val){return phone_number.length!= 11 ? "Invalid phone number": null;},
                      ),

                      SizedBox(height: 20,),
                      TextFormField(
                        decoration: authDecoration("Credit Card Number"),
                        onChanged: (val){setState(() {
                          CreditCardNumber = val;

                        });},
                        validator: (val){return val.isEmpty ? "Enter Credit Card Number": null;},
                      ),
                      TextFormField(
                        decoration: authDecoration("Address"),
                        onChanged: (val){
                          setState(() {
                            address = val;
                          });
                        },
                        validator: (val){return val.isEmpty  ? "Enter Your address" : null;},
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        decoration: authDecoration("ZIP Code"),
                        onChanged: (val){
                          setState(() {
                            ZipCode = int.parse(val);
                          });
                        },
                        validator: (val) {return val.isEmpty ? "Enter Zip Code": null;},
                      ),
                    SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: authDecoration("Region"),
                              onChanged: (val){
                                setState(() {
                                  Region = val;
                                });
                              },
                              validator: (val){return val.isEmpty  ? "Enter Region" : null;},
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration: authDecoration("Enter City"),
                              onChanged: (val){
                                setState(() {
                                  City = val;
                                });
                              },
                              validator: (val) {return val.isEmpty ? "Enter City" : null;},
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Checkbox(
                              onChanged: (bool val) {
                                setState(() {
                                  this.policy_check = val;
                                  if (policy_check == true)
                                    {
                                      btn_color = Colors.green;
                                    }
                                  else
                                    {
                                      btn_color = Colors.grey;
                                    }
                                });
                              },
                              value: this.policy_check,
                            ),
                          ),
                          Text("I confirm that I have read Dentista \n User of Agreement and Privacy Policy",
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
                    onTap: policy_check ? () async{
                      if(_formKey.currentState.validate())
                      {
                        // Sending to Database
                        final response = await http.post(
                          'http://10.0.2.2:5000/',
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body: json.encode({

                            'DENTIST_Fname': fname,
                            'DENTIST_LNAME': lname,
                            'DENTIST_EMAIL': email,
                            'DENTIST_PASSWORD': password,
                            'DENTIST_PHONE_NUMBER': phone_number,
                            'DENTIST_ADDRESS': address,
                            'DENTIST_ZIP_CODE': ZipCode,
                            'DENTIST_REGION': Region,
                            'DENTIST_CITY': City,
                            'DENTIST_CREDIT_CARD_NUMBER': CreditCardNumber
                          }),
                        );



                      }
                    }:null,
                    child: drawButton("Register", btn_color),
                  ),
                ),
                SizedBox(width: 2),
                Expanded(
                  child: GestureDetector(
                    onTap: (){},
                    child: drawButton("Back to sign in", Colors.grey),
                  ),
                ),

              ],
            ),
          )

        ],
      )
    );
  }
}
