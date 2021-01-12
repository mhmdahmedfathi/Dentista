import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dentista/Authentication/AuthController.dart';
import 'package:dentista/Chat/Chatroom.dart';
import 'package:dentista/Manager%20Screens/DeliveriesPage.dart';
import 'package:dentista/Manager%20Screens/Manager_Account_Details.dart';
import 'package:dentista/Manager%20Screens/PendingRequests.dart';
import 'package:dentista/Manager%20Screens/StorePendingRequests.dart';
import 'package:dentista/Manager%20Screens/StoresPage.dart';
import 'package:dentista/Screens_Handler/mainscreen.dart';
import 'package:dentista/UsersControllers/ManagerController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ManagerHome extends StatefulWidget {
  @override
  _ManagerHomeState createState() => _ManagerHomeState();
}

class _ManagerHomeState extends State<ManagerHome> {
  final ManagerController managerController = Get.put(ManagerController());
  final AuthController authController = Get.put(AuthController());
  int _page=0;

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
                Icon(Icons.pending_actions_outlined, size: 30,color: Colors.white),
                Text("Deliveries" , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10,color: Colors.white),)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.pending_actions_outlined, size: 30,color: Colors.white),
                Text("Stores" , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10,color: Colors.white),)
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
      body:  _page ==0 ? PendingRequests(): _page==1 ? StorePendingRequests() :_page==2 ? StoresPage() : _page==3 ? DeliveriesPage():Container(
        color: Colors.deepPurpleAccent,
      ),
      drawer: Drawer(

        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Obx(() =>DrawerHeader(
              child: Column(
                children: [
                  Text("Welcome to Dentista",
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
                            image: NetworkImage('https://googleflutter.com/sample_image.jpg'),
                            fit: BoxFit.fill
                        ),
                      ),
                    ),
                  ),
                  Text(managerController.MFname.value + " " + managerController.MLname.value,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat",
                        color: Colors.white

                    ),)
                ],
              ),
              decoration: BoxDecoration(color: Colors.blueGrey),
            )
            ),
            ListTile(
              leading: Icon(Icons.account_circle_rounded),
              title: Text('Account Details',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat"
                ),
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ManagerAccountDetails()));
              },
            ),

            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sign Out',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat"
                ),
              ),
              onTap: (){
                authController.ResetStorage();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainScreen()));
              },
            ),
          ],
        ),

      ),
    );
  }
}
