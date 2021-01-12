import 'package:dentista/Manager%20Screens/Manager_Home.dart';
import 'package:dentista/Models/SharedTextStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class DeliveryStatistics extends StatefulWidget {
  final int Del_id;
  final Map  delInfo;
  final Map  delorders;
  DeliveryStatistics({this.Del_id,this.delInfo,this.delorders});
  @override
  _DeliveryStatisticsState createState() => _DeliveryStatisticsState(Del_id: Del_id,delInfo: delInfo,delorders: delorders);
}

class _DeliveryStatisticsState extends State<DeliveryStatistics> {
  final int Del_id;
  final Map  delInfo;
  final Map  delorders;
  _DeliveryStatisticsState({this.Del_id,this.delInfo,this.delorders});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ManagerHome()));
            },
          ),
          centerTitle: false,
          title: Text("Delivery Statistics" , style: TextStyle(
            fontFamily: 'montserrat',
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
          )
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[400],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("DELIVERY MAIN INFO" ,style: TextStyle(
                    fontSize: 20,
                    color: Colors.blueGrey[800],
                    fontFamily: 'montserrat',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                  ),
                  ),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Delivery ID: " , style: requestInfoStyle(color: Colors.blueGrey[500],size: 20)),
                            Text(Del_id.toString(),style: requestInfoStyle()),
                          ],
                        ),
                      ),

                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Name: " , style: requestInfoStyle(color: Colors.blueGrey[500],size: 20)),
                            Text(delInfo['Fname'] + " " + delInfo['Lname'],style: requestInfoStyle()),
                          ],
                        ),
                      ),

                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Email: " , style: requestInfoStyle(color: Colors.blueGrey[500],size: 20)),
                            Text(delInfo['Email'],style: requestInfoStyle()),
                          ],
                        ),
                      ),

                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Credit Card: " , style: requestInfoStyle(color: Colors.blueGrey[500],size: 20)),
                            Text(delInfo['CCN'],style: requestInfoStyle()),
                          ],
                        ),
                      ),

                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Area:" , style: requestInfoStyle(color: Colors.blueGrey[500],size: 20)),
                            Text(delInfo['Area'],style: requestInfoStyle()),
                          ],
                        ),
                      ),

                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Vehicle License: " , style: requestInfoStyle(color: Colors.blueGrey[500],size: 20)),
                            Text(delInfo['License'],style: requestInfoStyle()),
                          ],
                        ),
                      ),

                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Vehicle Model: " , style: requestInfoStyle(color: Colors.blueGrey[500],size: 20)),
                            Text(delInfo['Model'],style: requestInfoStyle()),
                          ],
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 15),
                      padding: EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[400],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Total Delivered Orders",style: TextStyle(
                            fontSize: 20,
                            color: Colors.blueGrey[800],
                            fontFamily: 'montserrat',
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                          ),
                            textAlign: TextAlign.center,
                          ),
                          Text(delorders['noofOrders'].toString(),
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.blueGrey[800],
                              fontFamily: 'montserrat',
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(top: 15),
                        padding: EdgeInsets.all(12),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[400],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Total Profit",style: TextStyle(
                              fontSize: 20,
                              color: Colors.blueGrey[800],
                              fontFamily: 'montserrat',
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.5,
                            ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        )),
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
