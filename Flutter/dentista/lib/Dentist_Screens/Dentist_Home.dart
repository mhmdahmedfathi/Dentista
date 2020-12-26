import 'package:flutter/material.dart';
import 'package:dentista/Screens_Handler/mainscreen.dart';
class DentistHome extends StatefulWidget {
  final String fname;
  final String lname;
  final String email;
  DentistHome(this.fname, this.lname, this.email);
  @override
  _DentistHomeState createState() => _DentistHomeState(fname, lname, email);
}


class _DentistHomeState extends State<DentistHome> {
  int products = 20;
  int present = 20;
  int perPage = 20;
  List<bool> fav = List<bool>.generate(20, (index) => false);


  String email;
  String fname = "";
  String lname = "";
  _DentistHomeState(this.fname, this.lname, this.email);

  @override
  void initState() {
    super.initState();
    setState(() {
      for (int i = 0; i<20; i++)
        {
         fav.add(false);
        }
      present = present + perPage;
    });
  }

  void loadMore() {
    setState(() {
      for (int i = 0; i<20; i++)
      {
        fav.add(false);
      }
      present = present + perPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Dentista',
          style: TextStyle(
              fontSize: 30,
              fontFamily: "Montserrat"
          ),
          textAlign: TextAlign.left,
        ),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: (){}, color: Colors.white,),
          IconButton(icon: Icon(Icons.add_shopping_cart_outlined), onPressed: (){},color: Colors.white)
        ],
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification ScrollInfo){
          if (ScrollInfo.metrics.pixels == ScrollInfo.metrics.maxScrollExtent)
            {
              loadMore();
            }
          return true;
        }
        ,child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
          shrinkWrap: true,
          children: List.generate(present, (index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: (){},
                child: Card(
                  child: Column(
                    children: [
                      Text('Product Name',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.deepPurpleAccent,
                            fontFamily: "Montserrat"
                        ),

                      )
                      ,
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage('https://googleflutter.com/sample_image.jpg'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius:
                            BorderRadius.all(Radius.circular(20.0),),
                          ),
                        ),

                      ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text('15EGP',
                                  style: TextStyle(

                                      fontSize: 15,
                                      fontFamily: "Montserrat"
                                  ),
                                  textAlign: TextAlign.left,

                                ),
                              ),
                              SizedBox(width: 60,),
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  alignment: Alignment.centerRight,
                                  icon: Icon(Icons.star, color: !fav[index] ? Colors.grey: Colors.amber, ),

                                  onPressed: (){setState(() {
                                    fav[index] = !fav[index];
                                  });},
                                ),
                              )
                            ],
                          ),
                        ),

                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Offer',
                            style: TextStyle(

                                fontSize: 15,
                                fontFamily: "Montserrat"
                            ),
                            textAlign: TextAlign.left,

                          ),
                        ),
                      )
                    ],
                  ),

                ),
              )
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
                  Text(fname + " " + lname,
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
              leading: Icon(Icons.star),
              title: Text('Favorites',
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

    