import 'package:dentista/Authentication/AuthController.dart';
import 'package:dentista/Controllers/ScheduleController.dart';
import 'package:dentista/ProductScreens/ViewProduct.dart';
import 'package:dentista/UsersControllers/DentistController.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class ScheduleOrders extends StatefulWidget {
  @override
  _ScheduleOrdersState createState() => _ScheduleOrdersState();
}

class _ScheduleOrdersState extends State<ScheduleOrders> {
  AuthController authController = Get.put(AuthController());
  ScheduleController scheduleController = Get.put(ScheduleController());
  DentistController dentistController = Get.put(DentistController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification ScrollInfo){
          /*
          if (ScrollInfo.metrics.pixels == ScrollInfo.metrics.maxScrollExtent)
            {
              loadMore();
            }
            */

          return true;
        }
        ,child: Obx( () => scheduleController.IsLoading.value == true ? Center(child: CircularProgressIndicator(),) :
      StaggeredGridView.countBuilder(crossAxisCount: 2, staggeredTileBuilder: (index) => StaggeredTile.fit(1),


          itemCount: scheduleController.TotalSchedule.value,


          itemBuilder: (BuildContext context, int index)
          {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  // Open the page of the product
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ViewProduct(scheduleController.ProductList[index])));
                },
                onDoubleTap: ()
                {
                  // Add to favourites

                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.grey[200]

                  ),
                  child: Column(
                    children: [
                      Hero(tag: "product_${scheduleController.ProductList[index].ProductName}",
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image(
                              image: NetworkImage(scheduleController.ProductList[index].ImageURL),
                              fit: BoxFit.fill,
                              width: MediaQuery.of(context).size.width,
                              height: 200,


                            ),
                          )
                      ),
                      SizedBox(height: 8.0,),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "${scheduleController.ProductList[index].ProductName}", style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Montserrat",
                              color: Colors.blueGrey[800]

                          ),
                          ),
                        ),
                      ),

                      SizedBox(height: 8.0,),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "${scheduleController.ProductList[index].Category}", style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Montserrat",
                              color: Colors.black

                          ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${scheduleController.ProductList[index].Price}EGP", style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat",
                                color: Colors.blueGrey[800],
                                decoration: scheduleController.ProductList[index].Discount!=0 ? TextDecoration.lineThrough : TextDecoration.none

                            ),
                            ),
                            scheduleController.ProductList[index].Discount!=0 ?
                            Text(
                              "${scheduleController.ProductList[index].Price - scheduleController.ProductList[index].Discount}EGP",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat",
                                color: Colors.black,
                              ),

                            ) : Container(),


                          ],
                        ),
                      ),


                    ],
                  ),
                ),
              ),
            );
          }
      )

      ),
      ),
    );
  }
}
