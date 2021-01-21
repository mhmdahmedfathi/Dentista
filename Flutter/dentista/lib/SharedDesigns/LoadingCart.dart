import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

Widget CardLoading(BuildContext context)
{
  return StaggeredGridView.countBuilder(crossAxisCount: 2, staggeredTileBuilder: (index) => StaggeredTile.fit(1),


  itemCount: 6,


  itemBuilder: (BuildContext context, int index)
  {
    return Padding(
  padding: EdgeInsets.all(8.0),
  child: Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.grey[200]

    ),
    child: Column(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],

            child: Container(

              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              height: 200,
            ),
          ),
        SizedBox(height: 8.0,),
        Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Container(

            height: 20,
            width: MediaQuery.of(context).size.width - 40,
            color: Colors.red,
          ),
        ),
        SizedBox(height: 4.0,),
        Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Container(
            height: 30,
            width: MediaQuery.of(context).size.width - 20,
          ),
        ),
        SizedBox(height: 4.0,),
        Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Container(
            height: 30,
            width: MediaQuery.of(context).size.width - 20,
          ),
        ),
        SizedBox(height: 4.0,),
        Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Container(
            height: 30,
            width: MediaQuery.of(context).size.width - 20,
          ),
        )
      ],
    ),
  ),

    );
  }
  );
}