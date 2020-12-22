import 'package:dentista/Models/AuthButtons.dart';
import 'package:dentista/Models/AuthenticationFields.dart';
import 'package:dentista/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoreSignUp extends StatefulWidget {
  @override
  _StoreSignUpState createState() => _StoreSignUpState();
}

class _StoreSignUpState extends State<StoreSignUp> {
  final _formKey = GlobalKey<FormState>(); // Used to validating the form
  //Variables to be sent to the backend
  String StoreName = "";
  String PhoneNumber = "";
  String CreditCardNumber = "";
  String Email = "";
  String Password = "";
  String RePassword = "";
  String Address = "";
  String City = "";
  String Region = "";
  String ZIP ="" ;


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
                            decoration: authDecoration("Store Name"),
                            onChanged: (val) {
                              setState(() {
                                StoreName = val;
                              });
                            },
                            validator: (val) {
                              return val.isEmpty
                                  ? "Please Enter Your Store Name"
                                  : null;
                            },
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            decoration: authDecoration("Phone Number"),
                            onChanged: (val) {
                              setState(() {
                                PhoneNumber = val;
                              });
                            },
                            validator: (val) {
                              return val.isEmpty ? "Please Enter Store Phone Number" : null;
                            },
                          ),
                          SizedBox(height: 20),
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
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  decoration: authDecoration("City"),
                                  onChanged: (val) {
                                    setState(() {
                                      City = val;
                                    });
                                  },
                                  validator: (val) {
                                    if (val.isEmpty)
                                      return "Please Enter Your \n City";
                                    else
                                      return null;
                                  },
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                  child: TextFormField(
                                    decoration: authDecoration("Region"),
                                    onChanged: (val) {
                                      setState(() {
                                        Region = val;
                                      });
                                    },
                                    validator: (val) {
                                      return val.isEmpty
                                          ? "Please Enter Your \n Region"
                                          : null;
                                    },
                                  ))
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  decoration: authDecoration("Address"),
                                  onChanged: (val) {
                                    setState(() {
                                      Address = val;
                                    });
                                  },
                                  validator: (val) {
                                    if (val.isEmpty)
                                      return "Please Enter Your \n Address";
                                    else
                                      return null;
                                  },
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                  child: TextFormField(
                                    decoration: authDecoration("ZIP Code"),
                                    onChanged: (val) {
                                      setState(() {
                                        ZIP = val;
                                      });
                                    },
                                    validator: (val) {
                                      return val.isEmpty
                                          ? "Please Enter Your \n ZIP Code"
                                          : null;
                                    },
                                  ))
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
