import 'package:dentista/UsersControllers/DeliveryController.dart';
import 'package:dentista/utility_class/Review.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DeliveryReviewsScreen extends StatefulWidget {
  @override
  _DeliveryReviewsScreenState createState() => _DeliveryReviewsScreenState();
}


class _DeliveryReviewsScreenState extends State<DeliveryReviewsScreen> {
  final ScrollController listscrollcontroller = ScrollController();
  DeliveryController deliveryController= Get.put(DeliveryController());
  List<Review>ReviewsList=List<Review>.generate(0, (index) => Review());
  @override
  void initState() {
    super.initState();
    asyncmethod();
  }

  void asyncmethod() async {
    deliveryController.onInit();
    var Reviews = await http.post('http://10.0.2.2:5000/delivery_getreviews',
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'id' :deliveryController.ID.value
        })
    );

    final ReviewsData = json.decode(Reviews.body);
    int numberofreviews=ReviewsData['length'];
    ReviewsList= List<Review>.generate(numberofreviews, (index) => Review());
    for(int i = 0; i< numberofreviews;i++)
      {
        ReviewsList[i].DENTISTFname=ReviewsData['Dfname'][i];
        ReviewsList[i].DENTISTLname=ReviewsData['Dlname'][i];
        ReviewsList[i].REVIEW=ReviewsData['review'][i];
        ReviewsList[i].DENTISTIMGURL=ReviewsData['ImgUrl'][i];
      }
    setState(() {

    });
  }



  CreateReview(){
    return Expanded(
        child: ListView.builder(
          controller: listscrollcontroller,
            padding:  EdgeInsets.all(10.0),
          itemBuilder: (context , index) {
            return Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    child: Text(
                        ReviewsList[index].DENTISTFname+" "+ ReviewsList[index].DENTISTLname,
                      style: TextStyle(color: Colors.blueGrey[700] , fontWeight: FontWeight.w500,fontSize: 16),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Text(
                          ReviewsList[index].REVIEW,
                          style: TextStyle(color: Colors.white , fontWeight: FontWeight.w500,fontSize: 16),
                        ),
                        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                        width: 200.0,
                        decoration: BoxDecoration(color: Colors.blueGrey[700] , borderRadius: BorderRadius.circular(8.0)),
                        margin: EdgeInsets.only(bottom:10.0 , right: 10.0),
                      ),
                    ),
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage('https://googleflutter.com/sample_image.jpg'),
                            fit: BoxFit.fill
                        ),
                      ),
                    ),
                  ]
              ),
              ]
            );
          },
          itemCount: ReviewsList.length,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
        title: Text(
          'Reviews',
          style: TextStyle(
              fontSize: 30,
              fontFamily: "Montserrat",
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
        centerTitle: false,
        actions: [
          Icon(
              Icons.star_rate,
            size: 25,
          ),
          Center(
            child: Text(deliveryController.rate.value,
              style: TextStyle(
                fontFamily: 'montserrat',
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Column(
              children: [
                CreateReview()
              ],
            )
          ],
        )
      ),

    );
  }
}
