
import 'package:dentista/Authentication/AuthController.dart';
import 'package:dentista/Screens_Handler/mainscreen.dart';
import'package:dentista/Store Screens/Store_Home.dart';
import 'package:dentista/Store%20Screens/Store_Home.dart';
import 'package:dentista/UsersControllers/Store_DentistChatController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import'package:get/get.dart';

class Dentist_Chat extends StatefulWidget {
  @override
  _Dentist_ChatState createState() => _Dentist_ChatState();
}


class _Dentist_ChatState extends State<Dentist_Chat> {

  final Store_DentistChat ChatController = Get.put(Store_DentistChat());
  final AuthController authController = Get.put(AuthController());
  @override
  void initState() {
    super.initState();
    setState(() {
      ChatController.onInit();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Avaliable Chats',
          style: TextStyle(
              fontSize: 30,
              fontFamily: "Montserrat"
          ),
          textAlign: TextAlign.left,
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              color: Colors.white,
              onPressed: () async {
                setState(() {
                  ChatController.onInit();
                });

              }),
        ],

        backgroundColor: Colors.blueGrey[800],
      ),

      body: NotificationListener<ScrollNotification>(
        child:GridView.count(
          crossAxisCount: 2,
          children: List.generate(ChatController.DentistChats.value , (index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                child:  ListTile(
                    onTap: () {
                    },
                    title: Obx(
                          () => Text(
                        ChatController.Dentist[index],
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.deepPurpleAccent,
                            fontFamily: "Montserrat"
                        ),
                      ),

                    )
                ),

              ),

            );
          },
          ),

        ),
      ),
      drawer: Drawer(

        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
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
                  Text( authController.StoreName,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat",
                        color: Colors.white

                    ),)
                ],
              ),
              decoration: BoxDecoration(color: Colors.blueGrey),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Return Back',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat"
                ),
              ),
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>StoreHome()));
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
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainScreen()));
              },
            ),
          ],
        ),

      ),
    );
  }
}