import 'package:dentista/Manager%20Screens/RequestInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PendingTile extends StatelessWidget {
  final String Name;
  final String Type;
  final String Photourl;
  PendingTile({this.Name , this.Type , this.Photourl});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>RequestInfo()));
        },
        title: Text(Name , style: TextStyle(fontWeight: FontWeight.w700 , fontFamily: 'montserrat'),),
        subtitle: Text(Type,style: TextStyle(fontWeight: FontWeight.w500 , fontFamily: 'montserrat')),
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.blueGrey,
        ),
        
      ),
    );
  }
}
