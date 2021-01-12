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
      body:Column(
        children: [
          SafeArea(
            child: Container(
              color: Colors.grey[300],
              padding: EdgeInsets.fromLTRB(30, 30, 30, 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text("Dentista." ,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat",
                            fontSize: MediaQuery.of(context).size.width *0.163,
                          ),
                        ),
                      ),

                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(builder: (context)=>DentistSignup()));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 2
                        ),
                        color: Colors.blueGrey[700],
                      ),
                      width: double.infinity,
                      child: Center(
                        child: Text("SIGN UP AS DENTIST"
                          ,style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat",
                            fontSize: 20.0,
                          )
                          ,
                        ),
                      ),

                    ),
                  ),
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(builder: (context)=>StoreSignUp()));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey,
                            width: 2
                        ),
                        color: Colors.blueGrey[700],
                      ),
                      width: double.infinity,
                      child: Center(
                        child: Text("SIGN UP AS STORE"
                          ,style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat",
                            fontSize: 20.0,
                          )
                          ,
                        ),
                      ),

                    ),
                  ),
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(builder: (context)=>DeliverySignUp()));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey,
                            width: 2
                        ),
                        color: Colors.blueGrey[700],
                      ),
                      width: double.infinity,
                      child: Center(
                        child: Text("SIGN UP AS DELIVERY"
                          ,style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat",
                            fontSize: 20.0,
                          )
                          ,
                        ),
                      ),

                    ),
                  ),
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(builder: (context)=>ManagerSignup()));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey,
                            width: 2
                        ),
                        color: Colors.blueGrey[700],
                      ),
                      width: double.infinity,
                      child: Center(
                        child: Text("SIGN UP AS MANAGER"
                          ,style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat",
                            fontSize: 20.0,
                          )
                          ,
                        ),
                      ),

                    ),
                  ),
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(builder: (context)=>SignIn()));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey,
                            width: 2
                        ),
                        color: Colors.blueGrey[700],
                      ),
                      width: double.infinity,
                      child: Center(
                        child: Text("SIGN IN"
                          ,style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat",
                            fontSize: 20.0,
                          )
                          ,
                        ),
                      ),

                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}
