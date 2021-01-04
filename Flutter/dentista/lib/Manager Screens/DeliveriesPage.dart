import 'package:dentista/Manager%20Screens/ViewTile.dart';
import 'package:flutter/material.dart';

class DeliveriesPage extends StatefulWidget {
  @override
  _DeliveriesPageState createState() => _DeliveriesPageState();
}

class _DeliveriesPageState extends State<DeliveriesPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context , index){
      return ViewTile(storeDeliveryName: "Delivery Name",productesDelivers: "0",type: 1,);
    },
    itemCount: 20,
    );
  }
}
