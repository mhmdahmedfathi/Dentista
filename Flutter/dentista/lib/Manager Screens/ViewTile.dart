import 'package:dentista/Authentication/AuthController.dart';
import 'package:dentista/Chat/Chatroom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewTile extends StatelessWidget {
  AuthController authController = Get.put(AuthController());
  final String storeDeliveryName;
  final String productesDelivers;
  final int type;
  String subText;

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
                  onPressed: () {}
                  ),
              IconButton(
                icon: Icon(Icons.chat_outlined),
                onPressed: () {
                  Navigator.pushReplacement(
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
            ],
          )),

    );
  }
}
