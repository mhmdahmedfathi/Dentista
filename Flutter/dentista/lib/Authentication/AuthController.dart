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
  void setID(int id)
  {
    box.write('ID', id);
  }
  void setdeliveryarea(String DArea){
    box.write("area", DArea);
  }

  void setdeliveryID(String DID){
    box.write("deliveryid", DID);
  }

  void setStoreID(String ID)
  {
    box.write('Store_ID', ID);
  }

  void setProduct_Name(String Product_Name)
  {
    box.write('Product_Name', Product_Name);
  }
  void setStoreName(String Name)
  {
    box.write('Store_Name', Name);
  }

  void ResetStorage(){
    box.erase();
  }

  String get StoreName => box.read('Store_Name');
  String get StoreID => box.read('Store_ID');
  String get Product_Name => box.read('Product_Name');
  bool get State => box.read('isLoggedIn') ?? false;
  String get GetEmail => box.read('email');
  String get GetType => box.read('Type');
  String get GetDeliveryArea => box.read('area');
  String get GetDeliveryID => box.read("deliveryid");
  int get  UserID  => box.read('ID');
}
