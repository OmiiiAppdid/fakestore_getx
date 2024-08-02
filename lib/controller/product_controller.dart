import 'package:fakestore_app_getx/model/products_model.dart';
import 'package:fakestore_app_getx/services/remote_services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var productList = <Product>[].obs;

  // @override
  // void onInit() {
  //   fetchProducts(sName);
  //   super.onInit();
  // }

  void fetchProducts(String name) async {
    var products = await RemoteServices().fetchProducts(sName: name);
    if (products.isNotEmpty) {
      productList.value = products;
      print(" Products :: ${products}");
    }
    update();
  }
}
