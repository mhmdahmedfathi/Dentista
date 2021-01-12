import 'dart:convert';

import 'package:dentista/Authentication/AuthController.dart';
import 'package:dentista/UsersControllers/ManagerController.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ViewTile.dart';

class StoresPage extends StatefulWidget {
  @override
  _StoresPageState createState() => _StoresPageState();
}

class _StoresPageState extends State<StoresPage> {
  final ManagerController managerController = Get.put(ManagerController());
  final AuthController authController = Get.put(AuthController());
  List Snames = List<dynamic>();
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
    var response = await http.post('http://10.0.2.2:5000/get_all_stores',
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        'MArea' :managerController.M_Area.value,
        'MID' : authController.UserID
      })
    );

      final requests = json.decode(response.body);
      Snames = requests['SNAME'];
      IDs = requests['SID'];

    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context,index)
    {
      return ViewTile(storeDeliveryName: Snames[index],productesDelivers: IDs[index].toString(),type: 0,);
    },
      itemCount: IDs.length,
    );
  }
}
