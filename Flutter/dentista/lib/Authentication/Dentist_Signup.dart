//import 'dart:html';
import 'dart:convert';
import 'package:dentista/Authentication/EmailConfirmation.dart';
import 'package:dentista/Screens_Handler/mainscreen.dart';
import 'package:dentista/main.dart';
import 'package:http/http.dart' as http;
import 'package:dentista/Models/AuthButtons.dart';
import 'package:dentista/Models/AuthenticationFields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:credit_card_number_validator/credit_card_number_validator.dart';
import 'package:dentista/Auth/Validations.dart';
import 'package:dentista/Models/Alerts.dart';






class DentistSignup extends StatefulWidget {
  @override
  _DentistSignupState createState() => _DentistSignupState();
}




class _DentistSignupState extends State<DentistSignup> {

  final _formKey = GlobalKey<FormState>();  // Used to validating the form
  Validator _validator = new Validator();   // Creating Instance of the validator
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
  int ExpirationMonth;
  int ExpirationYear;
  int CVV;
  bool valid_email = true;

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
                        validator: (val){ return _validator.validate_name(val) == false ? "Please Enter Your FirstName ": null;},
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        decoration: authDecoration("Last Name"),
                        onChanged: (val){
                          setState(() {
                            lname = val;
                          });
                        },
                        validator: (val){return _validator.validate_name(val) == false ? "Please Enter Your LastName ": null;},
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        decoration: authDecoration("Email"),
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                        validator: (val){
                          return val.isEmpty ? "Enter a valid Email" : null;
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
                        validator: (val){return _validator.validate_password(val) == false ? "Invalid Password" : null;},
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
                        validator: (val){return _validator.credit_card_valid(val) == false ? "Enter a valid Credit Card Number": null;},
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Expanded(child: TextFormField(
                            decoration: authDecoration("Expiration Month"),
                            onChanged: (val){
                              setState(() {
                                ExpirationMonth = int.parse(val);
                              });
                            },
                            validator: (val) {return val.isEmpty ? "*required":null;},
                          )
                          ),
                          Expanded(child: TextFormField(
                            decoration: authDecoration("Expiration Year"),
                            onChanged: (val){
                              setState(() {
                                ExpirationYear = int.parse(val);
                              });
                            },
                            validator: (val) {return val.isEmpty ? "*required": null;},
                          )
                          ),

                        ],
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        decoration: authDecoration("CVV"),
                        onChanged: (val){
                          setState(() {
                            CVV = int.parse(val);
                          });
                        },
                        validator: (val) {return val.isEmpty ? "*required": null;},
                      ),

                      SizedBox(height: 20,),
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
                          Checkbox(
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
                          Text("I confirm that I have read Dentista \n User of Agreement and Privacy Policy",
                            style: TextStyle(
                                fontSize: 13.0,
                                fontFamily: "Montserrat"
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
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

                        final email_response = await http.post(
                          'https://dentistastore.azurewebsites.net/dentist_email_validation',
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body: json.encode({


                            'email': email,

                          }),
                        );

                        final phone_response = await http.post(
                          'https://dentistastore.azurewebsites.net/dentist_phone_validation',
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body: json.encode({


                            'phone': phone_number,

                          }),
                        );

                        final creditcard_validator = await http.post(
                          'https://dentistastore.azurewebsites.net/dentist_creditcard_validation',
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body: json.encode({
                            'CardNumber': CreditCardNumber,
                            'CardEMonth': ExpirationMonth,
                            'CardEYear': ExpirationYear,
                            'CardCVV': CVV
                          }),
                        );


                        String ValidationEmail = email_response.body;
                        String ValidationPhone = phone_response.body;
                        String ValidationCreditCard = creditcard_validator.body;

                        if (ValidationEmail == "0")
                        {
                          valid_email = false;
                          //EmailAlert(context);
                          Alert(context, "Invalid Email", "This Email is currently in use");
                        }
                        else if (ValidationPhone == "0")
                          {
                            Alert(context, "Invalid Phone number", "This Phone number is currently in use");
                          }
                        else if (ValidationCreditCard == "0")
                          {
                            Alert(context, "Invalid Credit Card", "This Credit Card doesn't exist", message2: "Enter a Valid One");
                          }
                        else
                        {
                          valid_email = true;
                          // Sending to Database
                          final response = await http.post(
                            'https://dentistastore.azurewebsites.net/dentist_signup',
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
                          Alert(context, "Signed up successfully", "Press ok to complete the verification", message2: "");
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(builder: (context)=>EmailConfirmation()));
                        }
                      }
                    }:null,
                    child: drawButton("Register", btn_color),
                  ),
                ),
                SizedBox(width: 2),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context)=>MainScreen()));
                    },
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
