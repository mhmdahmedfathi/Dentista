import 'package:dentista/Manager%20Screens/PendingTile.dart';
import 'package:flutter/material.dart';
class PendingRequests extends StatefulWidget {
  @override
  _PendingRequestsState createState() => _PendingRequestsState();
}

class _PendingRequestsState extends State<PendingRequests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
      itemBuilder: (context,index){
        return PendingTile(Name:"Store-Delivery Name" ,Type: "Request Type" ,Photourl: "not yet");
      },
        itemCount: 20,
      ),
    );
  }
}
