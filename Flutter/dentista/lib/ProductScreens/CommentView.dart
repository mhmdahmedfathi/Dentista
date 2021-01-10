import 'package:dentista/Controllers/CommentController.dart';
import 'package:dentista/Controllers/ProductController.dart';
import 'package:dentista/UsersControllers/DentistController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class CommentView extends StatefulWidget {
  final Product_ID;
  CommentView(this.Product_ID){CommentController commentController  = Get.put(CommentController(Product_ID));}

  @override
  _CommentViewState createState() => _CommentViewState(Product_ID);
}

Widget CommentWidget(BuildContext context,String ImageURL, String Name, String CommentContext, String CommentTime, int Likes, int comment_id, String DentistEmail)
{
  bool IsLiked = false;
  return Container(
    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        color: Colors.blueGrey[200]
    ),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(ImageURL),
              ),
              SizedBox(width: 10,),
              Text(
                "${Name}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat",
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text("${CommentContext}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                fontFamily: "Montserrat",
                color: Colors.black,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical:0, horizontal: 10),
          child: Row(
            children: [
              Text(
                "${CommentTime}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat",
                  color: Colors.blue[200],
                ),
              ),
              IconButton(icon: Icon(Icons.favorite),color: IsLiked == false? Colors.grey: Colors.red[800], iconSize: 15,
                  onPressed: () async
                  {
                    // Need to UnLike feature
                    final AddLikeRes = await http.post(
                        'http://10.0.2.2:5000/LikeComment',
                        headers: <String,String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: json.encode({"dentist_email" : DentistEmail, "comment_id" : comment_id}));
                    IsLiked = !IsLiked;

                  }
              ),
              Text(
                "${Likes} love",style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.normal,
                fontFamily: "Montserrat",
                color: Colors.black,
              ),
              )
            ],
          ),
        )
      ],
    ),
  );
}
class _CommentViewState extends State<CommentView> {
  ProductController productController = Get.put(ProductController());
  CommentController commentController ;
  DentistController dentistController = Get.put(DentistController());
  int ProductID;

  _CommentViewState(this.ProductID)
  {
    //commentController  = Get.put(CommentController(ProductID));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    commentController  = Get.put(CommentController(ProductID));
    commentController.onInit();
    setState(() {

    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
      ),
      body:Obx( () => commentController.IsLoading.value == true ? Center(child: CircularProgressIndicator(),) : ListView.builder(
          itemCount: commentController.NoComments.value,
          itemBuilder: (context, index)
          {
            //return Text("Hello");

            return CommentWidget(context, commentController.CommentList[index].DentistImageURL, commentController.CommentList[index].DentistName, commentController.CommentList[index].CommentContext, commentController.CommentList[index].CommentDate, commentController.CommentList[index].Likes, commentController.CommentList[index].CommentID, dentistController.DentistEmail.value);
          }
      ),)
    );
  }
}
//