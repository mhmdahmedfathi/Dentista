import 'dart:convert';

import 'package:dentista/Manager%20Screens/Manager_Home.dart';
import 'package:dentista/Manager%20Screens/PendingRequests.dart';
import 'package:dentista/Models/AuthButtons.dart';
import 'package:dentista/Models/SharedTextStyle.dart';
import 'package:dentista/UsersControllers/ManagerController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class RequestInfoStore extends StatefulWidget {
  final Map result;
  final reqID;
  final int branch_id;

  RequestInfoStore({this.result, this.reqID,this.branch_id});

  @override
  _RequestInfoStoreState createState() =>
      _RequestInfoStoreState(result: result, reqID: reqID,branch_id: branch_id);
}

class _RequestInfoStoreState extends State<RequestInfoStore> {
  final ManagerController managerController = Get.put(ManagerController());
  final Map result;
  final reqID;
  final int branch_id;
  _RequestInfoStoreState({this.result, this.reqID,this.branch_id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ManagerHome()));
          },
        ),
        centerTitle: false,
        title: Text(
          "Request Info",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.grey[300],
            padding: EdgeInsets.all(20),
            child: Center(
              child: CircleAvatar(
                backgroundColor: Colors.blueGrey,
                radius: 85,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text("STORE INFO",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'montserrat',
                      letterSpacing: 2.5)),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 12),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.person_pin),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Store Name ",
                                  style: requestInfoStyle(
                                      color: Colors.blueGrey[500])),
                              Text(result['Sname'] ,
                                  style: requestInfoStyle(size: 16)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(Icons.alternate_email),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Email ",
                                    style: requestInfoStyle(
                                        color: Colors.blueGrey[500])),
                                Text(result['Email'],
                                    style: requestInfoStyle(size: 16)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(Icons.credit_card),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Credit Card ",
                                  style: requestInfoStyle(
                                      color: Colors.blueGrey[500])),
                              Text(result['CCN'],
                                  style: requestInfoStyle(size: 16)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(Icons.location_on),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Phone Number ",
                                  style: requestInfoStyle(
                                      color: Colors.blueGrey[500])),
                              Text(result['Phone'],
                                  style: requestInfoStyle(size: 16)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
                child: GestureDetector(
                    onTap: () async {
                      var response = await http.post(
                          'http://10.0.2.2:5000/acctept_request',
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body: json.encode({
                            'type' : 'Store',
                            'MID' : managerController.Manager_ID.value,
                            'DID' : reqID,
                            'SID' : reqID,
                            'BID' : branch_id
                          }));
                      return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ManagerHome()));
                    },
                    child: drawButton("Accept", Colors.blueGrey[800]))),
            SizedBox(
              width: 8,
            ),
            Expanded(
                child: GestureDetector(
                    onTap: ()async{
                      var response = await http.post('http://10.0.2.2:5000/reject_request',
                          headers: <String,String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body: json.encode({
                            'type' : 'Store',
                            'MID' : managerController.Manager_ID.value,
                            'DID' : reqID,
                            'SID' : reqID,
                            'BID' : branch_id
                          })
                      );
                      return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ManagerHome()));
                    },
                    child: drawButton("Reject", Colors.blueGrey[200]))),
          ],
        ),
      ),
    );
  }
}
