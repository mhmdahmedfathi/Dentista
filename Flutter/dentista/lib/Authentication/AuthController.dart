import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController
{
  final box  = GetStorage();

  void ChangeState()
  {
    box.write('isLoggedIn', true);
  }
  void setEmail(String email)
  {
    box.write('email', email);
  }
  void setAccountType(String AccountType)
  {
    box.write('Type', AccountType);
  }

  void setdeliveryarea(String DArea){
    box.write("area", DArea);
  }

  void setdeliveryID(String DID){
    box.write("deliveryid", DID);
  }

  bool get State => box.read('isLoggedIn') ?? false;
  String get GetEmail => box.read('email');
  String get GetType => box.read('Type');
  String get GetDeliveryArea => box.read('area');
  String get GetDeliveryID => box.read("deliveryid");

}