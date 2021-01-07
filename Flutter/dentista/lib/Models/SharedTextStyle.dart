import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

TextStyle requestInfoStyle ({Color color=Colors.black87 , double size = 18})
{
  return TextStyle(
    color: color,
    fontWeight: FontWeight.bold,
    fontSize: size,
    letterSpacing: 1.3,
    fontFamily: 'montserrat'
  );
}