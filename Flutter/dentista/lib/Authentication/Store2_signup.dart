import 'package:dentista/Models/AuthButtons.dart';
import 'package:dentista/Models/AuthenticationFields.dart';
import 'package:dentista/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dentista/Authentication/Store_Signup.dart';

void main() => runApp(MaterialApp(

home:Store2signup(),
));

class Store2signup extends StatefulWidget {
  @override
  _Store2signupState createState() => _Store2signupState();
}

class _Store2signupState extends State<Store2signup> {
  final _formKey = GlobalKey<FormState>(); // Used to validating the form
  String zip= "";
  String City= "";
  String Region= "";
  String Address= "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          SafeArea(
              child: Container(
                color: Colors.grey[200],
                padding: EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello",
                      style: TextStyle(
                          fontSize: 60.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat"),
                    ),
                    Row(
                      children: [
                        Text(
                          "Store Owner",
                          style: TextStyle(
                            fontSize: 60.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ".",
                          style: TextStyle(
                              fontSize: 60.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                      ],
                    )

                  ],
                ),
              )),
          Expanded(
              child:
              Container(
                padding: EdgeInsets.only(left: 30, right: 30, top: 20),
                  child: SingleChildScrollView(
                    child: Form(
          key: _formKey,
          child: Column(
              children: [
          TextFormField(
          decoration: authDecoration("City"),
          onChanged: (val) {
            setState(() {
              City=(val);
            });
          },
          validator: (val) {
            return val.isEmpty
                ? "Please Enter Your City"
                : null;
          },
        ),
        SizedBox(height: 20.0),
        TextFormField(
          decoration: authDecoration("Region"),
          onChanged: (val) {
            setState(() {
              Region=(val);
            });
          },
          validator: (val) {
            return val.isEmpty ? "Please Enter Region" : null;
          },
        ),
        SizedBox(height: 20),
        TextFormField(
          decoration: authDecoration("ZIP Number"),
          onChanged: (val) {
            setState(() {
              zip=(val) ;
            });
          },
          validator: (val) {
            if (val.isEmpty)
              return "Please Enter Your ZIP Number";
            else
              return null;
          },
        ),
        SizedBox(height: 20.0),
        TextFormField(
          decoration: authDecoration("Address"),
          onChanged: (val) {
            setState(() {
              Address=(val);
            });
          },
          validator: (val) {
            return val.isEmpty ? "Please Enter Your Address" : null;
          },
        ),


              ],
          ))
      ),
        
        
      )
    ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                child:GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context)=>Store2signup()  ));


                        //if condition to check if the all inputs are valid
                        if (_formKey.currentState.validate())
                        {
                          //For Testing only
                          //backend code should be written here

                          print("Done");
                        }
                      },
                      child: drawButton(
                          "Add new bransh",
                          Colors.green
                      ),
                    ),
    ),
                SizedBox(width: 2.0),
                   GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context)=>StoreSignUp()));
                    },
                    child: drawButton(
                        "Back to Prev page",
                        Colors.grey
                    ),
                  ),

                SizedBox(width: 2.0),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                child:GestureDetector(

                  onTap: () {

                    //if condition to check if the all inputs are valid
                    if (_formKey.currentState.validate())
                    {
                      //For Testing only
                      //backend code should be written here

                      print("Done");
                    }
                  },
                  child: drawButton(
                      "Sign up",
                      Colors.green
                  ),
                ),
    )


              ],
            ),
          )

        ]
    ));
  }
}


