import 'package:dentista/ProductScreens/DentistProduct.dart';
import 'package:dentista/UsersControllers/DentistController.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class CartController extends GetxController
{
  var IsLoading = true.obs;
  var CartProducts = List<DentistProduct>().obs;
  var NoUnits = List<int>().obs;
  var NoCartElements = 0.obs;

  var TotalCost = 0.obs;
  var EnoughBudget = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    FetchTotalCost();
    FetchProducts();
  }

  void FetchTotalCost() async
  {
    DentistController dentistController = Get.put(DentistController());

    final CartRes = await http.post(
        'http://10.0.2.2:5000/GetTotalPrice',
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({"DentistID" : dentistController.DentistID.value}));

    var Cart = json.decode(CartRes.body);
    var valid_credit = Cart['enough_credit'];
    var total_price = Cart['total_price'];
    TotalCost(total_price);
    EnoughBudget(valid_credit == 1? true: false);

  }


  void FetchProducts()async
  {
    DentistController dentistController = Get.put(DentistController());

    try
      {
        IsLoading(true);
        /////////////////////////////////////////////////////////////////////
        final CartRes = await http.post(
            'http://10.0.2.2:5000/ViewCart',
            headers: <String,String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({"DentistID" : dentistController.DentistID.value}));
        ////////////////////////////////////////////////////////////////////////////
        final CartResult = json.decode(CartRes.body);
        var ProdNames = CartResult['ProductName'];
        var ProdIDS = CartResult['ProductID'];
        var ProdPrice = CartResult['Price'];
        var ProdCategory = CartResult['Category'];
        var ProdImgURL = CartResult['ImageURL'];
        var ProdRates = CartResult['Rate'];
        var ProdDescriptions = CartResult['Description'];
        var ProdBrand = CartResult['Brand'];
        var ProdNoReviews = CartResult['NoOfReviews'];


        List<dynamic> _prodIDs = ProdIDS; // Just to get the length of the products
        NoCartElements(_prodIDs.length);
        List<DentistProduct> DPL = new List<DentistProduct>();
        List<int> NumUnits = new List<int>();
        for(int i =0 ; i < _prodIDs.length; i++)
          {
            DentistProduct dentistProduct = new DentistProduct(ProdIDS[i], ProdNames[i], ProdCategory[i], ProdDescriptions[i], ProdBrand[i], ProdPrice[i], ProdImgURL[i], ProdRates[i], ProdNoReviews[i], 0);
            NumUnits.add(CartResult['Number_Units'][0]);
            DPL.add(dentistProduct);
          }
        CartProducts.assignAll(DPL);
        NoUnits.assignAll(NumUnits);

      }
    finally
        {
          IsLoading(false);
        }


  }
  }
