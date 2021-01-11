import 'dart:convert';
import 'package:dentista/Authentication/AuthController.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dentista/utility_class/Order.dart';

class OrderController extends GetxController{
  final AuthController authController = Get.put(AuthController());
  var Orders= new List<Order>().obs;
  var DeliveredOrders= new List<Order>().obs;
  var DeliveryID ="".obs;
  var numberoforders = 0.obs;
  var deliveryarea ="".obs;
  // OrderController(String area){
  //   deliveryarea.value=area;
  // }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();


    deliveryarea (authController.GetDeliveryArea);
    DeliveryID (authController.GetDeliveryID);

    final OrderData = await http.post(
        'http://10.0.2.2:5000/delivery_getavailableorder',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({'area': deliveryarea.value}));
    final data = json.decode(OrderData.body);

    numberoforders  (data['no.orders'][0]);
    Orders = List<Order>.generate(numberoforders.value, (index) => Order()).obs;
      for (int i = 0; i < numberoforders.value; i++) {
        Orders[i].DentistFName = (data['dentistfname'][i]);
        Orders[i].DentistLName = (data['dentistlname'][i]);
        Orders[i].OrderID = (data['orderid'][i].toString());
        Orders[i].TotalCost = (data['ordertotal'][i].toString());
        Orders[i].DentistAddress = (data['address'][i]);
        Orders[i].Dentistphonenumber = (data['phone'][i]);
        Orders[i].Dentistemail = (data['email'][i]);
        Orders[i].DentistiID = (data['DID'][i].toString());
        Orders[i].Status = (data['status'][i]);
      }

    final DeliveredOrdersData = await http.post(
        'http://10.0.2.2:5000/delivery_getmydeliveredorders',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'DELIVERYID': DeliveryID.value
        }));
    final seconddata = json.decode(DeliveredOrdersData.body);
    int numberofdeliveredorders = seconddata['number'];
    DeliveredOrders = List<Order>.generate(numberofdeliveredorders, (index) => Order()).obs;
    for (int i = 0; i < numberofdeliveredorders; i++) {
      DeliveredOrders[i].DentistFName = (seconddata['dentistfname'][i]);
      DeliveredOrders[i].DentistLName = (seconddata['dentistlname'][i]);
      DeliveredOrders[i].OrderID = (seconddata['orderids'][i].toString());
      DeliveredOrders[i].Status = (seconddata['status'][i]);
      DeliveredOrders[i].TotalCost = (seconddata['cost'][i].toString());
    }

  }

}