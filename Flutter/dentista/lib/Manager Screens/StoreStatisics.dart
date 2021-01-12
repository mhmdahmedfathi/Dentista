import 'package:dentista/Manager%20Screens/GetRequestInfo.dart';
import 'package:dentista/Manager%20Screens/Manager_Home.dart';
import 'package:dentista/Models/SharedTextStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class StoreStatistics extends StatefulWidget {
  final int Store_id;
  final Map  StoreInfo;
  final Map  Storebranches;
  final Map products_count;
  StoreStatistics({this.StoreInfo,this.Store_id,this.Storebranches,this.products_count});
  @override
  _StoreStatisticsState createState() => _StoreStatisticsState(StoreInfo: StoreInfo,Store_id: Store_id,Storebranches: Storebranches,products_count: products_count);
}

class _StoreStatisticsState extends State<StoreStatistics> {
  final int Store_id;
  final Map  StoreInfo;
  final Map  Storebranches;
  final Map products_count;
  _StoreStatisticsState({this.StoreInfo,this.Store_id,this.Storebranches,this.products_count});


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
        title: Text("Store Statistics" , style: TextStyle(
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
                  Text("STORE MAIN INFO" ,style: TextStyle(
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
                            Text("Store ID: " , style: requestInfoStyle(color: Colors.blueGrey[500],size: 20)),
                            Text(Store_id.toString(),style: requestInfoStyle()),
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
                            Text(StoreInfo['Sname'],style: requestInfoStyle()),
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
                            Text("Phone Number: " , style: requestInfoStyle(color: Colors.blueGrey[500],size: 20)),
                            Text(StoreInfo['Phone'],style: requestInfoStyle()),
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
                            Text(StoreInfo['Email'],style: requestInfoStyle()),
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
                            Text("Branches: " , style: requestInfoStyle(color: Colors.blueGrey[500],size: 20)),
                            Text(Storebranches['branches'].toString(),style: requestInfoStyle()),
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
                          Text("Total Products",style: TextStyle(
                            fontSize: 20,
                            color: Colors.blueGrey[800],
                            fontFamily: 'montserrat',
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                          ),
                            textAlign: TextAlign.center,
                          ),
                          Text(products_count['Products_Count'].toString(),
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
