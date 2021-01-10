import 'package:dentista/Authentication/AuthController.dart';
import 'package:dentista/Views/StoreProductView.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import'dart:convert';

class Store_DentistChat extends GetxController {
  var Dentist =new List<String>().obs;
  var DentistChats=0.obs;
  var DentistFname="".obs;
  var DentistLname="".obs;
  var ID="".obs;
  void setID()
  {
    AuthController  authController = Get.put(AuthController());
    ID(authController.StoreID);
  }

  @override
  void onInit() async{

    super.onInit();
    setID();
    final ChatData =
    await http.post('http://10.0.2.2:5000/Store_DentistChat',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({'ID': ID}));

    final data = json.decode(ChatData.body);
    {
      print(DentistChats(data['count(DENTIST_ID)'][0]));
      Dentist=List<String>.generate(DentistChats.value, (index) => "" ).obs;
      for(int i=0;i!=DentistChats.value;i++) {
        Dentist[i]=(data['DENTIST_Fname'][i] +"  " +data['DENTIST_LNAME'][i]);
      }



    }



  }}




