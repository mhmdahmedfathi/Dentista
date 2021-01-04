import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dentista/Delivery_Screens/DeliveryHome.dart';
import 'package:http/http.dart' as http;
import 'package:dentista/utility_class/Product.dart';
import 'package:dentista/Models/AuthButtons.dart';
import 'package:dentista/Models/Alerts.dart';

class OrderScreen extends StatefulWidget {
  final String dentistfname;
  final String dentistlname;
  final String dentistphone;
  final String dentisemail;
  final String dentistaddress;
  final String ordertotal;
  final String orderid;
  final String deliveryid;
  OrderScreen(
      this.dentistfname,
      this.dentistlname,
      this.dentistphone,
      this.dentistaddress,
      this.ordertotal,
      this.orderid,
      this.deliveryid,
      this.dentisemail);
  @override
  _OrderScreenState createState() => _OrderScreenState(
      dentistfname,
      dentistlname,
      dentistphone,
      dentistaddress,
      ordertotal,
      orderid,
      deliveryid,
      dentisemail);
}

class _OrderScreenState extends State<OrderScreen> {
  int present = 20;
  int perPage = 20;

  String dentistfname;
  String dentistlname;
  String dentistphone;
  String dentistemail;
  String dentistaddress;
  String ordertotal;
  String orderid;
  String deliveryid;
  int totalproductsnumber = 0;

  List<Product> Products;

  _OrderScreenState(
      this.dentistfname,
      this.dentistlname,
      this.dentistphone,
      this.dentistaddress,
      this.ordertotal,
      this.orderid,
      this.deliveryid,
      this.dentistemail);

  @override
  void initState() {
    super.initState();
    asyncmethod();
  }

  void asyncmethod() async {
    final OrderData =
        await http.post('http://10.0.2.2:5000/delivery_getordersproducts',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({'orderid': orderid}));

    final data = json.decode(OrderData.body);

    totalproductsnumber = data['no.products'][0];
    Products =
        List<Product>.generate(totalproductsnumber, (index) => Product());
    setState(() {
      for (int i = 0; i < totalproductsnumber; i++) {
        Products[i].productid = data['productid'][i].toString();
        Products[i].productname = data['productname'][i];
        Products[i].productprice = data['productprice'][i].toString();
        Products[i].productnumber = data['no.units'][i].toString();
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
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
        title: Text(
          'Dentista',
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 500,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Name:  Dr. ' + dentistfname + ' ' + dentistlname,
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.3),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            "Phone Number: " + dentistphone,
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.3),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            "Email: " + dentistemail,
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.3),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            "Address: " + dentistaddress,
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.3),
                            textAlign: TextAlign.end,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 500,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Purchase List",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.3),
                      textAlign: TextAlign.end,
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 500,
                          height: 470,
                          child: Card(
                              child: ListView(
                            shrinkWrap: true,
                            children: List.generate(totalproductsnumber, (index) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Text(
                                      Products[index].productnumber,
                                      style: TextStyle(
                                          fontSize: 15, fontFamily: "Montserrat"),
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(width: 20.0),
                                    Text(
                                      Products[index].productname,
                                      style: TextStyle(
                                          fontSize: 15, fontFamily: "Montserrat"),
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(width: 10.0),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          child: Text(
                                            Products[index].productprice,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: "Montserrat"),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 500,
                child: GestureDetector(
                  onTap: () async {
                    final result = await http.post(
                        'http://10.0.2.2:5000/delivery_assignorder',
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: json.encode(
                            {'DELIVERYID': deliveryid, 'ORDERID': orderid}));
                    String assigningresult = result.body;
                    if (assigningresult == "0") {
                      Alert(context, "This order is already assigned", "",
                          message2: "");
                    } else {
                      Alert(context, "This order is assigned to you",
                          "You can't assign order untill you deliver this order",
                          message2: "");
                    }
                  },
                  child: drawButton('Deliver', Colors.blueGrey[800]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
