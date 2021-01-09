import 'package:dentista/Authentication/AuthController.dart';
import 'package:dentista/Authentication/Delivery_Signup.dart';
import 'package:dentista/Authentication/Dentist_Signup.dart';
import 'package:dentista/Authentication/Manager_Signup.dart';
import 'package:dentista/Authentication/Signin.dart';
import 'package:dentista/Authentication/Store_Signup.dart';
import 'package:dentista/Delivery_Screens/DeliveryHome.dart';
import 'package:dentista/Dentist_Screens/Dentist_Home.dart';
import 'package:dentista/Manager%20Screens/Manager_Home.dart';
import 'package:dentista/Models/AuthButtons.dart';
import 'package:dentista/Screens_Handler/Temp_Home.dart';
import 'package:dentista/Screens_Handler/mainscreen.dart';
import 'package:dentista/UsersControllers/ManagerController.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import'package:dentista/Store Screens/Store_Home.dart';
import'Store Screens/Upload_Image.dart';
void main ()
async{
  await GetStorage.init();   //initializting Get Storage
  WidgetsFlutterBinding.ensureInitialized();
  final authController = Get.put(AuthController());
  bool isLogged = authController.State;
  String accountType = authController.GetType;
  print(isLogged);
  print(accountType);
  runApp(GetMaterialApp(
    smartManagement: SmartManagement.keepFactory,
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      appBarTheme: AppBarTheme(
        centerTitle: true,
        color: Colors.blueGrey[800],
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
    home: isLogged==true ? accountType=='Manager' ? ManagerHome()
    :accountType=='Dentist' ? DentistHome("", "", "")
        :accountType=='Delivery' ? DeliveryHome()
        :accountType=='Store' ? StoreHome() : MainScreen() : MainScreen()
    ,
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
