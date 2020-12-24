import 'package:dentista/Authentication/Delivery_Signup.dart';
import 'package:dentista/Authentication/Dentist_Signup.dart';
import 'package:dentista/Authentication/Manager_Signup.dart';
import 'package:dentista/Authentication/Signin.dart';
import 'package:dentista/Authentication/Store_Signup.dart';
import 'package:dentista/Models/AuthButtons.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context)=>DentistSignup()));
            },
            child: drawButton("Dentist Sign-Up Form", Colors.green),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context)=>DeliverySignUp()));
            },
            child: drawButton("Delivery Sign-Up Form", Colors.green),

          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context)=>StoreSignUp()));
            },
            child: drawButton("Store Sign-Up Form", Colors.green),

          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context)=>ManagerSignup()));
            },
            child: drawButton("Manager Sign-Up Form", Colors.green),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context)=>SignIn()));
            },
            child: drawButton("Sign In", Colors.green),
          )
        ],
      ),
    );
  }
}
