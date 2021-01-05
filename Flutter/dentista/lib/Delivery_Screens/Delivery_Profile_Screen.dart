import 'dart:convert';
import 'package:dentista/Models/Alerts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dentista/Delivery_Screens/DeliveryHome.dart';
import 'package:get/get.dart';
import 'package:dentista/UsersControllers/DeliveryController.dart';

class Delivery_Profile extends StatefulWidget {
  @override
  _Delivery_ProfileState createState() => _Delivery_ProfileState();
}

class _Delivery_ProfileState extends State<Delivery_Profile> {
  final DeliveryController deliveryController = Get.put(DeliveryController());
  _Delivery_ProfileState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
        title: Text(
          'My Profile',
          style: TextStyle(fontSize: 30, fontFamily: "Montserrat"),
          textAlign: TextAlign.left,
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
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
                child: Text("About",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'montserrat',
                        letterSpacing: 2.5)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 15),
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 12),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.account_circle),
                          SizedBox(width: 20),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Name ",
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      letterSpacing: 1.3,
                                      fontFamily: 'montserrat')),
                              Obx(()=> Text(
                                    deliveryController.fname.value +
                                        " " +
                                        deliveryController.lname.value,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        letterSpacing: 1.3,
                                        fontFamily: 'montserrat')),
                              )
                            ],
                          )),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                  child: TextButton(
                                onPressed: () {},
                                child: Text("Edit"),
                              )),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(Icons.alternate_email),
                          SizedBox(width: 20),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Email ",
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      letterSpacing: 1.3,
                                      fontFamily: 'montserrat')),
                              Text(deliveryController.email.value,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      letterSpacing: 1.3,
                                      fontFamily: 'montserrat')),
                            ],
                          )),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                  child: TextButton(
                                onPressed: () {},
                                child: Text("Edit"),
                              )),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(Icons.phone_android),
                          SizedBox(width: 20),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Phone Number ",
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      letterSpacing: 1.3,
                                      fontFamily: 'montserrat')),
                              Obx(()=> Text(deliveryController.phone.value,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        letterSpacing: 1.3,
                                        fontFamily: 'montserrat')),
                              )
                            ],
                          )),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                  child: TextButton(
                                onPressed: () {
                                  UpdateAlert(context, "", "Delivery_PHONE_NUMBER", deliveryController.phone.value, deliveryController.ID.value);
                                  deliveryController.update();
                                },
                                child: Text("Edit"),
                              )),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(Icons.perm_identity),
                          SizedBox(width: 20),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Delivery ID ",
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      letterSpacing: 1.3,
                                      fontFamily: 'montserrat')),
                              Obx(()=> Text(deliveryController.ID.value,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        letterSpacing: 1.3,
                                        fontFamily: 'montserrat')),
                              ),
                            ],
                          )),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(children: [
                          Icon(Icons.location_on),
                          SizedBox(width: 20),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Area ",
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      letterSpacing: 1.3,
                                      fontFamily: 'montserrat')),
                              Obx(()=> Text(deliveryController.area.value,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        letterSpacing: 1.3,
                                        fontFamily: 'montserrat')),
                              ),
                            ],
                          )),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                  child: TextButton(
                                onPressed: () {
                                  UpdateAlert(context, "", "AREA", deliveryController.area.value, deliveryController.ID.value);
                                deliveryController.update();
                                  },
                                child: Text("Edit"),
                              )),
                            ),
                          ),
                        ]),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(Icons.card_membership),
                          SizedBox(width: 20),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Vehicle License ",
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      letterSpacing: 1.3,
                                      fontFamily: 'montserrat')),
                              Text(deliveryController.vechilelicense.value,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      letterSpacing: 1.3,
                                      fontFamily: 'montserrat'))
                            ],
                          )),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                  child: TextButton(
                                onPressed: () {
                                  UpdateAlert(context, "", "VECHILE_LICENCE", deliveryController.vechilelicense.value, deliveryController.ID.value);
                                  deliveryController.update();
                                },
                                child: Text("Edit"),
                              )),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(Icons.local_shipping),
                          SizedBox(width: 20),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Vehicle Model ",
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      letterSpacing: 1.3,
                                      fontFamily: 'montserrat')),
                              Text(deliveryController.vechilemodel.value,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      letterSpacing: 1.3,
                                      fontFamily: 'montserrat'))
                            ],
                          )),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                  child: TextButton(
                                onPressed: () {
                                  UpdateAlert(context, "", "VECHILE_MODEL", deliveryController.vechilemodel.value, deliveryController.ID.value);
                                  deliveryController.update();
                                },
                                child: Text("Edit"),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
