import 'package:dentista/Authentication/AuthController.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class DentistController extends GetxController
{
  var DentistEmail = "".obs;
  var DentistID = (-1).obs;
  var DentistFname = "".obs;
  var DentistLname = "".obs;
  var DentistPassword = "".obs;
  var DentistAddress = "".obs;
  var DentistRegion = "".obs;
  var DentistZipCode = 0.obs;
  var DentistImageURL = "".obs;
  var DentistCreditCardNumber = "".obs;
  var DentistPhoneNumber = "".obs;
  var DentistCity = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    SetEmail();
    GetDentist();
  }

  void SetEmail()
  {
    AuthController authController = Get.put(AuthController());
    DentistEmail(authController.GetEmail);
  }

  void GetDentist()async
  {
    final getdata = await http.post(
      'http://10.0.2.2:5000/GetDentist',
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        'email':DentistEmail.value,
      }),
    );

    final DentistData = json.decode(getdata.body);
    DentistID(DentistData['DentistID']);
    DentistFname(DentistData['DentistFname']);
    DentistLname(DentistData['DentistLname']);
    DentistAddress(DentistData['DentistAddress']);
    DentistCity(DentistData['DentistCity']);
    DentistRegion(DentistData['DentistRegion']);
    DentistImageURL(DentistData['DentistImageURL']);
    DentistCreditCardNumber(DentistData['DentistCreditCardNumber']);
    DentistPassword(DentistData['DentistPassword']);
    DentistPhoneNumber(DentistData['DentistPhoneNumber']);
    DentistZipCode(DentistData['DentistZipCode']);
  }
}