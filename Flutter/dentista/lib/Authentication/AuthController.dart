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
  bool get State => box.read('isLoggedIn') ?? false;
  String get GetEmail => box.read('email');
  String get GetType => box.read('Type');
}