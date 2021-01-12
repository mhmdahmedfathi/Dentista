import 'dart:convert';

import 'package:dentista/Manager%20Screens/PendingTile.dart';
import 'package:dentista/UsersControllers/ManagerController.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class StorePendingRequests extends StatefulWidget {
  @override
  _StorePendingRequestsState createState() => _StorePendingRequestsState();
}

class _StorePendingRequestsState extends State<StorePendingRequests> {
  ManagerController managerController = Get.put(ManagerController());
  List Snamesp = List<dynamic>();
  List PIDs = List<dynamic>();
  List BIDs = List<dynamic>();
  String area;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      fetchRequests();
    });
  }
  fetchRequests()async{

    var response = await http.post('http://10.0.2.2:5000/pending_requests_store',
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'MArea' : managerController.M_Area.value
        })
    );

      final requests = json.decode(response.body);

      Snamesp = requests['Sname'];
      PIDs = requests['SID'];
      BIDs = requests['BID'];

    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context,index){
          return PendingTile(Name:Snamesp[index],id:PIDs[index] ,Photourl: "not yet",Type: "Store",branch_id: BIDs[index],);
        },
        itemCount: PIDs.length,
      ),
    );
  }
}

