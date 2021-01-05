
import 'package:flutter/material.dart';

import 'ViewTile.dart';

class StoresPage extends StatefulWidget {
  @override
  _StoresPageState createState() => _StoresPageState();
}

class _StoresPageState extends State<StoresPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context,index)
    {
      return ViewTile(storeDeliveryName: "Store Name",productesDelivers: '0',type: 0,);
    },
      itemCount: 20,
    );
  }
}
