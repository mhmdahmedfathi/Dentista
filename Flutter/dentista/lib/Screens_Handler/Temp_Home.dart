///////////////////////////////////////////////////////////////////////////
//This Screen Should be removed later
// this screen appears when the user is already logged in to app
// So instead of it when should show the home screen depending on user type
////////////////////////////////////////////////////////////////////////////

import 'package:flutter/material.dart';
import 'package:dentista/Screens_Handler/mainscreen.dart';

class TempHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dentista" , style: TextStyle(color: Colors.black),),

      ),
        body: RaisedButton(
          child: Text('Back'),
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainScreen()));
          },
        )
    );
  }
}
