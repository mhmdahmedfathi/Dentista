import 'dart:async';
import 'dart:ui';
import 'package:dentista/Authentication/AuthController.dart';
import 'package:dentista/Controllers/EmailConfirmationController.dart';
import 'package:dentista/Delivery_Screens/DeliveryHome.dart';
import 'package:dentista/Dentist_Screens/Dentist_Home.dart';
import 'package:dentista/Manager%20Screens/Manager_Home.dart';
import 'package:dentista/Models/AuthButtons.dart';
import 'package:dentista/Models/AuthenticationFields.dart';
import 'package:dentista/Store%20Screens/Store_Home.dart';
import 'package:dentista/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dentista/Authentication/Store_Signup.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dentista/Auth/Validations.dart';
import 'package:dentista/Models/Alerts.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'dart:async';

class EmailConfirmation extends StatefulWidget {

  @override
  _EmailConfirmationState createState() => _EmailConfirmationState();

}

class _EmailConfirmationState extends State<EmailConfirmation> {

  EmailConfirmationController emailConfirmationController = Get.put(EmailConfirmationController());
  String text = '';

  void _onKeyboardTap(String value) {
    setState(() {
      text = text + value;
    });
  }

  Timer _timer;
  int _start = 60;
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }



  Widget otpNumberWidget(int position) {
    try {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))
        ),
        child: Center(child: Text(text[position], style: TextStyle(color: Colors.black),)),
      );
    } catch (e) {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: CircleAvatar(

                  backgroundImage: NetworkImage('https://assets.stickpng.com/images/58485698e0bb315b0f7675a8.png'),
                  radius: 80,
                ),
              ),
            ),
            Flexible(
              child: Text('Verify your Email',
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[800]
                ),
              ),
            ),
            SizedBox(height: 10.0,),
            Flexible(
              child: Container(
                padding: EdgeInsets.all(10.0),
                constraints: const BoxConstraints(
                    maxWidth: 500
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    otpNumberWidget(0),
                    otpNumberWidget(1),
                    otpNumberWidget(2),
                    otpNumberWidget(3),
                    otpNumberWidget(4),
                    otpNumberWidget(5),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${_start} seconds to ",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.normal,
                  ),
                ),
                GestureDetector(
                  onTap: ()
                  {
                    // Initailize the controller
                    emailConfirmationController.onInit();
                    _start = 60;
                    text = "";
                    startTimer();
                    setState(() {

                    });
                  },
                  child: Text('resend code',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.normal,
                      color: Colors.blue[400]
                    ),

                  ),
                )
              ],
            ),
            SizedBox(height: 4,),
            CupertinoButton(
              onPressed: text.length == 0 ? null : ()
              {
                if (text == emailConfirmationController.Code.value.toString())
                  {
                    print("true");
                    AuthController authController = Get.put(AuthController());
                    if(authController.GetType == "Dentist")
                      Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(builder: (context)=>DentistHome("", "", "")));
                    else if (authController.GetType == "Delivery")
                      Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(builder: (context)=>DeliveryHome()));
                    else if (authController.GetType == "Manager")
                      Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(builder: (context)=>ManagerHome()));
                    else if (authController.GetType == "Store")
                      Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(builder: (context)=>StoreHome()));

                  }
                else
                  {

                  }
              },
              color: Colors.blue[800],
              child: Text('Confirm', style: TextStyle(
                fontSize: 15,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.normal,
              ),),
            ),
            SizedBox(height: 4.0,),
            NumericKeyboard(
                onKeyboardTap: _onKeyboardTap,
              textColor: Colors.blueGrey[800],
              rightIcon: Icon(Icons.backspace),
              rightButtonFn: (){
                  setState(() {
                    text = text.substring(0, text.length - 1);
                  });
              },
            )

          ],
        ),
      ),
    );
  }
}
