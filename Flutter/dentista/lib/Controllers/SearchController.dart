import 'package:dentista/ProductScreens/DentistProduct.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class SearchController extends GetxController
{

  var IsLoading = true.obs;
  var ProductList = List<DentistProduct>().obs;
  var NoSearchResults = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void FetchProducts(String SearchKey) async
  {

    try
        {
          IsLoading(true);

          final SearchRes = await http.post(
              'http://10.0.2.2:5000/SearchProduct',
              headers: <String,String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: json.encode({"SearchContext" : SearchKey}));

          // Getting the result
          final Products = json.decode(SearchRes.body);

          var ProdNames = Products['ProductName'];
          var ProdIDS = Products['ProductID'];
          var ProdPrice = Products['Price'];
          var ProdCategory = Products['Category'];
          var ProdImgURL = Products['ImageURL'];
          var ProdRates = Products['Rate'];
          var ProdDescriptions = Products['Description'];
          var ProdBrand = Products['Brand'];
          var ProdNoReviews = Products['NoOfReviews'];

          List<dynamic> _prodIDs = ProdIDS; // Just to get the length of the products
          NoSearchResults(_prodIDs.length);
          List<DentistProduct> DPL = new List<DentistProduct>();
          for(int i =0 ; i < _prodIDs.length; i++)
          {
            DentistProduct dentistProduct = new DentistProduct(ProdIDS[i], ProdNames[i], ProdCategory[i], ProdDescriptions[i], ProdBrand[i], ProdPrice[i], ProdImgURL[i], ProdRates[i], ProdNoReviews[i], 0);
            DPL.add(dentistProduct);
          }
          ProductList.assignAll(DPL);

        }
        finally
            {
              IsLoading(false);
            }
  }
}