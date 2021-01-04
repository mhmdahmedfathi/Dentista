import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dentista/Manager%20Screens/DeliveriesPage.dart';
import 'package:dentista/Manager%20Screens/PendingRequests.dart';
import 'package:dentista/Manager%20Screens/StoresPage.dart';
import 'package:flutter/material.dart';

class ManagerHome extends StatefulWidget {
  final Fname;
  final Lname;
  final Email;
  ManagerHome({this.Fname , this.Lname ,this.Email});
  @override
  _ManagerHomeState createState() => _ManagerHomeState(Fname , Lname,Email);
}

class _ManagerHomeState extends State<ManagerHome> {
  final Fname;
  final Lname;
  final Email;
  int _page=0;
  _ManagerHomeState(this.Fname , this.Lname ,this.Email);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        buttonBackgroundColor: Colors.grey,
        height: 50,
        color: Colors.blueGrey[800],
        backgroundColor: Colors.white,
        items: <Widget>[
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.timer, size: 30,color: Colors.white),
                Text("Pending" , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10,color: Colors.white),)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.store_mall_directory_outlined, size: 30,color: Colors.white),
                Text("Stores" , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10,color: Colors.white),)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.delivery_dining, size: 30,color: Colors.white),
                Text("Deliveries" , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 10,color: Colors.white),)
              ],
            ),
          ),

        ],
        onTap: (val){
          setState(() {
            _page = val;
          });
        },
      ),
      appBar: AppBar(
        centerTitle: false,
        title: Text("DENTISTA" , style: TextStyle(
fontFamily: 'montserrat',
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
        ),
        backgroundColor:Colors.blueGrey[800],
      ),
      body:  _page ==0 ? PendingRequests(): _page==1 ? StoresPage() : _page==2 ? DeliveriesPage():Container(),
    );
  }
}
