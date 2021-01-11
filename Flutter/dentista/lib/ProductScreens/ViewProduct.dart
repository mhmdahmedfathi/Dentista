import 'package:dentista/Authentication/AuthController.dart';
import 'package:dentista/Controllers/CommentController.dart';
import 'package:dentista/ProductScreens/CommentView.dart';
import 'package:dentista/ProductScreens/DentistProduct.dart';
import 'package:dentista/UsersControllers/DentistController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'dart:convert';

import 'package:sliding_up_panel/sliding_up_panel.dart';

Widget AddCommentWidget(BuildContext context, int ProductID, String DentistEmail, String ImageURL, CommentController CControl)
{
  String CommentContext = "";
  final nameHolder = TextEditingController();
  return Container(
    height: 55,
    decoration: BoxDecoration(color: Colors.blueGrey[50], borderRadius: BorderRadius.all(Radius.circular(20))),
    child: Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(ImageURL),
        ),
        Expanded(

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: nameHolder,
              maxLines: 1,
              onChanged: (val){CommentContext = val;},
              onSubmitted: (val){CommentContext = val;},
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                ),
                hintText: "Add a comment",
                hintStyle: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat",
                  color: Colors.black,

                ),

              ),
            ),
          ),
        ),

        IconButton(icon: Icon(Icons.send), color: Colors.blue[200],
            onPressed: () async{
              final AddComment_Res = await http.post(
                  'http://10.0.2.2:5000/AddComment',
                  headers: <String,String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: json.encode({"dentist_email" : DentistEmail, "product_id": ProductID, "comment" : CommentContext}));
                  nameHolder.clear();
                  CControl.onInit();
              setState(){

              }
            }
        )

      ],
    ),
  );
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

class ViewProduct extends StatefulWidget {
  final product;
  ViewProduct(this.product);
  @override
  _ViewProductState createState() => _ViewProductState(product);
}

class _ViewProductState extends State<ViewProduct> with TickerProviderStateMixin{
  DentistProduct product;
  AuthController authController = Get.put(AuthController());
  CommentController commentController;
  DentistController dentistController = Get.put(DentistController());




  bool icon1 = false;
  bool icon2 = false;
  bool icon3 = false;
  bool icon4 = false;
  bool icon5 = false;

  AnimationController _controller1;
  Animation <Color> color_animation1;

  AnimationController _controller2;
  Animation <Color> color_animation2;

  AnimationController _controller3;
  Animation <Color> color_animation3;

  AnimationController _controller4;
  Animation <Color> color_animation4;

  AnimationController _controller5;
  Animation <Color> color_animation5;




  void _onButtonPress()
  {
    
  }


  _ViewProductState(this.product);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    commentController = Get.put(CommentController(product.ProductID));



    _controller1 = AnimationController(
        duration: Duration(seconds: 1),
        vsync: this

    );
    color_animation1 = ColorTween(begin: Colors.grey[400], end:Colors.amber).animate(_controller1);


    _controller2 = AnimationController(
        duration: Duration(seconds: 1),
        vsync: this

    );
    color_animation2 = ColorTween(begin: Colors.grey[400], end:Colors.amber).animate(_controller2);


    _controller3 = AnimationController(
        duration: Duration(seconds: 1),
        vsync: this

    );
    color_animation3 = ColorTween(begin: Colors.grey[400], end:Colors.amber).animate(_controller3);


    _controller4 = AnimationController(
        duration: Duration(seconds: 1),
        vsync: this

    );
    color_animation4 = ColorTween(begin: Colors.grey[400], end:Colors.amber).animate(_controller4);


    _controller5 = AnimationController(
        duration: Duration(seconds: 1),
        vsync: this

    );
    color_animation5 = ColorTween(begin: Colors.grey[400], end:Colors.amber).animate(_controller5);



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.blueGrey[800],
        title: Text(product.ProductName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "Montserrat",
          ),
        ),
        actions: [
          IconButton(icon: Icon(Icons.add_shopping_cart, color: Colors.white,),
              onPressed: () async
              {
                final ProductRes = await http.post(
                    'http://10.0.2.2:5000/AddtoCart',
                    headers: <String,String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: json.encode({"product_id" : product..ProductID, "dentist_email": dentistController.DentistEmail}));
              }
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(()=> commentController.IsLoading.value == true ? Center(child: CircularProgressIndicator()) :
        ListView(
          children: [
            Hero(tag: "product_${product.ProductName}",
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image(image: NetworkImage(product.ImageURL),fit: BoxFit.fitWidth,width: MediaQuery.of(context).size.width,height: 250,),
                )
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "${product.ProductName}",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat",
                    color: Colors.blueGrey[800]
                ),
              ),
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "${product.Price}EGP",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Montserrat",
                        color: Colors.blue[800],
                        decoration: product.Discount != 0 ? TextDecoration.lineThrough : TextDecoration.none
                    ),

                  ),
                ),
                product.Discount == 0 ? Container() : Text(
                  "${product.Price - product.Discount}EGP",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Montserrat",
                      color: Colors.blue[800]
                  ),
                )
              ],
            ),
            SizedBox(height: 5,),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Category: ${product.Category}",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    fontFamily: "Montserrat",
                    color: Colors.black
                ),
              ),
            ) ,
            SizedBox(height: 5,),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Brand: ${product.Brand}",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    fontFamily: "Montserrat",
                    color: Colors.black
                ),
              ),
            ) ,
            SizedBox(height: 5,),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "${product.Description}",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    fontFamily: "Montserrat",
                    color: Colors.black
                ),
              ),
            ) ,
            SizedBox(height: 20,),
            Row(
              children: [
                Expanded(
                  child: Text("Review:  ${product.NoOfReviews} Reviews with rate ${product.Rate}", style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.normal,
                  ),),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.all(2.0),
                    child:AnimatedBuilder(
                      animation: _controller1,
                      builder: (BuildContext context, _){
                        return IconButton(
                          icon: Icon(Icons.star, color: color_animation1.value,),
                          onPressed: (){
                            icon1 = true;
                            icon2 = false;
                            icon3 = false;
                            icon4 = false;
                            icon5 = false;
                          _controller1.forward();
                          },
                        );
                      },
                    )
                ),
                Padding(
                    padding: EdgeInsets.all(2.0),
                    child: AnimatedBuilder(
                      animation: _controller2,
                      builder: (BuildContext context, _)
                      {
                        return IconButton(
                          icon: Icon(Icons.star, color:color_animation2.value,),
                          onPressed: (){
                            icon2 = true;
                            icon1 = false;
                            icon3 = false;
                            icon4 = false;
                            icon5 = false;
                          _controller1.forward();
                          _controller2.forward();
                          },
                        );
                      },
                    )
                ),
                Padding(
                    padding: EdgeInsets.all(2.0),
                    child: AnimatedBuilder(
                      animation: _controller3,
                      builder: (BuildContext context, _)
                      {
                        return IconButton(
                          icon: Icon(Icons.star, color: color_animation3.value,),
                          onPressed: (){
                            icon3 = true;
                            icon2 = false;
                            icon1 = false;
                            icon4 = false;
                            icon5 = false;
                          _controller1.forward();
                          _controller2.forward();
                          _controller3.forward();
                          },
                        );
                      },
                    )
                ),
                Padding(
                    padding: EdgeInsets.all(2.0),
                    child: AnimatedBuilder(
                      animation: _controller4,
                      builder: (BuildContext context, _)
                      {
                        return IconButton(
                          icon: Icon(Icons.star, color: color_animation4.value,),
                          onPressed: (){
                            icon4 = true;
                            icon2 = false;
                            icon3 = false;
                            icon1 = false;
                            icon5 = false;
                          _controller1.forward();
                          _controller2.forward();
                          _controller3.forward();
                          _controller4.forward();
                          },
                        );
                      },
                    )
                ),
                Padding(
                    padding: EdgeInsets.all(2.0),
                    child: AnimatedBuilder(
                      animation: _controller5,
                      builder: (BuildContext context, _)
                      {
                        return IconButton(
                          icon: Icon(Icons.star, color: color_animation5.value,),
                          onPressed: (){icon5 = true;
                          icon2 = false;
                          icon3 = false;
                          icon4 = false;
                          icon1 = false;
                          _controller1.forward();
                          _controller2.forward();
                          _controller3.forward();
                          _controller4.forward();
                          _controller5.forward();
                          },
                        );
                      },
                    )
                )
              ],
            ),
            GestureDetector(
              onTap: () async
              {
                int index = 0;
                if (icon1)
                  index = 1;
                else if (icon2)
                  index = 2;
                else if (icon3)
                  index = 3;
                else if (icon4)
                  index = 4;
                else if (icon5)
                  index = 5;

                final ReviewReq = await http.post(
                    'http://10.0.2.2:5000/Review',
                    headers: <String,String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: json.encode({"product_id" : product.ProductID, "review": index}));


              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Center(child:Text('Submit review', style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.normal,
                    color: Colors.blue[800]
                ),
                ),
                ),
              )
            ),

            Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: AddCommentWidget(context,product.ProductID, authController.GetEmail, dentistController.DentistImageURL.value, commentController),
            ),
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CommentView(product.ProductID)));
              },
              child: Center(
                child: Text("Comments",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.normal,
                    color: Colors.blue[800]
                  ),
                ),
              ),
            )



          ],
        )
        ),
      ),
      //bottomNavigationBar:

    );
  }
}

