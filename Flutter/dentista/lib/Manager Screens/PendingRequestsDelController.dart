import 'dart:convert';

import 'package:dentista/Authentication/AuthController.dart';
import 'package:dentista/UsersControllers/ManagerController.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class PendingReqDelController extends GetxController
{
  AuthController authController = Get.put(AuthController());
  dynamic fnames = [].obs;
  dynamic Lnames = [].obs;
  dynamic IDs = [].obs;
  dynamic isLoading = true.obs;
  dynamic MArea = ''.obs;
  @override
  void onInit()async{
    // TODO: implement onInit
    super.onInit();
    await GetManagerArea();
    GetDelPending();
  }
  void GetManagerArea() async{
    print(authController.GetEmail);
    var response = await http.post(
        'http://10.0.2.2:5000/area_of_manager',
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'Email' : authController.GetEmail
        })

    );
    final request = json.decode(response.body);
    print(request);
    MArea(request['Area']);

  }
  void GetDelPending() async{
    try{
      isLoading(true);
      var response = await http.post('http://10.0.2.2:5000/pending_requests_del',
          headers: <String,String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            'MArea' : MArea
          })
      );
      final requests = json.decode(response.body);
      fnames  (requests['fname']);
      Lnames ( requests['lname']);
      IDs = (requests['DID']);
    }finally
        {
          isLoading(false);
        }
  }
}