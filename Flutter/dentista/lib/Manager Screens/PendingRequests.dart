import 'dart:convert';

import 'package:dentista/Manager%20Screens/PendingTile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class PendingRequests extends StatefulWidget {
  @override
  _PendingRequestsState createState() => _PendingRequestsState();
}

class _PendingRequestsState extends State<PendingRequests> {
  List fnames = List<dynamic>();
  List Lnames = List<dynamic>();
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
    var response = await http.get('http://10.0.2.2:5000/pending_requests',
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200)
      {
        final requests = json.decode(response.body);
        fnames = requests['fname'];
        Lnames = requests['lname'];
        IDs = requests['DID'];
      }
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
      itemBuilder: (context,index){
        return PendingTile(Name:fnames[index]+" "+Lnames[index] ,Type:IDs[index].toString() ,Photourl: "not yet");
      },
        itemCount: fnames.length,
      ),
    );
  }
}
