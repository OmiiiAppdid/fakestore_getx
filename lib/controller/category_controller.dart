import 'package:fakestore_app_getx/services/remote_services.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  var categoryList = <String>[].obs;

  @override
  void onInit() {
    getCategories();
    super.onInit();
  }

  void getCategories() async {
    var categories = await RemoteServices().fetchCategories();
    if(categories.isNotEmpty){
      categoryList.value = categories;
    }
  }

}