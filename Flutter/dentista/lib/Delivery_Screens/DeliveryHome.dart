import 'dart:convert';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dentista/Authentication/AuthController.dart';
import 'package:dentista/Chat/Chatroom.dart';
import 'package:dentista/Delivery_Screens/DeliveryReviewScreen.dart';
import 'package:dentista/Models/SharedTextStyle.dart';
import 'package:dentista/UsersControllers/OrderController.dart';
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
  final OrderController orderController = Get.put(OrderController());
  AuthController authController = Get.put(AuthController());
  List Snames = List<dynamic>();
  List IDs = List<dynamic>();
  int _page = 0;
  int OrdersNumber = 0;
  int present = 20;
  int perPage = 20;
  List<Order> Orders;
  List<String> ChatScreenChoices = ["Store", "Manager"];
  String Choice = "";
  _DeliveryHomeState();

  @override
  void initState() {
    super.initState();
    asyncmethod();
  }

  void asyncmethod() async {
    deliveryController.onInit();
    orderController.onInit();
    var response = await http.post('http://10.0.2.2:5000/get_all_stores',
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'MArea' :deliveryController.area.value
        })
    );

    final requests = json.decode(response.body);
    Snames = requests['SNAME'];
    IDs = requests['SID'];
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
                    Icon(Icons.bar_chart, size: 30, color: Colors.white),
                    Text("statistics",
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
                    Icon(Icons.chat, size: 30, color: Colors.white),
                    Text("Store Chat",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: Colors.white))
                  ],
                )),
          ],
          onTap: (val) {
            setState(() {
              _page = val;
            });
          }),
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
        title: Text(
          'Dentista',
          style: TextStyle(
            fontFamily: 'montserrat',
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              color: Colors.white,
              onPressed: () async {
                deliveryController.onInit();
                orderController.onInit();
                  var response = await http.post('http://10.0.2.2:5000/get_all_stores',
                      headers: <String,String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                      },
                      body: json.encode({
                        'MArea' :deliveryController.area.value,
                        'MID': deliveryController.ManagerID.value
                      })
                  );

                  final requests = json.decode(response.body);
                  Snames = requests['SNAME'];
                  IDs = requests['SID'];
                  setState(() {

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
              child: Obx(()=> ListView(
                    shrinkWrap: true,
                    children: List.generate(orderController.numberoforders.value,
                        (index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          color: orderController.Orders[index].Status == "Not Delivered"?  Colors.white: Colors.blueGrey[400],
                          child: ListTile(

                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => OrderScreen(index,orderController.Orders[index].Status=='ASSIGNED'?'Deliver':'ASSIGN')));
                            },
                            title: Obx(
                              () => Text(
                                  orderController.Orders[index].DentistFName ==
                                              "" &&
                                          orderController
                                                  .Orders[index].DentistLName ==
                                              ""
                                      ? ""
                                      : 'Dr. ' +
                                          orderController
                                              .Orders[index].DentistFName +
                                          " " +
                                          orderController
                                              .Orders[index].DentistLName,
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w700)),
                            ),
                            subtitle: Obx(
                              () => Text(orderController
                                          .Orders[index].DentistAddress ==
                                      ""
                                  ? ""
                                  : orderController.Orders[index].DentistAddress),
                            ),
                            leading: Obx(
                              () => Text(
                                  orderController.Orders[index].OrderID == ""
                                      ? ""
                                      : 'no.' +
                                          orderController.Orders[index].OrderID),
                            ),
                            trailing: Obx(
                              () => Text(
                                  orderController.Orders[index].TotalCost == ""
                                      ? ""
                                      : orderController.Orders[index].TotalCost +
                                          'EGP',
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w800)),
                            ),
                          ),
                        ),
                      );
                    })),
              ),
            )
          : _page == 1
              ? SingleChildScrollView(
                  child: Container(
                    child: Column(children: [
                      Center(
                        child: Obx(
                          () => Text(
                            'Number of Delivered Orders: ' +
                                deliveryController.NumberOfOrders.value,
                            style: requestInfoStyle(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Container(
                        child: Card(
                          child: Obx(
                            () => ListView(
                              shrinkWrap: true,
                              children: List.generate(
                                  orderController.DeliveredOrders.length,
                                  (index) {
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Card(
                                    child: ListTile(
                                      onTap: (){
                                      },
                                      title: Obx(
                                        () => Text(
                                            orderController
                                                            .DeliveredOrders[
                                                                index]
                                                            .DentistFName ==
                                                        "" &&
                                                    orderController
                                                            .DeliveredOrders[
                                                                index]
                                                            .DentistLName ==
                                                        ""
                                                ? ""
                                                : 'Dr. ' +
                                                    orderController
                                                        .DeliveredOrders[index]
                                                        .DentistFName +
                                                    " " +
                                                    orderController
                                                        .DeliveredOrders[index]
                                                        .DentistLName,
                                            style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w700)),
                                      ),
                                      leading: Obx(
                                        () => Text(orderController
                                                    .DeliveredOrders[index]
                                                    .OrderID ==
                                                ""
                                            ? ""
                                            : 'no.' +
                                                orderController
                                                    .DeliveredOrders[index]
                                                    .OrderID),
                                      ),
                                      trailing: Obx(
                                              ()=> Text(
                                                orderController.DeliveredOrders[index].Status
                                              )
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                )
              : _page == 2
                  ? NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollinfo) {
          if (scrollinfo.metrics.pixels ==
              scrollinfo.metrics.maxScrollExtent) loadmore();
          return true;
        },
        child: ListView(
            shrinkWrap: true,
            children: List.generate(IDs.length,
                    (index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: ListTile(
                        title:
                             Text(
                                Snames[index],
                              style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w700)),
                        trailing: IconButton(
                          icon: Icon(Icons.chat),
                          onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ChatRoom(
                                    localuserid: authController.UserID,
                                    recevierid: IDs[index],
                                    recevierName:Snames[index],
                                    recevierType:"Store"
                                )));
                          },
                        )
                      ),
                    ),
                  );
                })),
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
                  Obx(
                    () => Text(
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
                'My Account',
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
              leading: Icon(Icons.admin_panel_settings_outlined),
              title: Text(
                'Contact Manager',
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                print(deliveryController.ManagerID.value);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ChatRoom(
                        localuserid: authController.UserID,
                        recevierid: int.parse(deliveryController.ManagerID.value),
                        recevierName: deliveryController.ManagerName.value,
                        recevierType:"Manager"
                    )));
                },
            ),
            ListTile(
              leading: Icon(Icons.rate_review),
              title: Text(
                'Reviews',
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DeliveryReviewsScreen()));
              },
            ),
            // ListTile(
            //   leading: Icon(Icons.credit_card),
            //   title: Text(
            //     'My Credit Card',
            //     style: TextStyle(
            //         fontSize: 20.0,
            //         fontFamily: "Montserrat",
            //         fontWeight: FontWeight.bold),
            //   ),
            //   onTap: () {},
            // ),
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
                authController.ResetStorage();
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
