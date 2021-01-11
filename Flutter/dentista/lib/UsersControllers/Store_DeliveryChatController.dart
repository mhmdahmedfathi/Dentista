import 'package:dentista/Authentication/AuthController.dart';
import 'package:dentista/Views/StoreProductView.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import'dart:convert';

class Store_DeliveryChat extends GetxController {
  var Delivery =new List<String>().obs;
  var IDs =new List<int>().obs;
  var DeliveryChats=0.obs;
  var DeliveryFname="".obs;
  var DeliveryLname="".obs;
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
    await http.post('http://10.0.2.2:5000/Store_DeliveryChat',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({'ID': ID}));

    final data = json.decode(ChatData.body);
    {
      print(DeliveryChats(data['count(DELIVERY_ID)'][0]));
      Delivery=List<String>.generate(DeliveryChats.value, (index) => "" ).obs;
      IDs=List<int>.generate(DeliveryChats.value, (index) => 0 ).obs;
      for(int i=0;i!=DeliveryChats.value;i++) {
        Delivery[i]=(data['DELIVERY_Fname'][i] +"  " +data['DELIVERY_Lname'][i]);
        IDs[i]=(data['DELIVERY_ID'][i]);
      }



    }



  }}




