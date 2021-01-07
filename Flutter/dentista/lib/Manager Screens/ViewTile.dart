import 'package:flutter/material.dart';

class ViewTile extends StatelessWidget {
  final String storeDeliveryName;
  final String productesDelivers;
  final  int type;
  String subText;
  ViewTile({this.storeDeliveryName , this.productesDelivers, this.type});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: (){},
        title: Text(storeDeliveryName,style: TextStyle(fontWeight: FontWeight.w700 , fontSize: 18 ,fontFamily: 'montserrat'),),
        subtitle: Text((type==0 ? "Store" : "Delivery")+" ID: "+productesDelivers,style: TextStyle(fontSize: 14,fontFamily: 'montserrat' , fontWeight: FontWeight.w600),),
        trailing: RaisedButton(
          onPressed: (){},
          color: Colors.blueGrey[400],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.black87)
          ),
          child: Text("Statistics" , style: TextStyle( fontFamily: 'montserrat',
            fontWeight: FontWeight.w600,),),
        ),
      ),
    );
  }
}
