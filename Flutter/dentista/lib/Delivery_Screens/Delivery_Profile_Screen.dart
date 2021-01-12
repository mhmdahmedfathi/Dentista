import 'dart:convert';
import 'package:dentista/Authentication/AuthController.dart';
import 'package:dentista/Models/Alerts.dart';
import 'package:dentista/Models/AuthenticationFields.dart';
import 'package:dentista/UsersControllers/OrderController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dentista/Delivery_Screens/DeliveryHome.dart';
import 'package:get/get.dart';
import 'package:dentista/UsersControllers/DeliveryController.dart';
import 'package:dentista/Auth/Validations.dart';


import 'package:azblob/azblob.dart';
import 'package:mime/mime.dart';
import 'dart:typed_data';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class Delivery_Profile extends StatefulWidget {
  @override
  _Delivery_ProfileState createState() => _Delivery_ProfileState();
}

class _Delivery_ProfileState extends State<Delivery_Profile> {
  final AuthController authController = Get.put(AuthController());
  String updatedValue;
  final _formKey = GlobalKey<FormState>();
  Validator _validator = Validator();

  Map SplitNameString() {
    String s = updatedValue;
    int idx = s.indexOf(" ");
    List names = [s.substring(0, idx).trim(), s.substring(idx + 1).trim()];
    return {"DELIVERY_Fname": names[0], "DELIVERY_Lname": names[1]};
  }
  void displayBottomSheet(BuildContext context, String hintText, String ColumnName) {
    showModalBottomSheet(
        backgroundColor: Colors.blueGrey[100],
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return Container(
              child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: _formKey,
                  child: TextFormField(
                    onChanged: (val) {
                      setState(() {
                        updatedValue = val;
                      });
                    },
                    autofocus: true,
                    decoration: authDecoration('Enter new ' + hintText),
                    validator: (val) {
                      if (hintText == 'Phone Number') {
                        return val.length != 11 ? "Invalid phone number" : null;
                      }
                      else if (hintText == 'Vehicle License') {
                        if (val.isEmpty)
                          return "Please Enter Your Vehicle Licence";
                        else if (val.length < 8)
                          return "   Enter a Valid Vehicle Licence";
                        else
                          return null;
                      }
                      return val.isEmpty ? 'Please Enter A Value' : null;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: RaisedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        Map dict;
                        if (hintText == 'Name') {
                          dict = SplitNameString();
                        } else if (hintText == 'Email') {
                          authController.setEmail(updatedValue);
                        }

                        final updatedata = await http.post(
                          'http://10.0.2.2:5000/delivery_UpdateData',
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                            'Charset': 'utf-8'
                          },
                          body: json.encode({
                            "dic": hintText == 'Name'
                                ? dict
                                : {"$ColumnName": "$updatedValue"},
                            "MID": deliveryController.ID.value
                          }),


                        );
                        deliveryController.onInit();
                        orderController.onInit();
                        Navigator.pop(context);
                      }
                    },
                    color: Colors.blueGrey[400],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.black87)),
                    child: Text(
                      "Update",
                      style: TextStyle(
                        fontFamily: 'montserrat',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
        });
  }

  final OrderController orderController = Get.put(OrderController());
  final DeliveryController deliveryController = Get.put(DeliveryController());

  Future<Null> refresh() async {
    await deliveryController.onInit();
  }

  Widget InfoRow(
      String RowName, var Value, String ButtonName, String DataAttribute) {
    return Column(
      children: [
        Row(
          children: [
            RowName == "Name"
                ? Icon(Icons.account_circle)
                : RowName == "Email"
                    ? Icon(Icons.alternate_email)
                    : RowName == "Phone Number"
                        ? Icon(Icons.phone_android)
                        : RowName == "Vehicle Model"
                            ? Icon(Icons.local_shipping)
                            : RowName == "Delivery ID"
                                ? Icon(Icons.perm_identity)
                                : RowName == "Area"
                                    ? Icon(Icons.location_on)
                                    : RowName == "Vehicle License"
                                        ? Icon(Icons.card_membership)
                                        : Container(),
            SizedBox(width: 20),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(RowName,
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        letterSpacing: 1.3,
                        fontFamily: 'montserrat')),
                Obx(
                  () => Text(
                      RowName == "Name"
                          ? deliveryController.fname.value +
                              " " +
                              deliveryController.lname.value
                          : Value.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          letterSpacing: 1.3,
                          fontFamily: 'montserrat')),
                )
              ],
            )),
            RowName == "Delivery ID"
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                          child: IconButton(
                        onPressed: () {
                          return displayBottomSheet(context, RowName,
                              RowName == "Name" ? "" : DataAttribute);
                          // UpdateAlert(context, ButtonName, DataAttribute,
                          //     Value.toString(), deliveryController.ID.value);
                          refresh();
                        },
                        icon: Icon(Icons.edit),
                      )),
                    ),
                  ),
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }


  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadImageToAzure(BuildContext context) async {
    try {

      String fileName = _image.path;
      // read file as Uint8List
      Uint8List content = await _image.readAsBytes();
      var storage = AzureStorage.parse('DefaultEndpointsProtocol=https;AccountName=dentista;AccountKey=nogDckvD56HkYXDMmJWqMnUAQiimd9g0OYpVJTrHlQRNARxdBJ5quSE2j9i3/K/yIR+ME3YhGkWbNU1E13cChA==;EndpointSuffix=core.windows.net');
      String container = "quickstartblobs";
      // get the mine type of the file
      String contentType = lookupMimeType(fileName);
      await storage.putBlob('/$container/$fileName', bodyBytes: content,
          contentType: contentType,
          type: BlobType.BlockBlob);
      print("done");
    } on AzureStorageException catch (ex) {
      print(ex.message);
    } catch (err) {
      print(err);
    }
  }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
        title: Text(
          'Account Settings',
          style: TextStyle(
            fontFamily: 'montserrat',
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: false,
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.grey[300],
                padding: EdgeInsets.all(20),
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.blueGrey,
                    radius: 85,
                    backgroundImage: NetworkImage(deliveryController.ImageURL.value),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        icon: Icon(Icons.camera_alt, color: Colors.white,),
                        onPressed: ()async
                        {
                          await getImage();
                          //print(_image);
                          uploadImageToAzure(context);
                          String ImageURL_Uploaded = "https://dentista.blob.core.windows.net/quickstartblobs/" + _image.path;
                          //print(ImageURL_Uploaded);
                          final updatedata = await http.post(
                            'http://10.0.2.2:5000/delivery_UpdateData',
                            headers: <String,String>{
                              'Content-Type': 'application/json; charset=UTF-8',
                              'Charset': 'utf-8'
                            },
                            body: json.encode({
                              "dic" :{"DELIVERY_IMAGE_URL":"$ImageURL_Uploaded"},
                              "MID"  : deliveryController.ID.value,


                            }),
                          );

                          deliveryController.onInit();
                          setState(() {

                          });
                        },
                      ),
                    ),

                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Personal INFO",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'montserrat',
                          letterSpacing: 2.5)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 15),
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 12),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InfoRow("Name", deliveryController.fname, "name", ""),
                        InfoRow("Email", deliveryController.email, "email",
                            "DELIVERY_EMAIL"),
                        InfoRow("Phone Number", deliveryController.phone,
                            "phone", "Delivery_PHONE_NUMBER"),
                        InfoRow("Delivery ID", deliveryController.ID, "", ""),
                        InfoRow(
                            "Area", deliveryController.area, "area", "AREA"),
                        InfoRow(
                            "Vehicle License",
                            deliveryController.vechilelicense,
                            "vechile license",
                            "VECHILE_LICENCE"),
                        InfoRow(
                            "Vehicle Model",
                            deliveryController.vechilemodel,
                            "vechile model",
                            "VECHILE_MODEL"),
                        Center(
                          child: TextButton(onPressed: (){
                            showModalBottomSheet(
                                backgroundColor: Colors.blueGrey[100],
                                isScrollControlled: true,
                                context: context,
                                builder: (ctx){
                                  String OldPassword="";
                                  String NewPassword="";
                                  String ReNewPassword="";
                              return Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(25.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Form(
                                        key: _formKey,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            TextFormField(
                                              obscureText: true,
                                              onChanged: (val){
                                                setState(() {
                                                  OldPassword=val;
                                                });
                                              },
                                              autofocus: true,
                                              decoration: authDecoration('Enter old password'),
                                              validator: (val){
                                                return val.isEmpty? 'Please Enter A Value' : null;
                                              },
                                            ),
                                            SizedBox(height: 10),
                                            TextFormField(
                                              obscureText: true,
                                              onChanged: (val){
                                                setState(() {
                                                  NewPassword=val;
                                                });
                                              },
                                              autofocus: true,
                                              decoration: authDecoration('Enter new password'),
                                              validator: (val){
                                                return val.isEmpty? 'Please Enter A Value' : null;
                                              },
                                            ),
                                            SizedBox(height: 10),
                                            TextFormField(
                                              obscureText: true,
                                              onChanged: (val){
                                                setState(() {
                                                  ReNewPassword=val;
                                                });
                                              },
                                              autofocus: true,
                                              decoration: authDecoration('Re-Enter new password'),
                                              validator: (val){
                                                return  val!=NewPassword? "password doesn't match": val.isEmpty? 'Please Enter A Value' : null;
                                              },
                                            ),
                                          ]
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context).viewInsets.bottom),
                                        child: RaisedButton(
                                          color: Colors.blueGrey[400],
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(18.0),
                                              side: BorderSide(color: Colors.black87)
                                          ),
                                          child: Text("Update" , style: TextStyle( fontFamily: 'montserrat',
                                            fontWeight: FontWeight.w600,),),
                                          onPressed: () async{
                                            if(_formKey.currentState.validate()){
                                              final updatedata = await http.post(
                                                'http://10.0.2.2:5000/delivery_ChangePassword',
                                                headers: <String,String>{
                                                  'Content-Type': 'application/json; charset=UTF-8',
                                                  'Charset': 'utf-8'
                                                },
                                                body: json.encode({
                                                  'newpassword': NewPassword,
                                                  'oldpassword': OldPassword,
                                                  'DELIVERYID': deliveryController.ID.value
                                                }),
                                              );
                                              deliveryController.onInit();
                                              orderController.onInit();
                                              Navigator.pop(context);

                                            }
                                          },
                                        ),
                                      )
                                      ])

                                  ),
                                );
                            });
                          }, child: Text(
                            "Change my password",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  letterSpacing: 1.3,
                                  fontFamily: 'montserrat'))
                          ),
                        )

                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
