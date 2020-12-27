import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dentista/Screens_Handler/mainscreen.dart';
import 'package:http/http.dart' as http;
import 'package:dentista/Delivery_Screens/Order.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeliveryHome extends StatefulWidget {
  final String fname;
  final String lname;
  final String email;
  final String area;
  final String ID;
  DeliveryHome(this.fname, this.lname, this.email, this.area, this.ID);
  @override
  _DeliveryHomeState createState() =>
      _DeliveryHomeState(fname, lname, email, area, ID);
}

class _DeliveryHomeState extends State<DeliveryHome> {
  int OrdersNumber = 0;
  int present = 20;
  int perPage = 20;
  List<Order> Orders = List<Order>.generate(20, (index) => Order());

  String fname = "";
  String lname = "";
  String email = "";
  String area = "";
  String ID ="";

  _DeliveryHomeState(this.fname, this.lname, this.email, this.area, this.ID);

  @override
  void initState() {
    super.initState();
    asyncmethod();
  }

  void asyncmethod() async{
    final OrderData = await http.post(
        'http://10.0.2.2:5000/delivery_getavailableorder',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({'area': area}));

    final data = json.decode(OrderData.body);

    OrdersNumber = data['no.orders'][0];
    setState(() {
      for (int i = 0; i < OrdersNumber; i++) {
        Orders[i].DentistFName = data['dentistfname'][i];
        Orders[i].DentistLName = data['dentistlname'][i];
        Orders[i].OrderID = data['orderid'][i].toString();
        Orders[i].TotalCost = data['ordertotal'][i].toString();
      }
    });
    present = present + perPage;
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
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
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
                    body: json.encode({'area': area}));

                final data = json.decode(OrderData.body);

                OrdersNumber = data['no.orders'][0];
                setState(() {
                  for (int i = 0; i < OrdersNumber; i++) {
                    Orders[i].DentistFName = data['dentistfname'][i];
                    Orders[i].DentistLName = data['dentistlname'][i];
                    Orders[i].OrderID = data['orderid'][i].toString();
                    Orders[i].TotalCost = data['ordertotal'][i].toString();
                  }
                });
                present = present + perPage;
              })
        ],
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollinfo) {
          if (scrollinfo.metrics.pixels == scrollinfo.metrics.maxScrollExtent)
            loadmore();
          return true;
        },
        child: GridView.count(
            crossAxisCount: 1,
            crossAxisSpacing: 20.0,
            mainAxisSpacing: 20.0,
            shrinkWrap: true,
            children:
                List.generate(OrdersNumber == 0 ? 1 : OrdersNumber, (index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () {},
                  child: Card(
                    child: Column(
                      children: [
                        Text(
                          Orders[index].OrderID==""?"":'Order Number',
                          style:
                              TextStyle(fontSize: 15, fontFamily: "Montserrat"),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          Orders[index].OrderID,
                          style:
                              TextStyle(fontSize: 15, fontFamily: "Montserrat"),
                          textAlign: TextAlign.end,
                        ),
                        SizedBox(height: 20.0),
                        Text(
                            Orders[index].DentistFName == "" && Orders[index].DentistLName =="" ? "":
                            'Dr. ' + Orders[index].DentistFName + " " + Orders[index].DentistLName,
                            style: TextStyle(
                                fontSize: 15, fontFamily: "Montserrat")),
                        SizedBox(height: 20.0),
                        Text(
                          Orders[index].TotalCost == "" ? "": Orders[index].TotalCost + 'EGP',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.deepPurpleAccent,
                              fontFamily: "Montserrat"),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            })),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent
              ),
              child: Column(
                children: [
                  Text(
                      'Welcome to Dentista',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat",
                        color: Colors.white
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(''),
                            fit: BoxFit.fill
                        ),
                      ),
                    ),
                  ),
                  Text(
                      fname+ ' '+lname,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat",
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text(
                'About',
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {},
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
              onTap: () {},
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
