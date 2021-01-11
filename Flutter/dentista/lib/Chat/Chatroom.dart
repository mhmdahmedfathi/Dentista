import 'dart:async';
import 'dart:convert';
import 'package:dentista/Authentication/AuthController.dart';
import 'package:http/http.dart' as http;
import 'package:dentista/Manager%20Screens/Manager_Home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatRoom extends StatefulWidget {
  int localuserid;
  int recevierid;
  String recevierName;
  String recevierType;
  ChatRoom({this.localuserid,this.recevierid ,this.recevierName,this.recevierType});
  @override
  _ChatRoomState createState() => _ChatRoomState(localuserid: localuserid,recevierName: recevierName,recevierid: recevierid,recevierType: recevierType);
}

class _ChatRoomState extends State<ChatRoom> {
  final ScrollController listscrollcontroller = ScrollController();
  AuthController authController = Get.put(AuthController());
  List messages = List();
  List senderids = List();
  List sendertypes = List();
  int localuserid;
  int Senderid;
  int recevierid;
  String recevierName;
  String recevierType;
  String message;
  Timer _timer;
  _ChatRoomState({this.localuserid,this.recevierid , this.Senderid,this.recevierName,this.recevierType});
  @override
  void initState() {
    ReceiveMessages();

    //Check the server every 5 seconds
    _timer = Timer.periodic(Duration(seconds: 1), (timer) => ReceiveMessages());

    super.initState();
  }

  @override
  void dispose() {
    //cancel the timer
    if (_timer.isActive) _timer.cancel();

    super.dispose();
  }


  Future SendMessage() async{
    var response = await http.post(
      'http://10.0.2.2:5000/send_message',
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        'useronetype': authController.GetType,
        'usertwotype': recevierType,
        'useroneid': localuserid,
        'usertwoid':recevierid,
        'message' : textEditingController.text,
        'senderid': localuserid,
        'sendertype' : authController.GetType,
      })
    );
    textEditingController.clear();
    listscrollcontroller.animateTo(0.0, duration: Duration(microseconds: 300) ,curve:Curves.easeOut);
  }
  TextEditingController textEditingController = TextEditingController();
  Future ReceiveMessages()
  async{
    var response = await http.post(
        'http://10.0.2.2:5000/retrive_message',
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'useronetype': authController.GetType,
          'usertwotype': recevierType,
          'useroneid': localuserid,
          'usertwoid':recevierid,
        })
    );
    var data = json.decode(response.body);

    messages = data['Messages'];
    messages = messages.reversed.toList();
    senderids = data['Sender_id'];
    senderids = senderids.reversed.toList();
    sendertypes = data['Sender_type'];
    sendertypes = sendertypes.reversed.toList();
    setState(() {

    });

  }
  CreateMessage(String msg, int senderidfromdata,String senderTypefromdata)
  {
   return (localuserid == senderidfromdata &&authController.GetType ==senderTypefromdata )? Row(
     mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[

          Container(
            child: Text(
              msg,
              style: TextStyle(color: Colors.white , fontWeight: FontWeight.w500,fontSize: 16),
            ),
            padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            width: 200.0,
            decoration: BoxDecoration(color: Colors.blueGrey[700] , borderRadius: BorderRadius.circular(8.0)),
            margin: EdgeInsets.only(bottom:10.0 , right: 10.0),
          )
        ]
    ):
   Row(
       mainAxisAlignment: MainAxisAlignment.start,
       children: <Widget>[

         Container(
           child: Text(
             msg,
             style: TextStyle(color: Colors.white , fontWeight: FontWeight.w500,fontSize: 16),
           ),
           padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
           width: 200.0,
           decoration: BoxDecoration(color: Colors.blueGrey[300] , borderRadius: BorderRadius.circular(8.0)),
           margin: EdgeInsets.only(bottom:10.0 , right: 10.0),
         )
       ]
   )
   ;
  }
  createInput(){
    return Container(
      child: Row(
        children: [
          Flexible(
              child:Container(
                padding: EdgeInsets.only(left: 10),
                child: TextField(
                  controller: textEditingController,
                  style: TextStyle(color: Colors.black , fontSize: 15.0),

                  decoration: InputDecoration.collapsed(
                    hintText: "Type here ...",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),

                ),
              )
          ),
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                icon: Icon(Icons.send),
                color: Colors.blueGrey,
                onPressed: (){
                  SendMessage();
                },
              ),
              color: Colors.white,
            ),
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  width: 0.5,
                  color: Colors.grey
              )
          ),
          color: Colors.white
      ),
    );
  }
  createMessagesList(){
    return Expanded(
      child: ListView.builder(
        controller: listscrollcontroller,
          padding:  EdgeInsets.all(10.0),
           itemBuilder: (context , index) {
              return CreateMessage(messages[index] , senderids[index],sendertypes[index]);
        },
        itemCount:  messages.length,

    reverse: true,
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
        title: Text(recevierName, style: TextStyle(
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w600
        ),
        ),
        
      ),
      body: Stack(
        children: [
          Column(
            children: [
              createMessagesList(),

              createInput(),
            ],
          )
        ],
      ),
    );
  }
}





