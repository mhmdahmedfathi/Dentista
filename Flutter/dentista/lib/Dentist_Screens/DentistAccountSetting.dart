import 'package:dentista/Auth/Validations.dart';
import 'package:dentista/Authentication/AuthController.dart';
import 'package:dentista/Models/AuthenticationFields.dart';
import 'package:dentista/Models/SharedTextStyle.dart';
import 'package:dentista/UsersControllers/DentistController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class DentistAccountSettings extends StatefulWidget {
  @override
  _DentistAccountSettingsState createState() => _DentistAccountSettingsState();
}

class _DentistAccountSettingsState extends State<DentistAccountSettings> {
  final AuthController authController = Get.put(AuthController());
  final DentistController dentistController = Get.put(DentistController());
  Validator _validator = new Validator();
  String updatedValue;
  final _formKey = GlobalKey<FormState>();

  Map SplitNameString()
  {
    String s = updatedValue;
    int idx = s.indexOf(" ");
    List names = [s.substring(0,idx).trim(), s.substring(idx+1).trim()];
    return {"DENTIST_Fname" : names[0] , "DENTIST_LNAME" : names[1]};
  }

  void displayBottomSheet(BuildContext context,String hintText,String ColumnName) {
    String oldPassword;
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
                    hintText == "Password" ?
                    TextFormField
                      (
                        key: _formKey,
                        autofocus: true,
                      decoration: authDecoration("Enter Old password"),
                      obscureText: true,
                      onChanged: (val){setState(() {
                        oldPassword = val;
                      });},
                      validator: (val) {return val != dentistController.DentistPassword.value ?"password dosen't match old one" : null;},
                      )

                        :
                    Container(),
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        onChanged: (val)
                        {
                          setState(() {
                            updatedValue = val;
                          });
                        },
                        obscureText: hintText == "Password" ? true : false,
                        autofocus: true,
                        decoration: authDecoration('Enter new '+hintText),
                        validator: (val){

                            if (hintText == "Password")
                            return _validator.validate_password(val) == false ? "Enter valid password":null ;
                          return val.isEmpty? 'Please Enter A Value' : null;
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: RaisedButton(
                        onPressed: ()async{
                          if(_formKey.currentState.validate())
                          {
                            Map dict;
                            if(hintText == 'name') {
                              dict = SplitNameString();
                            }
                            else if(hintText == 'email')
                            {
                              authController.setEmail(updatedValue);
                            }

                            final updatedata = await http.post(
                              'http://10.0.2.2:5000/dentist_update',
                              headers: <String,String>{
                                'Content-Type': 'application/json; charset=UTF-8',
                                'Charset': 'utf-8'
                              },
                              body: json.encode({
                                "dic" :hintText=='name' ? dict :{"$ColumnName":"$updatedValue"},
                                "DID"  : dentistController.DentistID.value
                              }),
                            );
                            dentistController.onInit();
                            Navigator.pop(context);
                          }
                        },
                        color: Colors.blueGrey[400],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.black87)
                        ),
                        child: Text("Update" , style: TextStyle( fontFamily: 'montserrat',
                          fontWeight: FontWeight.w600,),),
                      ),
                    ),
                  ],
                ),
              )
          );
        });
  }
  int password_length;
  String Password_String = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    password_length = dentistController.DentistPassword.value.length;
    for (int i = 0 ; i < password_length; i++)
      Password_String = Password_String + "*";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Account Settings" , style: TextStyle(
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
        ),
        backgroundColor:Colors.blueGrey[800],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.grey[300],
            padding: EdgeInsets.all(20),
            child: Center(
              child: CircleAvatar(
                backgroundColor: Colors.blueGrey,
                radius: 85,
                backgroundImage: NetworkImage(dentistController.DentistImageURL.value),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: ()
                    {

                    },
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text("PERSONAL INFO" , style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'montserrat',
                  letterSpacing: 2.5
              ) ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 12),
                child: Container(
                    child: Obx(()=>Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person_pin),
                            SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name " , style: requestInfoStyle(color: Colors.blueGrey[500])),
                                Text(dentistController.DentistFname.value+" "+dentistController.DentistLname.value,style: requestInfoStyle()),
                              ],
                            ),
                            Spacer(),
                            IconButton(icon: Icon(Icons.edit), onPressed: (){
                              return displayBottomSheet(context,'name',"");
                            })
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(Icons.alternate_email),
                            SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Email " , style: requestInfoStyle(color: Colors.blueGrey[500])),
                                Text(dentistController.DentistEmail.value,style: requestInfoStyle()),
                              ],
                            ),
                            Spacer(),
                            IconButton(icon: Icon(Icons.edit), onPressed: (){
                              return displayBottomSheet(context,'email',"DENTIST_EMAIL");
                            })
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(Icons.enhanced_encryption),
                            SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Password " , style: requestInfoStyle(color: Colors.blueGrey[500])),
                                Text(Password_String,style: requestInfoStyle()),
                              ],
                            ),

                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(Icons.call),
                            SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Phone Number" , style: requestInfoStyle(color: Colors.blueGrey[500])),
                                Text(dentistController.DentistPhoneNumber.value,style: requestInfoStyle()),
                              ],
                            ),
                            Spacer(),
                            IconButton(icon: Icon(Icons.edit), onPressed: (){
                              return displayBottomSheet(context,'Phone Number','DENTIST_PHONE_NUMBER');
                            })
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(Icons.location_on),
                            SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Address" , style: requestInfoStyle(color: Colors.blueGrey[500])),
                                Text(dentistController.DentistAddress.value,style: requestInfoStyle()),
                              ],
                            ),
                            Spacer(),
                            IconButton(icon: Icon(Icons.edit), onPressed: (){
                              return displayBottomSheet(context,'address','DENTIST_ADDRESS');
                            })
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(Icons.location_on),
                            SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("ZipCode" , style: requestInfoStyle(color: Colors.blueGrey[500])),
                                Text(dentistController.DentistZipCode.value.toString(),style: requestInfoStyle()),
                              ],
                            ),
                            Spacer(),
                            IconButton(icon: Icon(Icons.edit), onPressed: (){
                              return displayBottomSheet(context,'Zip Code','DENTIST_ZIP_CODE');
                            })
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(Icons.location_on),
                            SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Region" , style: requestInfoStyle(color: Colors.blueGrey[500])),
                                Text(dentistController.DentistRegion.value,style: requestInfoStyle()),
                              ],
                            ),
                            Spacer(),
                            IconButton(icon: Icon(Icons.edit), onPressed: (){
                              return displayBottomSheet(context,'Region','DENTIST_REGION');
                            })
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(Icons.location_city),
                            SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("City" , style: requestInfoStyle(color: Colors.blueGrey[500])),
                                Text(dentistController.DentistAddress.value,style: requestInfoStyle()),
                              ],
                            ),
                            Spacer(),
                            IconButton(icon: Icon(Icons.edit), onPressed: (){
                              return displayBottomSheet(context,'City','DENTIST_CITY');
                            })
                          ],
                        ),
                        SizedBox(height: 20),

                      ],
                    ),)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
