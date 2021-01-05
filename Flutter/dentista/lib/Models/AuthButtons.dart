import 'package:flutter/material.dart';

Widget drawButton(String text,Color color)
{
  return Container(
    height: 50,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25)
    ),
    child: Center(
      child: Text(text, style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20
      ),
      ),
    ),
  );
}