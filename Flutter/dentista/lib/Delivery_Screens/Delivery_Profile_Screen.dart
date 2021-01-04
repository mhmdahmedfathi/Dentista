import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dentista/Delivery_Screens/DeliveryHome.dart';

class Delivery_Profile extends StatefulWidget {
  final String Deliveryfname;
  final String Deliverylname;
  final String Deliveryemail;
  final String Deliveryarea;
  final String Deliveryphone;
  final String DeliveryID;
  final String DeliveryVLicense;
  final String DeliveryVModel;
  final String DeliveryRate;

  Delivery_Profile(
      this.Deliveryfname,
      this.Deliverylname,
      this.Deliveryemail,
      this.Deliveryarea,
      this.Deliveryphone,
      this.DeliveryID,
      this.DeliveryVLicense,
      this.DeliveryVModel,
      this.DeliveryRate);
  @override
  _Delivery_ProfileState createState() => _Delivery_ProfileState(
      Deliveryfname,
      Deliverylname,
      Deliveryemail,
      Deliveryarea,
      Deliveryphone,
      DeliveryID,
      DeliveryVLicense,
      DeliveryVModel,
      DeliveryRate);
}

class _Delivery_ProfileState extends State<Delivery_Profile> {
  String fname = "";
  String lname = "";
  String email = "";
  String phone = "";
  String area = "";
  String ID = "";
  String vechilemodel = "";
  String vechilelicense = "";
  String rate = "";

  _Delivery_ProfileState(this.fname, this.lname, this.email, this.area,
      this.phone, this.ID, this.vechilelicense, this.vechilemodel, this.rate);

  @override
  void initState() {
    super.initState();
    asyncmethod();
  }

  void asyncmethod() async {
    final DeliveryProfileDataResponse =
        await http.post('http://10.0.2.2:5000/delivery_Profile',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({'email': email}));
    final DeliveryProfileData = json.decode(DeliveryProfileDataResponse.body);

    phone = DeliveryProfileData['phone'];
    ID = DeliveryProfileData['ID'].toString();
    vechilemodel = DeliveryProfileData['VModel'];
    vechilelicense = DeliveryProfileData['VLicense'];
    rate = DeliveryProfileData['rate'].toString();
  }

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
            Container(
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
                        Text("Name ",
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                letterSpacing: 1.3,
                                fontFamily: 'montserrat')),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                child: Text(fname + " " + lname,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        letterSpacing: 1.3,
                                        fontFamily: 'montserrat')),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(Icons.alternate_email),
                        SizedBox(width: 20),
                        Text("Email ",
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                letterSpacing: 1.3,
                                fontFamily: 'montserrat')),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                child: Text(email,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        letterSpacing: 1.3,
                                        fontFamily: 'montserrat')),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(Icons.phone_android),
                        SizedBox(width: 20),
                        Text("Phone Number ",
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                letterSpacing: 1.3,
                                fontFamily: 'montserrat')),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                child: Text(phone,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        letterSpacing: 1.3,
                                        fontFamily: 'montserrat')),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(Icons.perm_identity),
                        SizedBox(width: 20),
                        Text("Delivery ID ",
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                letterSpacing: 1.3,
                                fontFamily: 'montserrat')),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                child: Text(ID,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        letterSpacing: 1.3,
                                        fontFamily: 'montserrat')),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(Icons.location_on),
                        SizedBox(width: 20),
                        Text("Area ",
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                letterSpacing: 1.3,
                                fontFamily: 'montserrat')),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                child: Text(area,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        letterSpacing: 1.3,
                                        fontFamily: 'montserrat')),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(Icons.card_membership),
                        SizedBox(width: 20),
                        Text("Vehicle License ",
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                letterSpacing: 1.3,
                                fontFamily: 'montserrat')),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                child: Text(vechilelicense,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        letterSpacing: 1.3,
                                        fontFamily: 'montserrat')),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(Icons.local_shipping),
                        SizedBox(width: 20),
                        Text("Vehicle Model ",
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                letterSpacing: 1.3,
                                fontFamily: 'montserrat')),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                child: Text(vechilemodel,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        letterSpacing: 1.3,
                                        fontFamily: 'montserrat')),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
