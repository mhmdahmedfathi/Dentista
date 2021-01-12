import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Map> GetRequestInfo(int ID)
async{
  var response = await http.post('http://10.0.2.2:5000/get_Delivery_info',
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        "DID" : ID
      })
  );
  return json.decode(response.body);
}


Future<Map> GetRequestInfoStore(int ID)
async{
  var response = await http.post('http://10.0.2.2:5000/pending_store_info',
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        "SID" : ID
      })
  );
  return json.decode(response.body);
}

Future<Map> GetRequestInfoStorebranches(int ID)
async{
  var response = await http.post('http://10.0.2.2:5000/store_branches',
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        "SID" : ID
      })
  );
  return json.decode(response.body);
}

Future<Map> GetProductsCount(int ID)
async{
  var response = await http.post('http://10.0.2.2:5000/products_count',
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        "SID" : ID
      })
  );
  return json.decode(response.body);
}

Future<Map> GetDorders(int ID)
async{
  var response = await http.post('http://10.0.2.2:5000/total_doreders',
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        "DID" : ID
      })
  );
  return json.decode(response.body);
}