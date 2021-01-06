import 'dart:convert';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dentista/Delivery_Screens/Delivery_Settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dentista/Screens_Handler/mainscreen.dart';
import 'package:http/http.dart' as http;
import 'package:dentista/utility_class/Order.dart';
import 'package:dentista/Delivery_Screens/OrderScreen.dart';
import 'package:get/get.dart';
import 'package:dentista/Delivery_Screens/Delivery_Profile_Screen.dart';
import 'package:dentista/UsersControllers/DeliveryController.dart';

class DeliveryHome extends StatefulWidget {
  @override
  _DeliveryHomeState createState() => _DeliveryHomeState();
}

class _DeliveryHomeState extends State<DeliveryHome> {
  final DeliveryController deliveryController = Get.put(DeliveryController());
  int _page = 0;
  int OrdersNumber = 0;
  int present = 20;
  int perPage = 20;
  List<Order> Orders;

  _DeliveryHomeState();

  @override
  void initState() {
    super.initState();
    asyncmethod();
  }

  void asyncmethod() async {
    final OrderData =
        await http.post('http://10.0.2.2:5000/delivery_getavailableorder',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({'area': deliveryController.area.value}));
    final data = json.decode(OrderData.body);

    OrdersNumber = data['no.orders'][0];
    Orders = List<Order>.generate(OrdersNumber, (index) => Order());
    setState(() {
      for (int i = 0; i < OrdersNumber; i++) {
        Orders[i].DentistFName = data['dentistfname'][i];
        Orders[i].DentistLName = data['dentistlname'][i];
        Orders[i].OrderID = data['orderid'][i].toString();
        Orders[i].TotalCost = data['ordertotal'][i].toString();
        Orders[i].DentistAddress = data['address'][i];
        Orders[i].Dentistphonenumber = data['phone'][i];
        Orders[i].Dentistemail = data['email'][i];
      }
    });
  }

  void loadmore() {
    setState(() {
      for (int i = 0; i < 20; i++) {
        present = present + perPage;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          index: 0,
          buttonBackgroundColor: Colors.grey,
          height: 50,
          color: Colors.blueGrey[800],
          backgroundColor: Colors.white,
          items: [
            Padding(
                padding: const EdgeInsets.all(3.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.format_list_numbered,
                        size: 30, color: Colors.white),
                    Text("Orders",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: Colors.white))
                  ],
                )),
            Padding(
                padding: const EdgeInsets.all(3.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.bar_chart,
                        size: 30, color: Colors.white),
                    Text("statistics",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: Colors.white))
                  ],
                ))
          ],
          onTap: (val) {
            setState(() {
              _page =val;
            });
          }),
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
        title: Text(
          'Dentista',
          style: TextStyle(fontSize: 30, fontFamily: "Montserrat"),
          textAlign: TextAlign.left,
        ),
        centerTitle: false,
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              color: Colors.white,
              onPressed: () async {
                final OrderData = await http.post(
                    'http://10.0.2.2:5000/delivery_getavailableorder',
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: json.encode({'area': deliveryController.area.value}));
                final data = json.decode(OrderData.body);

                OrdersNumber = data['no.orders'][0];
                Orders = List<Order>.generate(OrdersNumber, (index) => Order());
                setState(() {
                  for (int i = 0; i < OrdersNumber; i++) {
                    Orders[i].DentistFName = data['dentistfname'][i];
                    Orders[i].DentistLName = data['dentistlname'][i];
                    Orders[i].OrderID = data['orderid'][i].toString();
                    Orders[i].TotalCost = data['ordertotal'][i].toString();
                    Orders[i].DentistAddress = data['address'][i];
                    Orders[i].Dentistphonenumber = data['phone'][i];
                    Orders[i].Dentistemail = data['email'][i];
                  }
                });
                present = present + perPage;
              })
        ],
      ),
      //_page ==0 ? PendingRequests(): _page==1 ? StoresPage() : _page==2 ? DeliveriesPage():Container()
      body: _page == 0
          ? NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollinfo) {
                if (scrollinfo.metrics.pixels ==
                    scrollinfo.metrics.maxScrollExtent) loadmore();
                return true;
              },
              child: ListView(
                  shrinkWrap: true,
                  children: List.generate(OrdersNumber == 0 ? 0 : OrdersNumber,
                      (index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => OrderScreen(
                                    Orders[index].DentistFName,
                                    Orders[index].DentistLName,
                                    Orders[index].Dentistphonenumber,
                                    Orders[index].DentistAddress,
                                    Orders[index].TotalCost,
                                    Orders[index].OrderID,
                                    Orders[index].Dentistemail)));
                          },
                          title: Text(
                              Orders[index].DentistFName == "" &&
                                      Orders[index].DentistLName == ""
                                  ? ""
                                  : 'Dr. ' +
                                      Orders[index].DentistFName +
                                      " " +
                                      Orders[index].DentistLName,
                              style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w700)),
                          subtitle: Text(Orders[index].DentistAddress == ""
                              ? ""
                              : Orders[index].DentistAddress),
                          leading: Text(Orders[index].OrderID == ""
                              ? ""
                              : 'no.' + Orders[index].OrderID),
                          trailing: Text(
                              Orders[index].TotalCost == ""
                                  ? ""
                                  : Orders[index].TotalCost + 'EGP',
                              style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w800)),
                        ),
                        // child: Row(
                        //   children: [
                        //     Column(
                        //       children: [
                        //         Text(
                        //           Orders[index].DentistFName == "" &&
                        //               Orders[index].DentistLName == ""
                        //               ? ""
                        //               : 'Dr. ' +
                        //               Orders[index].DentistFName +
                        //               " " +
                        //               Orders[index].DentistLName,
                        //           style: TextStyle(
                        //               fontSize: 15, fontFamily: "Montserrat",fontWeight: FontWeight.bold),
                        //           textAlign: TextAlign.start,
                        //         ),
                        //         SizedBox(height: 10.0),
                        //         Text(
                        //           Orders[index].DentistAddress,
                        //           style: TextStyle(
                        //               fontSize: 15, fontFamily: "Montserrat"),
                        //           textAlign: TextAlign.start,
                        //         ),
                        //       ],
                        //     ),
                        //     // SizedBox(width: 50.0),
                        //     Expanded(
                        //       child: Align(
                        //         child: Container(
                        //           alignment: Alignment.centerRight,
                        //           child: Text(
                        //             Orders[index].TotalCost == ""
                        //                 ? ""
                        //                 : Orders[index].TotalCost + 'EGP',
                        //             style: TextStyle(
                        //                 fontSize: 40,
                        //                 color: Colors.blueGrey[800],
                        //                 fontFamily: "Montserrat"),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ),
                    );
                  })),
            )
          : _page == 1
              ? NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollinfo) {
                    if (scrollinfo.metrics.pixels ==
                        scrollinfo.metrics.maxScrollExtent) loadmore();
                    return true;
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(

                    ),
                  ),
                )
              : Container(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueGrey[800]),
              child: Column(
                children: [
                  Text(
                    'Welcome to Dentista',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat",
                        color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.blueGrey,
                    ),
                  ),
                  Obx(()=> Text(
                      deliveryController.fname.value +
                          ' ' +
                          deliveryController.lname.value,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat",
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text(
                'My Acount',
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold),
              ),
              onTap: () async {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Delivery_Profile()));
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                'Settings',
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DeliverySettings()));
              },
            ),
            ListTile(
              leading: Icon(Icons.credit_card),
              title: Text(
                'My Credit Card',
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text(
                'Sign Out',
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MainScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
