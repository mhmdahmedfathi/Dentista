import 'package:dentista/Manager%20Screens/GetRequestInfo.dart';
import 'package:dentista/Manager%20Screens/RequestInfo.dart';
import 'package:dentista/Manager%20Screens/RequestInfoStore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PendingTile extends StatelessWidget {
  final String Name;
  final String Type;
  final int id ;
  final String Photourl;
  final int branch_id;
  Map result = Map();
  PendingTile({this.id,this.Name , this.Type , this.Photourl,this.branch_id});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        onTap: ()async{
          if(Type == "Delivery") {
            result = await GetRequestInfo(id);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RequestInfo(result: result,reqID : id)));

          }
          else{
            result = await GetRequestInfoStore(id);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RequestInfoStore(result: result,reqID : id,branch_id: branch_id,)));

          }
        },
        title: Text(Name , style: TextStyle(fontWeight: FontWeight.w700 , fontFamily: 'montserrat'),),
        subtitle: Text(Type=='Store'?"ID: "+id.toString()+ "     Branch ID :"+branch_id.toString() :  "ID: "+id.toString(),style: TextStyle(fontWeight: FontWeight.w600 , fontFamily: 'montserrat')),
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.blueGrey,
        ),
        
      ),
    );
  }
}
