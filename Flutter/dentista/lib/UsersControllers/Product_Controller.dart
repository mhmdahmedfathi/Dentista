import 'package:dentista/Authentication/AuthController.dart';
import 'package:dentista/Views/StoreProductView.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import'dart:convert';

class Products_controller extends GetxController {
  var Products = new List<StoreProductView>().obs;

  var Loaded=false.obs;
  var URL="".obs;
  var No_Of_Products="".obs;
  var ProductCost="".obs;
  var ProductCount=0.obs;
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
    final ProductData =
    await http.post('http://10.0.2.2:5000/Product_getavailableTotalProducts',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    final data = json.decode(ProductData.body);

    ProductCount(data['Count'][0]);
    Products=List<StoreProductView>.generate(ProductCount.value, (index) => StoreProductView()).obs;
    for(int i=0;i<ProductCount.value;i++) {
      Products[i].Product_Name = (data['PRODUCT_NAME'][i]);
      Products[i].IMAGE_URL =(data['IMAGE_URL'][i]);
      Products[i].ProductCost =(data['SELLING_PRICE'][i]);
      Products[i].ProductBoughtCost =(data['PRICE'][i]);
      Products[i].ProductID=(data['PRODUCT_ID'][i]);
      Products[i].ProductCount=(data['NUMBER_OF_UNITS'][i]);

    }




  }



}




