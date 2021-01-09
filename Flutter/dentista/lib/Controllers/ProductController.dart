import 'package:dentista/ProductScreens/DentistProduct.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class ProductController extends GetxController
{
  var ProductList = new List<DentistProduct>().obs;
  var NoProducts = 0.obs;
  var IsLoading = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    FetchProducts();
  }

  void FetchProducts()async
  {
    try
        {
          IsLoading(true);

          // First Retrive the number of prodcuts
          final NoProducts_res = await http.post(
            'http://10.0.2.2:5000/NoProducts',
            headers: <String,String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({
              "product":"0"
            }),
          );
          int Products_Number = int.parse(NoProducts_res.body);
          NoProducts(Products_Number);

          List<DentistProduct> product_list = new List<DentistProduct>();
          // Retrive Products
          for (int i = 0; i < Products_Number; i++)
          {
            final ProductRes = await http.post(
                'http://10.0.2.2:5000/FetchProducts',
                headers: <String,String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                },
                body: json.encode({"index" : i}));

            final Prod = json.decode(ProductRes.body);

            var ProductName = Prod["ProductName"];
            var ProductID = Prod["ProductID"];
            var Price = Prod["Price"];
            var Category = Prod["Category"];
            var Description = Prod["Description"];
            var Brand = Prod["Brand"];

            var ImageURL = Prod["ImageURL"];
            var Rate = Prod["Rate"];
            var NoOfReviews = Prod["NoOfReviews"];
            var Discount = Prod["discount"];
            DentistProduct dentistProduct = new DentistProduct(ProductID, ProductName, Category, Description, Brand, Price, ImageURL, Rate, NoOfReviews, Discount);
            print(dentistProduct.ProductName);
            product_list.add(dentistProduct);

          }
          ProductList.assignAll(product_list);



        }
        finally
            {
              IsLoading(false);
            }

  }
}