import 'dart:convert';

import 'package:fakestore_app_getx/model/category_model.dart';
import 'package:fakestore_app_getx/model/products_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../model/proDetails_model.dart';

class RemoteServices {
  ///Fetch Products APi
  Future<List<Product>> fetchProducts({sName}) async {
    // var response = await http.get(Uri.parse("https://fakestoreapi.com/products/category/electronics"));
    var response = await http
        .get(Uri.parse("https://fakestoreapi.com/products/category/${sName}"));
    print("Api Response == ${response.body}");
    if (response.statusCode == 200) {
      return productFromJson(response.body);
    } else {
      throw Exception("Network Errorrrrrrr ");
    }
  }

  ///Fetch Product categories APi
  Future<List<String>> fetchCategories() async {
    var response = await http
        .get(Uri.parse("https://fakestoreapi.com/products/categories"));
    print("Category Api Response == ${response.body}");
    if (response.statusCode == 200) {
      return categoryFromJson(response.body);
    } else {
      throw Exception("Network Errorrrrrrr ");
    }
  }

  ///Fetch Product Details APi
  Future<ProductDetails?> fetchProDetails(int id) async {
    print("Api Id :: $id");
    var response = await http.get(Uri.parse("https://fakestoreapi.com/products/$id"));
    debugPrint("Response :: ${response.body}");
    if (response.statusCode == 200) {
      return ProductDetails.fromJson(json.decode(response.body));
    } else {
      throw Exception("Network Error");
    }
  }

// Future<ProductDetails?> fetchProDetails(int id) async {
//   print("Api Id :: $id");
//   var response = await http.get(Uri.parse("https://fakestoreapi.com/products/$id"));
//   debugPrint("Response :: ${response.body}");
//   if (response.statusCode == 200) {
//     return ProductDetails.fromJson(json.decode(response.body));
//   } else {
//     throw Exception("Network Error");
//   }
// }
}
