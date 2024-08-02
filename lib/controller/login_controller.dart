// import 'dart:convert';
//
// import 'package:fakestore_app_getx/utils/app_url.dart';
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class LoginController extends GetxController {
//   TextEditingController userNameCtrl = TextEditingController();
//   TextEditingController passwordCtrl = TextEditingController();
//
//   Future<void> loginAPI() async {
//     try {
//       var header = {'Content-Type': 'application/json'};
//       var url = Uri.parse(AppUrl.mainUrl + AppUrl.authEndPoints.login);
//       Map body = {
//         "name" : userNameCtrl.text,
//         "password" : passwordCtrl.text.trim(),
//       };
//
//       var response = await http.post(url, body: jsonEncode(body)));
//     } catch (e) {}
//   }
// }
