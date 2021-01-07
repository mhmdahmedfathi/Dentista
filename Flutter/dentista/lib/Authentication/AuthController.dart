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

  void setStoreID(String ID)
  {
    box.write('Store_ID', ID);
  }
  void setStoreName(String Name)
  {
    box.write('Store_Name', Name);
  }

  String get StoreName => box.read('Store_Name');
  String get StoreID => box.read('Store_ID');
  bool get State => box.read('isLoggedIn') ?? false;
  String get GetEmail => box.read('email');
  String get GetType => box.read('Type');
}