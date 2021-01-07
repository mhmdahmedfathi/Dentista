import 'dart:convert';
import 'package:dentista/Authentication/AuthController.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DeliveryController extends GetxController{
  final AuthController authController = Get.put(AuthController());
  var fname = "".obs;
  var lname = "".obs;
  var email = "".obs;
  var phone = "".obs;
  var area = "".obs;
  var ID = "".obs;
  var vechilemodel = "".obs;
  var vechilelicense = "".obs;
  var rate = "".obs;
  var NumberOfOrders = "".obs;
  var Availablity = "".obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    final getdata = await http.post(
      'http://10.0.2.2:5000/GetData',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(
          {'email': authController.GetEmail, 'AccountType': 'Delivery'}),
    );

    final AcountData = json.decode(getdata.body);

    fname (AcountData['fname']);
    lname (AcountData['lname']);
    email (AcountData['email']);
    phone (AcountData['phone']);
    area (AcountData['area']);
    ID (AcountData['id'].toString());
    vechilemodel (AcountData['Vmodel']);
    vechilelicense (AcountData['Vlicense']);
    rate (AcountData['rate'].toString());
    NumberOfOrders (AcountData['ordersnumber'].toString());
    Availablity (AcountData['availablity'].toString());

    authController.setdeliveryarea(area.value);
    authController.setdeliveryID(ID.value);


  }



  IncDordersNumber(){
    NumberOfOrders ((int.parse(NumberOfOrders.toString())+1).toString());
  }
}
