import 'package:dentista/Models/AuthButtons.dart';
import 'package:dentista/Models/SharedTextStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RequestInfo extends StatefulWidget {
  @override
  _RequestInfoState createState() => _RequestInfoState();
}

class _RequestInfoState extends State<RequestInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Request Info" , style: TextStyle(
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
        ),
        backgroundColor:Colors.blueGrey[800],
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
              child: Text("DELIVERY INFO" , style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                  fontFamily: 'montserrat',
                letterSpacing: 2.5
              ) ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 12),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Name :" , style: requestInfoStyle()),
                    SizedBox(height: 20),
                    Text("Email :", style: requestInfoStyle()),
                    SizedBox(height: 20),
                    Text("Credit Card :", style: requestInfoStyle()),
                    SizedBox(height: 20),
                    Text("Area :", style: requestInfoStyle()),
                    SizedBox(height: 20),
                    Text("Vehicle License :", style: requestInfoStyle()),
                    SizedBox(height: 20),
                    Text("Vehicle Model :", style: requestInfoStyle()),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(child: drawButton("Accept", Colors.blueGrey[800])),
                SizedBox(width: 8,),
                Expanded(child: drawButton("Reject", Colors.blueGrey[200])),
              ],
            ),
          )
        ],
      ),
    );
  }
}
