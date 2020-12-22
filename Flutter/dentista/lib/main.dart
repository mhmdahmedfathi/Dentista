import 'package:dentista/Authentication/Delivery_Signup.dart';
import 'package:dentista/Authentication/Dentist_Signup.dart';
import 'package:dentista/Authentication/Manager_Signup.dart';
import 'package:dentista/Authentication/Store_Signup.dart';
import 'package:dentista/Models/AuthButtons.dart';
import 'package:flutter/material.dart';

void main ()
{
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      appBarTheme: AppBarTheme(
        centerTitle: true,
        color: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey[500]),
      ),
      iconTheme: IconThemeData(color: Colors.grey[500]),
      buttonColor: Colors.grey[350],
      textTheme: TextTheme(
        caption: TextStyle(
          color: Colors.grey[800],
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
        button: TextStyle(
          color: Colors.grey[400],
          letterSpacing: 1.1
        )
      ),
    ),
    home: Home(),
  ),
  );
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return DeliverySignUp();
    return Scaffold(
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
          )
        ],
      ),
    );
  }
}
