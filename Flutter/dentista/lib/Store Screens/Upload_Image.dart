import 'package:dentista/Authentication/AuthController.dart';
import 'package:dentista/Store%20Screens/Store_Home.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import'package:dentista/main.dart';
import 'package:get/get.dart';
import 'package:dentista/Models/Alerts.dart';
import 'package:azblob/azblob.dart';
import 'package:mime/mime.dart';
import 'dart:typed_data';
import 'dart:io';
class UploadImageDemo extends StatefulWidget {


  UploadImageDemo() : super();
  final String title = "Upload Image Demo";

  @override
  UploadImageDemoState createState() => UploadImageDemoState();
}


class UploadImageDemoState extends State<UploadImageDemo> {
  //
  final AuthController authController = Get.put(AuthController());
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
    setStatus('');
  }
  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  startUpload() async {
    setStatus('Uploading Image...');
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    var FileName = tmpFile.path;
    try {

      String fileName = tmpFile.path;
      // read file as Uint8List
      Uint8List content = await tmpFile.readAsBytes();
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
    String ImageURL_Uploaded = "https://dentista.blob.core.windows.net/quickstartblobs/" + FileName;
    upload(ImageURL_Uploaded);
   }

  upload(var fileName) async {
    Map dict;
    final updatedata = await http.post(
      'http://10.0.2.2:5000/Product_Update',
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Charset': 'utf-8'
      },
      body: json.encode({
        "dic" :{"IMAGE_URL":"$fileName"},
      "ID"  : authController.StoreID,
      "PRODUCT_NAME"  : authController.Product_Name

      }),
    );
    setStatus('Uploaded...');

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context)=>StoreHome() ));
    Alert(context, "Item Added successfully", "Press ok to continue", message2: "");


  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Flexible(
            child: Image.file(
              snapshot.data,
              fit: BoxFit.fill,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Image Demo"),
      ),
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            OutlineButton(
              onPressed: chooseImage,
              child: Text('Choose Image'),
            ),
            SizedBox(
              height: 20.0,
            ),
            showImage(),
            SizedBox(
              height: 20.0,
            ),
            OutlineButton(
              onPressed: startUpload,
              child: Text('Upload Image'),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              status,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}