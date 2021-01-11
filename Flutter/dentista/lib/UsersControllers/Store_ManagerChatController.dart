import 'package:dentista/Authentication/AuthController.dart';
import 'package:dentista/Views/StoreProductView.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import'dart:convert';

class StoreManagerChat extends GetxController {
  var Manager =new List<String>().obs;
  var IDs =new List<int>().obs;
  var managerChats=0.obs;
  var managerFname="".obs;
  var managerLname="".obs;
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
    await http.post('http://10.0.2.2:5000/Store_ManagerChat',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({'ID': ID}));

    final data = json.decode(ChatData.body);
    {
      (managerChats(data['count(DISTINCT (MANAGER_ID))'][0]));
      Manager=List<String>.generate(managerChats.value, (index) => "" ).obs;
      IDs=List<int>.generate(managerChats.value, (index) => 0 ).obs;
      for(int i=0;i!=managerChats.value;i++) {
        Manager[i]=(data['MANAGER_Fname'][i] +"  " +data['MANAGER_Lname'][i]);
        print(IDs[i]=(data['MANAGER_ID'][i]));
      }



    }



  }}




