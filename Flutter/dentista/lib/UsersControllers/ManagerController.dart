import 'dart:convert';

import 'package:dentista/Authentication/AuthController.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class ManagerController extends GetxController
{
  final AuthController authController = Get.put(AuthController());
  var MFname =''.obs;
  var MLname=''.obs;
  var Manager_ID = 0.obs;
  var M_Type = ''.obs;
  var M_Area = ''.obs;
  var M_Email=''.obs;
  var ImageURL = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
   GetManagerData();
  }

  GetManagerData() async{
    final getdata = await http.post(
      'http://10.0.2.2:5000/GetData',
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        "email":authController.GetEmail,
        "AccountType":'Manager'
      }),
    );

    final accountData = json.decode(getdata.body);
    MFname (accountData['fname']);
    MLname ( accountData['lname']);
    Manager_ID (accountData['M_ID']);
    M_Type (accountData['M_Type']);
    M_Area (accountData['M_Area']);
    ImageURL (accountData['M_IMG']);
    M_Email(authController.GetEmail);


  }

}
