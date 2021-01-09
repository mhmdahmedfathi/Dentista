import 'dart:convert';
import 'package:dentista/Delivery_Screens/DeliveryChat.dart';
import 'package:dentista/UsersControllers/OrderController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dentista/Delivery_Screens/DeliveryHome.dart';
import 'package:http/http.dart' as http;
import 'package:dentista/utility_class/Product.dart';
import 'package:dentista/Models/AuthButtons.dart';
import 'package:dentista/Models/Alerts.dart';
import 'package:get/get.dart';
import 'package:dentista/UsersControllers/DeliveryController.dart';

class OrderScreen extends StatefulWidget {
  final indexorder;
  OrderScreen(this.indexorder);
  @override
  _OrderScreenState createState() => _OrderScreenState(indexorder);
}

class _OrderScreenState extends State<OrderScreen> {
  final DeliveryController deliveryController = Get.put(DeliveryController());
  final OrderController orderController =Get.put(OrderController());

  int indexorder;
  int present = 20;
  int perPage = 20;

  // String dentistfname;
  // String dentistlname;
  // String dentistphone;
  // String dentistemail;
  // String dentistaddress;
  // String ordertotal;
  // String orderid;
   int totalproductsnumber = 0;
  //
   List<Product> Products;

  _OrderScreenState(this.indexorder);

  @override
  void initState() {
    super.initState();
    asyncmethod();
  }

  void asyncmethod() async {
    orderController.onInit();
    final OrderData =
        await http.post('http://10.0.2.2:5000/delivery_getordersproducts',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({'orderid': orderController.Orders[indexorder].OrderID}));

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
            Stack(
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
                  padding: EdgeInsets.only(top: 140,left: 250),
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: IconButton(
                        icon: Icon(Icons.chat),
                      onPressed: (){

                        },
                    )
                  ),
                )
            ]
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
                            'Name:  Dr. ' + orderController.Orders[indexorder].DentistFName + ' ' + orderController.Orders[indexorder].DentistLName,
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.3),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            "Phone Number: " + orderController.Orders[indexorder].Dentistphonenumber,
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.3),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            "Email: " + orderController.Orders[indexorder].Dentistemail,
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.3),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            "Address: " + orderController.Orders[indexorder].DentistAddress,
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
                            children:
                                List.generate(totalproductsnumber, (index) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Text(
                                      Products[index].productnumber,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Montserrat"),
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(width: 20.0),
                                    Expanded(
                                      child: Text(
                                        Products[index].productname,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: "Montserrat"),
                                        textAlign: TextAlign.start,
                                      ),
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
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 15),
              child: Container(
                width: 500,
                height: 40,
                child: RaisedButton(
                  color: Colors.blueGrey[400],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black87)),
                  child: Text(
                    "Deliver",
                    style: TextStyle(
                      fontFamily: 'montserrat',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () async {
                    final result = await http.post(
                        'http://10.0.2.2:5000/delivery_assignorder',
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: json.encode({
                          'DELIVERYID': deliveryController.ID.value,
                          'ORDERID': orderController.Orders[indexorder].OrderID,
                          'no.Dorders': (int.parse(deliveryController
                                      .NumberOfOrders.value) +
                                  1)
                              .toString()
                        }));
                    String assigningresult = result.body;
                    if (assigningresult == "0") {
                      Alert(context, "This order is already assigned", "",
                          message2: "");
                    } else {
                      Alert(context, "This order is assigned to you",
                          "You can't assign order untill you deliver this order",
                          message2: "");
                      deliveryController.IncDordersNumber();
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
