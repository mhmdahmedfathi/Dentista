//import 'dart:html';
import 'dart:convert';
import 'package:dentista/main.dart';
import 'package:http/http.dart' as http;
import 'package:dentista/Models/AuthButtons.dart';
import 'package:dentista/Models/AuthenticationFields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:credit_card_number_validator/credit_card_number_validator.dart';
import 'package:dentista/Auth/Validations.dart';
import 'package:dentista/Models/Alerts.dart';






class AddItem extends StatefulWidget {
  final String ID;
  AddItem(this.ID);
  @override
  _AddItemState createState() => _AddItemState(ID);
}




class _AddItemState extends State<AddItem> {

  final _formKey = GlobalKey<FormState>();  // Used to validating the form
  Validator _validator = new Validator();   // Creating Instance of the validator
  String Product_Name="";
  String No_Of_Units="";
  String ID = "";
  _AddItemState( this.ID);

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
                    Row(
                      children: [
                        Text(
                          "Add Item",
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
                          decoration: authDecoration("Product Name"),
                          onChanged: (val){
                            setState(() {
                              Product_Name = val;
                            });
                          },
                          validator: (val){ return _validator.validate_name(val) == false ? "Please Enter Product Name ": null;},
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          decoration: authDecoration("Number of Units"),
                          onChanged: (val) {
                            setState(() {
                              No_Of_Units = val;
                            });
                          },
                          validator: (val){
                            return val.isEmpty ? "Enter a valid number" : null;
                          },
                        )
                        ,
                        SizedBox(height: 20,),
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
                      onTap:  () async{
                        if(_formKey.currentState.validate())
                        {

                          final email_response = await http.post(
                            'http://10.0.2.2:5000/dentist_email_validation',
                            headers: <String, String>{
                              'Content-Type': 'application/json; charset=UTF-8',
                            },
                            body: json.encode({


                              'email': Product_Name,

                            }),
                          );

                          String ValidationEmail = email_response.body;

                            // Sending to Database
                            final response = await http.post(
                              'http://10.0.2.2:5000/dentist_signup',
                              headers: <String, String>{
                                'Content-Type': 'application/json; charset=UTF-8',
                              },
                              body: json.encode({

                                'DENTIST_Fname': ID,
                                'DENTIST_LNAME': Product_Name,
                                'DENTIST_EMAIL': No_Of_Units,
                              }),
                            );
                            Alert(context, "Signed up successfully", "Press ok to complete the verification", message2: "");
                          }

                      },
                      child: drawButton("Register", Colors.grey),
                    ),
                  ),
                  SizedBox(width: 2),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context)=>Home()));
                      },
                      child: drawButton("Back to Store Home", Colors.grey),
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
