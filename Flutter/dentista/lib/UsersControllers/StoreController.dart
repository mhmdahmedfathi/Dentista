import 'package:dentista/Authentication/AuthController.dart';
import 'package:dentista/Views/StoreProductView.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import'dart:convert';

class StoreController extends GetxController {
  var Loaded=false.obs;
  var STORE_NAME="".obs;
  var EMAIL="".obs;
  var PHONE_NUMBER="".obs;
  var CREDIT_CARD_NUMBER="".obs;
  var ID="".obs;
  var BranchesCount=0.obs;
  var Branches=new List<String>().obs;
  var Branch="".obs;
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
    await http.post('http://10.0.2.2:5000/Store_getavailableInformations',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({'ID': ID}));

    final data = json.decode(ProductData.body);

    {
       STORE_NAME(data['STORE_NAME'][0]);
       EMAIL(data['EMAIL'][0]);
       PHONE_NUMBER(data['PHONE_NUMBER'][0]);
       CREDIT_CARD_NUMBER(data['CREDIT_CARD_NUMBER'][0]);
       BranchesCount(data['Count_Branches'][0]);

       Branches=List<String>.generate(BranchesCount.value, (index) => "" ).obs;
       for(int i=0;i!=BranchesCount.value;i++) {
        Branches[i]=data['BRANCHES'][i];
       }

      Branch.value="";
       for(int i=0;i<BranchesCount.value;i++) {
           Branch.value=Branch.value + Branches[i]+" ";
       }


  }



}}




