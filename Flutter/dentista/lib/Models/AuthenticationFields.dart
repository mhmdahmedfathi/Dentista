import 'package:flutter/material.dart';

InputDecoration authDecoration (String hintext, {IconData icon= Icons.edit_outlined})
{
  return InputDecoration(
    suffixIcon: Icon(icon, color: Colors.blueGrey[600],),
    hintText: hintext,
    labelStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: 'Montserrat',
        color: Colors.grey),
    fillColor: Colors.grey[100],
    filled: true,
    contentPadding: EdgeInsets.all(12.0),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[300], width: 2.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blueGrey[600], width: 2.0),
    ),
  );
}
