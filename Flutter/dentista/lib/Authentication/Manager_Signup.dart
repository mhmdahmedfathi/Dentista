import 'dart:convert';
import 'package:get/get.dart';
import 'package:dentista/Auth/Validations.dart';
import 'package:dentista/Authentication/AuthController.dart';
import 'package:dentista/Authentication/EmailConfirmation.dart';
import 'package:dentista/Models/Alerts.dart';
import 'package:dentista/Models/AuthButtons.dart';
import 'package:dentista/Models/AuthenticationFields.dart';
import 'package:dentista/Screens_Handler/mainscreen.dart';
import 'package:dentista/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ManagerSignup extends StatefulWidget {
  @override
  _ManagerSignupState createState() => _ManagerSignupState();
}

class _ManagerSignupState extends State<ManagerSignup> {
  final _formKey = GlobalKey<FormState>();  // Used to validating the form
  final _validator = Validator();
  //Variables to be sent to the backend 
  String firstName ='';
  String lastName ='';
  String email ='';
  String password ='';
  String repassword ='';
  String manageType ='';
  String manageArea ='';
  ////////////////////////////////////
  bool policy_check = false;
final AuthController authController = Get.put(AuthController());
  Color btn_color = Colors.blueGrey[200];
  List<String> managementType = ["Store" , "Delivery"];
 
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
                  Text(
                    "Hello",
                    style: TextStyle(
                      fontSize: 60.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Montserrat"
                    ),
                  ),
                  Row(
                    children: [
                      Text("Manager" ,
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
                            color: Colors.blueGrey[800]
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
                        decoration: authDecoration("First Name",icon: Icons.group_rounded),
                        onChanged: (val){
                          setState(() {
                            firstName = val;
                          });
                        },
                        validator: (val)
                        {
                           return _validator.validate_name(val)==false ? "Please Enter Your FirstName" : null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                          decoration: authDecoration("Last Name",icon: Icons.group_outlined),
                        onChanged: (val){
                          setState(() {
                            lastName = val;
                          });
                        },
                        validator: (val)
                        {
                          return _validator.validate_name(val)==false ? "Please Enter Your LastName" : null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: authDecoration("Email",icon: Icons.email_rounded),
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
                        obscureText: true,
                        decoration: authDecoration("Password",icon: Icons.lock),
                        onChanged: (val){
                          setState(() {
                            password = val;
                          });
                        },
                        validator: (val)
                        {
                          return _validator.validate_password(val)==false ? "Password must be more than 6 characters" : null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        obscureText: true,
                        decoration: authDecoration("Re-Enter Password",icon: Icons.lock),
                        onChanged: (val){
                          setState(() {
                            repassword = val;
                          });
                        },
                        validator: (val)
                        {
                          return val != password ? "The Password doesn't match" : null;
                        },
                      ),

                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField(
                              decoration: authDecoration("Management Type",icon: Icons.title),
                              items: managementType.map((typ){
                                return DropdownMenuItem(
                                  value: typ,
                                  child: Text(typ),
                                );
                              }).toList(),
                              onChanged: (val){
                                manageType = val;
                              },
                              validator: (val)
                              {
                                return val==null ? "Please Choose Type" : null;
                              },
                            ),
                            flex: 2,
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration: authDecoration("Area",icon: Icons.location_on),
                              onChanged: (val){
                                setState(() {
                                  manageArea = val;
                                });
                              },
                              validator: (val)
                              {
                                return val.isEmpty ? "Enter Area" : null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Checkbox(
                            activeColor: Colors.blueGrey[800],
                            onChanged: (bool val) {
                              setState(() {
                                this.policy_check = val;
                                if (policy_check == true)
                                {
                                  btn_color = Colors.blueGrey[800];
                                }
                                else
                                {
                                  btn_color = Colors.blueGrey[200];
                                }
                              });
                            },
                            value: this.policy_check,
                          ),
                          Text("I confirm that I have read Dentista \n User of Agreement and Privacy Policy",
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Montserrat"
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20,)
                    ],
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
      bottomNavigationBar:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap:policy_check ? ()async {
                  //if condition to check if the all inputs are valid
                  if(_formKey.currentState.validate())
                  {

                    final email_response = await http.post('http://10.0.2.2:5000/manager_email_validation',
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                      },
                      body: json.encode({
                        'email': email,
                      }),
                    );
                    String ValidationEmail = email_response.body;
                    if (ValidationEmail == "0")
                    {
                      Alert(context, "Invalid Email", "This Email is currently in use");
                    }else
                    {
                      final response = http.post('http://10.0.2.2:5000/manager_signup',
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },

                          body:  json.encode({
                            'MANAGER_Fname' : firstName ,
                            'MANAGER_Lname' : lastName ,
                            'MANAGER_EMAIL' : email ,
                            'MANAGER_PASSWORD' : password ,
                            'MANAGEMENT_TYPE' : manageType ,
                            'AREA_OF_MANAGEMENT' : manageArea
                          })
                      );
                      Alert(context, "Signed up successfully", "Press ok to complete the verification", message2: "");
                      authController.setEmail(email);
                      authController.setAccountType('Manager');
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
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainScreen()));
                },
                child: drawButton("Back to sign in", Colors.blueGrey[200]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
