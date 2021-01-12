import 'dart:convert';

import 'package:dentista/Authentication/AuthController.dart';
import 'package:dentista/Chat/Chatroom.dart';
import 'package:dentista/Manager%20Screens/DeliveryStatistics.dart';
import 'package:dentista/Manager%20Screens/GetRequestInfo.dart';
import 'package:dentista/Manager%20Screens/Manager_Home.dart';
import 'package:dentista/Manager%20Screens/StoreStatisics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
class ViewTile extends StatelessWidget {
  AuthController authController = Get.put(AuthController());
  final String storeDeliveryName;
  final String productesDelivers;
  final int type;
  String subText;
  Map StatisticsInfo = Map();
  Map Statisticsbranches = Map();
  Map productsCount =Map();
  Map DeliveryInfo = Map();
  Map TotalDorders = Map();
  ViewTile({this.storeDeliveryName, this.productesDelivers, this.type});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          onTap: () {},
          leading: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.blueGrey,
          ),
          title: Text(
            storeDeliveryName,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                fontFamily: 'montserrat'),
          ),
          subtitle: Text(
            (type == 0 ? "Store" : "Delivery") + " ID: " + productesDelivers,
            style: TextStyle(
                fontSize: 14,
                fontFamily: 'montserrat',
                fontWeight: FontWeight.w600),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  icon: Icon(
                    Icons.bar_chart,
                    size: 30,
                  ),
                  onPressed: () async{
                    if(type==0) {
                      StatisticsInfo = await GetRequestInfoStore(int.parse(productesDelivers));
                      Statisticsbranches = await GetRequestInfoStorebranches(int.parse(productesDelivers));
                      productsCount = await GetProductsCount(int.parse(productesDelivers));
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) =>
                              StoreStatistics(StoreInfo: StatisticsInfo
                                ,Store_id:int.parse(productesDelivers) ,Storebranches:Statisticsbranches ,products_count: productsCount,)));
                    }
                    else
                      {
                        DeliveryInfo = await GetRequestInfo(int.parse(productesDelivers));
                        TotalDorders = await GetDorders(int.parse(productesDelivers));
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DeliveryStatistics(delInfo: DeliveryInfo,Del_id: int.parse(productesDelivers),delorders: TotalDorders,)));
                      }
                  }
                  ),
              IconButton(
                icon: Icon(Icons.chat_outlined),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatRoom(
                        localuserid: authController.UserID,
                        recevierid: int.parse(productesDelivers),
                        recevierName: storeDeliveryName,
                        recevierType: type == 0 ? "Store" : "Delivery",
                      ),
                    ),
                  );
                },
              ),
              IconButton(icon: Icon(Icons.delete), onPressed: ()
             async {
                if(type==0)
                  {
                    var response = await http.post('http://10.0.2.2:5000/delete_store',
                        headers: <String,String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: json.encode({
                          "SID" : int.parse(productesDelivers),
                          "MID" : authController.UserID
                        })
                    );
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ManagerHome()));
                  }
                else
                  {
                    var response = await http.post('http://10.0.2.2:5000/delete_delivery',
                        headers: <String,String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: json.encode({
                          "DID" : int.parse(productesDelivers)
                        })
                    );
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ManagerHome()));
                  }
              }
              )
            ],
          )),

    );
  }
}
