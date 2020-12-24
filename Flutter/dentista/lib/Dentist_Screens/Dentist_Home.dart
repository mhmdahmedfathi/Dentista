import 'package:flutter/material.dart';
import 'package:dentista/Screens_Handler/mainscreen.dart';
class DentistHome extends StatefulWidget {
  @override
  _DentistHomeState createState() => _DentistHomeState();
}

class _DentistHomeState extends State<DentistHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dentista',
          style: TextStyle(
              fontSize: 40,
              fontFamily: "Montserrat"
          ),
          textAlign: TextAlign.left,
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Text('Hello Dentist'),
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
                  Text('Dentist Name',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat",
                      color: Colors.white

                    ),)
                ],
              ),
              decoration: BoxDecoration(color: Colors.deepPurpleAccent),
            ),
            ListTile(
              leading: Icon(Icons.whatshot_sharp),
              title: Text('About Dentist',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat"
                ),
              ),
              onTap: (){
                // To Move to About Dentista Page
              },
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
                // To Move to About Dentista Page
              },
            ),
            ListTile(
              leading: Icon(Icons.credit_card),
              title: Text('Payment Methods',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat"
                ),
              ),
              onTap: (){
                // To Move to About Dentista Page
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('My Shopping Cart',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat"
                ),
              ),
              onTap: (){
                // To Move to About Dentista Page
              },
            ),
            ListTile(
              leading: Icon(Icons.schedule),
              title: Text('scheduled Orders',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat"
                ),
              ),
              onTap: (){
                // To Move to About Dentista Page
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

    