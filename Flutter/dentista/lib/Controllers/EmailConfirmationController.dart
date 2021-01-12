import 'package:dentista/Authentication/AuthController.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math';
class EmailConfirmationController extends GetxController
{
  var Code = 0.obs;
  var email = "".obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    SetEmail();
    GenerateCode();
    SendCode();
  }
  void SetEmail()
  {
    AuthController authController = Get.put(AuthController());
    email(authController.GetEmail);
  }
  void GenerateCode()
  {
    Random random = new Random();
    int randomNumber = random.nextInt(900000) + 100000;
    Code(randomNumber);
  }
  void SendCode() async
  {
    final ProductRes = await http.post(
        'https://dentistastore.azurewebsites.net/ConfirmEmail',
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({"Code" : Code.value, "email": email.value}));
  }


}