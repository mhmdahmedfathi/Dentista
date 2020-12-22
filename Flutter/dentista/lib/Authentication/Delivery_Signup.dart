import 'package:dentista/Models/AuthButtons.dart';
import 'package:dentista/Models/AuthenticationFields.dart';
import 'package:dentista/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeliverySignUp extends StatefulWidget {
  @override
  _DeliverySignUpState createState() => _DeliverySignUpState();
}

class _DeliverySignUpState extends State<DeliverySignUp> {
  final _formKey = GlobalKey<FormState>(); // Used to validating the form
  //Variables to be sent to the backend
  String FirstName = "";
  String LastName = "";
  String Area = "";
  String CreditCardNumber = "";
  String VehicleLicence = "";
  String VehicleModel = "";
  String Email = "";
  String Password = "";
  String RePassword = "";

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
                    ),
                  ),
                  Text(
                    ".",
                    style: TextStyle(
                        fontSize: 90.0,
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
                    decoration: authDecoration("First Name"),
                    onChanged: (val) {
                      setState(() {
                        FirstName = val;
                      });
                    },
                    validator: (val) {
                      return val.isEmpty
                          ? "Please Enter Your First Name"
                          : null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: authDecoration("Last Name"),
                    onChanged: (val) {
                      setState(() {
                        LastName = val;
                      });
                    },
                    validator: (val) {
                      return val.isEmpty ? "Please Enter Your Last Name" : null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: authDecoration("Credit Card Number"),
                    onChanged: (val) {
                      setState(() {
                        CreditCardNumber = val;
                      });
                    },
                    validator: (val) {
                      if (val.isEmpty)
                        return "Please Enter Your Credit Card Number";
                      else if (val.length < 8)
                        return "Enter a Valid Credit Card Number";
                      else
                        return null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: authDecoration("Area"),
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
                  SizedBox(height: 20),
                  TextFormField(
                    obscureText: true,
                    decoration: authDecoration("Password"),
                    onChanged: (val) {
                      setState(() {
                        Password = val;
                      });
                    },
                    validator: (val) {
                      return val.length < 6
                          ? "Password must be more than 6 characters"
                          : null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    obscureText: true,
                    decoration: authDecoration("Re-Enter Password"),
                    onChanged: (val) {
                      setState(() {
                        RePassword = val;
                      });
                    },
                    validator: (val) {
                      if(val.length <6) return "Password must be more than 6 characters" ;
                      return val != Password
                          ? "The Password doesn't match"
                          : null;
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
                              decoration: authDecoration("Vehicle License"),
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
                          SizedBox(width: 10),
                          Expanded(
                              child: TextFormField(
                            decoration: authDecoration("Vehicle Model"),
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
                      )
                    ],
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        )
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  //if condition to check if the all inputs are valid
                  if (_formKey.currentState.validate())
                    {
                      //For Testing only
                      //backend code should be written here

                      print("Done");
                    }
                },
                    child: drawButton(
                      "Register",
                      Colors.green
                    ),
              )
              ),
              SizedBox(width: 2.0),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context)=>Home()));
                  },
                  child: drawButton(
                      "Back to sign in",
                      Colors.grey
                  ),
                ),
              )
            ],
          ),
        )
      ],
    )
    );
  }
}
