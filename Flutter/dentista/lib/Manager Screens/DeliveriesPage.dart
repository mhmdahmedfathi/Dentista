import 'dart:convert';

import 'package:dentista/Authentication/AuthController.dart';
import 'package:dentista/Manager%20Screens/ViewTile.dart';
import 'package:dentista/UsersControllers/ManagerController.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
class DeliveriesPage extends StatefulWidget {
  @override
  _DeliveriesPageState createState() => _DeliveriesPageState();
}

class _DeliveriesPageState extends State<DeliveriesPage> {
  final ManagerController managerController = Get.put(ManagerController());
  final AuthController authController = Get.put(AuthController());
  List Dfnames = List<dynamic>();
  List DLnames = List<dynamic>();
  List IDs = List<dynamic>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      fetchRequests();
    });
  }
  fetchRequests()async{
    var response = await http.post('http://10.0.2.2:5000/get_all_delivery',
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
        body: json.encode({
          'MArea' :managerController.M_Area.value,
          'MID' : authController.UserID
        })
    );

      final requests = json.decode(response.body);
      Dfnames = requests['DFname'];
      DLnames = requests['DLname'];
      IDs = requests['DID'];

    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context , index){
      return ViewTile(storeDeliveryName: Dfnames[index]+" "+DLnames[index],productesDelivers: IDs[index].toString(),type: 1,);
    },
    itemCount: IDs.length,
    );
  }
}
