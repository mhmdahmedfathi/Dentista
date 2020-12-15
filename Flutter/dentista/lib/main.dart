import 'package:flutter/material.dart';

void main ()
{
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      appBarTheme: AppBarTheme(
        centerTitle: true,
        color: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey[500]),
      ),
      iconTheme: IconThemeData(color: Colors.grey[500]),
      buttonColor: Colors.grey[350],
      textTheme: TextTheme(
        caption: TextStyle(
          color: Colors.grey[800],
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
        button: TextStyle(
          color: Colors.grey[400],
          letterSpacing: 1.1
        )
      ),
    ),
    home: Home(),
  ),
  );
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
