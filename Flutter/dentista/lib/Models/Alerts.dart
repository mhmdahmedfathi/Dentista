import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> Alert(
    BuildContext context, String message_title, String message_content,
    {String message2 = "You can either try another one, or sign in"}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(message_title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message_content),
              Text(message2),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> UpdateAlert(BuildContext context, String attributename,
    String UpdatedAttribute, String initialvalue, String Key) async {
  String UpdatedValue = initialvalue;
  showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Edit my "+attributename),
        content: SingleChildScrollView(
          child: Form(
            child: TextFormField(
              initialValue: initialvalue,
              onChanged: (val) {
                UpdatedValue = val;
              },
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
              child: Text('OK'),
              onPressed: () async {
                if (UpdatedAttribute == "VECHILE_LICENCE") {
                  final response = await http.post(
                      'http://10.0.2.2:5000/delivery_license_validation',
                      headers: <String, String>{
                        'Content-Type':
                        'application/json; charset=UTF-8',
                      },
                      body: json.encode({'license': UpdatedValue}));
                  if (response.body != "0") {
                    if (UpdatedValue.isEmpty == false &&
                        UpdatedValue.length > 8) {
                      await http.post(
                          'http://10.0.2.2:5000/delivery_UpdateData',
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body: json.encode({
                            'Updatedvalue': UpdatedValue,
                            'Updateattribute': UpdatedAttribute,
                            'ID': Key
                          }));
                      Navigator.of(context).pop();
                    }
                    else {
                      Navigator.of(context).pop();
                    }
                  }
                  else
                  {
                    Navigator.of(context).pop();
                  }
                }
                else if (UpdatedAttribute == "Delivery_PHONE_NUMBER") {
                  final response = await http.post(
                      'http://10.0.2.2:5000/delivery_phone_validation',
                      headers: <String, String>{
                        'Content-Type':
                        'application/json; charset=UTF-8',
                      },
                      body: json.encode({'phone': UpdatedValue}));
                  print(response.body);
                  if (response.body != "0") {
                    if (UpdatedValue.isEmpty == false) {
                      await http.post(
                          'http://10.0.2.2:5000/delivery_UpdateData',
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body: json.encode({
                            'Updatedvalue': UpdatedValue,
                            'Updateattribute': UpdatedAttribute,
                            'ID': Key
                          }));
                      Navigator.of(context).pop();
                    }
                    else {
                      Navigator.of(context).pop();
                    }
                  }
                  else
                  {
                    Navigator.of(context).pop();
                  }
                }
                else {
                  if (UpdatedValue.isEmpty == false) {
                    await http.post('http://10.0.2.2:5000/delivery_UpdateData',
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: json.encode({
                          'Updatedvalue': UpdatedValue,
                          'Updateattribute': UpdatedAttribute,
                          'ID': Key
                        }));
                    Navigator.of(context).pop();
                  }
                }
              }),
          TextButton(
              child: Text('Cancel'),
              onPressed: () async {
                Navigator.of(context).pop();
              }),
        ],
      );
    },
  );
}
