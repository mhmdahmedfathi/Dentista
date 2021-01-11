import 'package:dentista/ProductScreens/ProductComment.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class CommentController extends GetxController
{
  var CommentList = List<ProductComment>().obs;
  var NoComments = 0.obs;
  var IsLoading = true.obs;
  var ProductID = 0.obs;

  CommentController(int ProductID)
  {
    this.ProductID(ProductID);
  }

  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
     GetComments();

  }

  void GetComments() async
  {
    // Getting No. Comments
    int NoComments_request = 0;
    List<ProductComment> PComments = new List<ProductComment>();
    try
        {
          final NoComments_res = await http.post(
              'http://10.0.2.2:5000/NoComments',
              headers: <String,String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: json.encode({"product_id" : ProductID.value}));

          NoComments_request = int.parse(NoComments_res.body);
          NoComments(NoComments_request);
        }
        finally
            {
             try
             {
              IsLoading(true);
              final Comments_res = await http.post(
                  'http://10.0.2.2:5000/ViewComments',
                  headers: <String,String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: json.encode({"product_id" : ProductID.value}));
              final commentRequest = json.decode(Comments_res.body);
              var CommentID = commentRequest['comment_id'];
              var CommentContext = commentRequest['comment'];
              var Likes = commentRequest['likes'];
              var DentistID = commentRequest['DentistID'];
              var DentistName = commentRequest['DentistName'];
              var Dentist_Images = commentRequest['Dentist_Images'];
              var CommentDate = commentRequest['CommentDate'];

              for (int i = 0; i < NoComments_request; i++)
              {
                ProductComment PC = new ProductComment(CommentID[i], CommentContext[i], Likes[i], DentistID[i], DentistName[i], Dentist_Images[i], CommentDate[i]);
                PComments.add(PC);
              }

              CommentList.assignAll(PComments);
             }
             finally{
               IsLoading(false);
             }
            }
  }
}