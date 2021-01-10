import 'dart:convert';

import 'package:dentista/Manager%20Screens/PendingRequestsDelController.dart';
import 'package:dentista/Manager%20Screens/PendingTile.dart';
import 'package:dentista/UsersControllers/ManagerController.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
class PendingRequests extends StatefulWidget {
  @override
  _PendingRequestsState createState() => _PendingRequestsState();
}

class _PendingRequestsState extends State<PendingRequests> {
  PendingReqDelController pendingReqDelController = Get.put(PendingReqDelController());
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    pendingReqDelController.onInit();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()=> pendingReqDelController.isLoading.value == true ? Center(child: CircularProgressIndicator()) :
      ListView.builder(
        itemBuilder: (context,index){
          return PendingTile(Name:pendingReqDelController.fnames[index]+" "+pendingReqDelController.Lnames[index] ,id:pendingReqDelController.IDs[index] ,Photourl: "not yet",Type: "Delivery",);
        },
        itemCount: pendingReqDelController.fnames.length,
      )
      ),
    );
  }
}
