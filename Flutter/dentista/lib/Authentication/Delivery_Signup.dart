import 'dart:convert';
import 'package:dentista/Models/AuthButtons.dart';
import 'package:dentista/Models/AuthenticationFields.dart';
import 'package:dentista/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dentista/Auth/Validations.dart';
import 'package:dentista/Models/Alerts.dart';
import 'package:credit_card_number_validator/credit_card_number_validator.dart';
import 'package:dentista/Screens_Handler/mainscreen.dart';

import 'EmailConfirmation.dart';

class DeliverySignUp extends StatefulWidget {
  @override
  _DeliverySignUpState createState() => _DeliverySignUpState();
}

class _DeliverySignUpState extends State<DeliverySignUp> {

  final _formKey = GlobalKey<FormState>(); // Used to validating the form
  Validator _validator =
      new Validator(); //Use this to validate Name, Credit card, Password
  //Variables to be sent to the backend
  String FirstName = "";
  String LastName = "";
  String Area = "";
  String CreditCardNumber = "";
  String PhoneNumber = "";
  int ExpirationMonth;
  int ExpirationYear;
  int CVV;
  String VehicleLicence = "";
  String VehicleModel = "";
  String Email = "";
  String Password = "";
  String RePassword = "";
  bool valid_email = true;
  bool policy_check = false;
  Color btn_color = Colors.blueGrey[200];

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
                    fontSize: 60.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat"),
              ),
              Row(
                children: [
                  Text(
                    "Delivery",
                    style: TextStyle(
                        fontSize: 60.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat"),
                  ),
                  Text(
                    ".",
                    style: TextStyle(
                        fontSize: 90.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[800]
                    ),
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
                    decoration: authDecoration("First Name",icon: Icons.group_rounded),
                    onChanged: (val) {
                      setState(() {
                        FirstName = val;
                      });
                    },
                    validator: (val) {
                      return val.isEmpty
                          ? "Please Enter Your First Name"
                          : _validator.validate_name(val)
                              ? null
                              : "Enter a valid name";
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: authDecoration("Last Name",icon: Icons.group_outlined),
                    onChanged: (val) {
                      setState(() {
                        LastName = val;
                      });
                    },
                    validator: (val) {
                      return val.isEmpty
                          ? "Please Enter Your Last Name"
                          : _validator.validate_name(val)
                              ? null
                              : "Enter a valid name";
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: authDecoration("Email"),
                    onChanged: (val) {
                      setState(() {
                        Email = val;
                      });
                    },
                    validator: (val) {
                      return val.isEmpty ? "Please Enter Your Email" : null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    obscureText: true,
                    decoration: authDecoration("Password",icon: Icons.lock),
                    onChanged: (val) {
                      setState(() {
                        Password = val;
                      });
                    },
                    validator: (val) {
                      return val.isEmpty
                          ? "Please Enter Your Password"
                          : _validator.validate_password(val)
                              ? null
                              : "Enter a valid Password";
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    obscureText: true,
                    decoration: authDecoration("Re-Enter Password",icon: Icons.lock),
                    onChanged: (val) {
                      setState(() {
                        RePassword = val;
                      });
                    },
                    validator: (val) {
                      return val != Password
                          ? "The Password doesn't match"
                          : null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: authDecoration("Phone Number",icon: Icons.phone_android),
                    onChanged: (val) {
                      setState(() {
                        PhoneNumber = val;
                      });
                    },
                    validator: (val) {
                      return PhoneNumber.length != 11
                          ? "Invalid phone number"
                          : null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: authDecoration("Credit Card Number",icon: Icons.credit_card),
                    onChanged: (val) {
                      setState(() {
                        CreditCardNumber = val;
                      });
                    },
                    validator: (val) {
                      return val.isEmpty
                          ? "Please Enter Your Credit Card Number"
                          : _validator.credit_card_valid(val)
                              ? null
                              : "Enter a valid Credit Card Number";
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                        decoration: authDecoration("Expiration\nMonth",icon: Icons.calendar_today_sharp),
                        onChanged: (val) {
                          setState(() {
                            ExpirationMonth = int.parse(val);
                          });
                        },
                        validator: (val) {
                          return val.isEmpty ? "*required" : null;
                        },
                      )),
                      Expanded(
                          child: TextFormField(
                        decoration: authDecoration("Expiration\nYear",icon: Icons.calendar_today_sharp),
                        onChanged: (val) {
                          setState(() {
                            ExpirationYear = int.parse(val);
                          });
                        },
                        validator: (val) {
                          return val.isEmpty ? "*required" : null;
                        },
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: authDecoration("CVV",icon: Icons.credit_card),
                    onChanged: (val) {
                      setState(() {
                        CVV = int.parse(val);
                      });
                    },
                    validator: (val) {
                      return val.isEmpty ? "*required" : null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: authDecoration("Area",icon: Icons.location_on),
                    onChanged: (val) {
                      setState(() {
                        Area = val;
                      });
                    },
                    validator: (val) {
                      return val.isEmpty ? "Please Enter Your Area" : null;
                    },
                  ),
                  SizedBox(height: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Vehicle Information",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontFamily: "Montserrat"),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: authDecoration("Vehicle License",icon: Icons.card_membership),
                              onChanged: (val) {
                                setState(() {
                                  VehicleLicence = val;
                                });
                              },
                              validator: (val) {
                                if (val.isEmpty)
                                  return "Please Enter Your \n Vehicle Licence";
                                else if (val.length < 8)
                                  return "   Enter a Valid \n Vehicle Licence";
                                else
                                  return null;
                              },
                            ),
                          ),
                          Expanded(
                              child: TextFormField(
                            decoration: authDecoration("Vehicle Model",icon: Icons.local_shipping),
                            onChanged: (val) {
                              setState(() {
                                VehicleModel = val;
                              });
                            },
                            validator: (val) {
                              return val.isEmpty
                                  ? "Please Enter Your \n    Vehicle Model"
                                  : null;
                            },
                          ))
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Checkbox(
                              value: policy_check,
                              onChanged: (val) {
                                setState(() {
                                  policy_check = val;
                                  if (policy_check)
                                    btn_color = Colors.blueGrey[800];
                                  else
                                    btn_color = Colors.blueGrey[200];
                                });
                              },
                            ),
                          ),
                          Text(
                            "    I confirm that I have read Dentista \n User of Agreement and Privacy Policy",
                            style: TextStyle(
                                fontSize: 13, fontFamily: "Montserrat"),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                  child: GestureDetector(
                onTap: policy_check
                    ? () async {
                        //if condition to check if the all inputs are valid
                        if (_formKey.currentState.validate()) {
                          ////////////////////////////////////////////////
                          final email_response = await http.post(
                              'http://10.0.2.2:5000/delivery_email_validation',
                              headers: <String, String>{
                                'Content-Type':
                                    'application/json; charset=UTF-8',
                              },
                              body: json.encode({
                                'email': Email,
                              }));
                          ////////////////////////////////////////////////
                          final phonenumber_validator = await http.post(
                              'http://10.0.2.2:5000/delivery_phone_validation',
                              headers: <String, String>{
                                'Content-Type':
                                    'application/json; charset=UTF-8',
                              },
                              body: json.encode({
                                'phone': PhoneNumber,
                              }));

                          ////////////////////////////////////////////////
                          final creditcard_validator = await http.post(
                              'http://10.0.2.2:5000/delivery_creditcard_validation',
                              headers: <String, String>{
                                'Content-Type':
                                    'application/json; charset=UTF-8',
                              },
                              body: json.encode({
                                'CardNumber': CreditCardNumber,
                                'CardEMonth': ExpirationMonth,
                                'CardEYear': ExpirationYear,
                                'CardCVV': CVV
                              }));
                          ////////////////////////////////////////////////
                          final license_validation = await http.post(
                              'http://10.0.2.2:5000/delivery_license_validation',
                              headers: <String, String>{
                                'Content-Type':
                                    'application/json; charset=UTF-8',
                              },
                              body: json.encode({'license': VehicleLicence}));
                          ////////////////////////////////////////////////
                          String ValidationEmail = email_response.body;
                          String ValidationCreditCard =
                              creditcard_validator.body;
                          String validationPhoneNumber =
                              phonenumber_validator.body;
                          String validationVehicleLicense =
                              license_validation.body;
                          if (ValidationEmail == "0") {
                            valid_email = false;
                            Alert(context, "Invalid Email",
                                "This Email is currently in use");
                          }
                          else if (validationVehicleLicense == "0") {
                            Alert(context, "Invalid License number",
                                "This License number is currently in use");
                          }
                          else if (validationPhoneNumber == "0") {
                            Alert(context, "Invalid Phone number",
                                "This Phone number is currently in use");
                          } else if (ValidationCreditCard == "0") {
                            Alert(context, "Invalid Credit Card",
                                "This Credit Card doesn't exist",
                                message2: "Enter a Valid One");
                          } else {
                            valid_email = true;
                            // Sending to Database
                            final response = await http.post(
                                'http://10.0.2.2:5000/delivery_signup',
                                headers: <String, String>{
                                  'Content-Type':
                                      'application/json; charset=UTF-8',
                                },
                                body: json.encode({
                                  'DELIVERY_Fname': FirstName,
                                  'DELIVERY_Lname': LastName,
                                  'DELIVERY_EMAIL': Email,
                                  'DELIVERY_PASSWORD': Password,
                                  'DELIVERY_CREDIT_CARD_NUMBER':
                                      CreditCardNumber,
                                  'AREA': Area,
                                  'VECHILE_LICENCE': VehicleLicence,
                                  'VECHILE_MODEL': VehicleModel,
                                  'Delivery_PHONE_NUMBER': PhoneNumber,
                                }));
                            Alert(context, "Signed up successfully",
                                "Press ok to complete the verification",
                                message2: "");

                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(builder: (context)=>EmailConfirmation()));
                          }
                        }
                      }
                    : null,
                child: drawButton("Register", btn_color),
              )),
              SizedBox(width: 2.0),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MainScreen()));
                  },
                  child: drawButton("Back to sign in", Colors.blueGrey[200]),
                ),
              )
            ],
          ),
        )
      ],
    ));
  }
}
