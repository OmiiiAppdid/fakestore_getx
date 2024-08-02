import 'package:fakestore_app_getx/model/proDetails_model.dart';
import 'package:fakestore_app_getx/services/remote_services.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

class ProDetailsController extends GetxController {
  var details = ProductDetails(
    id: 0,
    title: '',
    price: 0.0,
    description: '',
    category: '',
    image: '',
    rating: Rating(rate: 0.0, count: 0),
  ).obs;

  void getDetails(int id) async {
    var pDetails = await RemoteServices().fetchProDetails(id);
    if (pDetails != null) {
      details.value = pDetails;
      debugPrint("Pro Details :: $pDetails");
    }
  }
}
