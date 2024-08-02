import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Sty {
  TextStyle microText = TextStyle(
    letterSpacing: 0.5,
    color: Clr().textcolor,
    fontSize: 12.0,
  );
  TextStyle smallText = TextStyle(
    letterSpacing: 0.5,
    color: Clr().textcolor,
    fontSize: 14.0,
  );
  TextStyle mediumText = TextStyle(
    letterSpacing: 0.5,
    color: Clr().textcolor,
    fontSize: 16.0,
  );
  TextStyle mediumBoldText = TextStyle(
    letterSpacing: 0.5,
    color: Clr().textcolor,
    fontSize: 16.0,
    fontWeight: FontWeight.w700,
  );
  TextStyle largeText = TextStyle(
    letterSpacing: 0.5,
    color: Clr().textcolor,
    fontSize: 18.0,
    fontWeight: FontWeight.w700,
  );
  TextStyle extraLargeText = TextStyle(
    letterSpacing: 0.5,
    color: Clr().textcolor,
    fontSize: 24.0,
    fontWeight: FontWeight.w600,
  );

  InputDecoration textFieldOutlineStyle = InputDecoration(
    contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 0),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: Clr().formBorder,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: Clr().primaryColor,
      ),
    ),
  );
}

class Clr {
  Color primaryColor = const Color(0xff2ca9bc);
  Color primaryLightColor = const Color(0xff9dff9d);
  Color greenColor = const Color(0xff0BCE83);
  Color textcolor = const Color(0xFF111111);
  Color textSecondary = const Color(0xFF9586A8);
  Color white = const Color(0xFFFFFFFF);
  Color bgWhite = const Color(0xFFf2f2f2);
  Color black = const Color(0xFF000000);
  Color shimmerColor = const Color(0xFFABABAB);
  Color formBorder = const Color(0xFFD9D0E3);
  Color red = const Color(0xFFFF0000);
  Color borderColor = const Color(0xFFf3f3f3);
  Color hintColor = const Color(0xFF949494);
  Color grey = const Color(0xFF939097);
}

class STM {
  Future<bool> checkInternet(context, widget) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return true;
    } else {
      internetAlert(context, widget);
      return false;
    }
  }

  Future<dynamic> getwithToken(ctx, title, name, token) async {
    AwesomeDialog dialog = STM().loadingDialog(ctx, title);
    dialog.show();
    Dio dio = Dio(
      BaseOptions(
        headers: {
          "Content-Type": "application/json",
          "responseType": "ResponseType.plain",
          "Authorization": "Bearer $token",
        },
      ),
    );
    String url = AppUrl.mainUrl + name;
    if (kDebugMode) {
      // print("Url = $url\nBody = ${body.fields}");
    }
    dynamic result;
    try {
      Response response = await dio.get(url);
      if (kDebugMode) {
        print("Response = $response");
      }
      if (response.statusCode == 200) {
        dialog.dismiss();
        result = response.data;
      }
    } on DioError catch (e) {
      STM().errorDialog(ctx, e.message.toString());
    }
    return result;
  }

  Future<dynamic> get(ctx, title, name) async {
    AwesomeDialog dialog = STM().loadingDialog(ctx, title);
    dialog.show();
    Dio dio = Dio(
      BaseOptions(
        headers: {
          "Content-Type": "application/json",
          "responseType": "ResponseType.plain",
          // "Authorization": "Bearer $token",
        },
      ),
    );
    String url = AppUrl.mainUrl + name;
    dynamic result;
    try {
      Response response = await dio.get(url);
      if (kDebugMode) {
        print("Response = $response");
      }
      if (response.statusCode == 200) {
        dialog.dismiss();
        result = response.data;
      }
    } on DioError catch (e) {
      STM().errorDialog(ctx, e.message.toString());
    }
    return result;
  }

  Future<dynamic> post(ctx, title, name, body) async {
    //Dialog
    AwesomeDialog dialog = STM().loadingDialog(ctx, title);
    dialog.show();
    Dio dio = Dio(
      BaseOptions(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.plain,
      ),
    );
    String url = AppUrl.mainUrl + name;
    if (kDebugMode) {
      print("Url = $url\nBody = ${body.fields}");
    }
    dynamic result;
    try {
      Response response = await dio.post(url, data: body);
      if (kDebugMode) {
        print("Response = $response");
      }
      if (response.statusCode == 200) {
        dialog.dismiss();
        result = json.decode(response.data.toString());
      }
    } on DioError catch (e) {
      debugPrint(e.message);
      // STM().errorDialog(ctx, e.message);
    }
    return result;
  }

  Future<dynamic> postWithToken(ctx, title, name, body, token) async {
    //Dialog
    AwesomeDialog dialog = STM().loadingDialog(ctx, title);
    dialog.show();
    Dio dio = Dio(
      BaseOptions(
        headers: {
          "Content-Type": "application/json",
          "responseType": "ResponseType.plain",
          "Authorization": "Bearer $token",
        },
      ),
    );
    String url = AppUrl.mainUrl + name;
    if (kDebugMode) {
      print("Url = $url\nBody = ${body.fields}");
    }
    dynamic result;
    try {
      Response response = await dio.post(url, data: body);
      if (kDebugMode) {
        print("Response = $response");
      }
      if (response.statusCode == 200) {
        dialog.dismiss();
        result = response.data;
        // result = json.decode(response.data.toString());
      }
    } on DioError catch (e) {
      dialog.dismiss();
      STM().errorDialog(ctx, e.message.toString());
    }
    return result;
  }

  AwesomeDialog loadingDialog(BuildContext context, String title) {
    AwesomeDialog dialog = AwesomeDialog(
      width: 250,
      context: context,
      dismissOnBackKeyPress: true,
      dismissOnTouchOutside: false,
      dialogType: DialogType.noHeader,
      animType: AnimType.scale,
      body: WillPopScope(
        onWillPop: () async {
          displayToast('Something went wrong try again.');
          return true;
        },
        child: Container(
          height: 160,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Clr().white,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(12),
                child: SpinKitSquareCircle(
                  color: Clr().primaryColor,
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.all(4),
              //   child:Lottie.asset('animation/ShrmaAnimation.json',height: 90,
              //       fit: BoxFit.cover),
              // ),
              // SizedBox(
              //   height: 16,
              // ),
              Text(
                title,
                style: Sty().mediumBoldText,
              ),
            ],
          ),
        ),
      ),
    );
    return dialog;
  }

  void successDialogWithAffinity(
      BuildContext context, String message, Widget widget) {
    AwesomeDialog(
            dismissOnBackKeyPress: false,
            dismissOnTouchOutside: false,
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.scale,
            headerAnimationLoop: true,
            title: 'Success',
            desc: message,
            btnOkText: "OK",
            btnOkOnPress: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => widget,
                ),
                (Route<dynamic> route) => false,
              );
            },
            btnOkColor: Clr().greenColor)
        .show();
  }

  void errorDialog(BuildContext context, String message) {
    AwesomeDialog(
            context: context,
            dismissOnBackKeyPress: false,
            dismissOnTouchOutside: false,
            dialogType: DialogType.error,
            animType: AnimType.scale,
            headerAnimationLoop: true,
            title: 'Note',
            desc: message,
            btnOkText: "OK",
            btnOkOnPress: () {},
            btnOkColor: Clr().red)
        .show();
  }

  internetAlert(context, widget) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.scale,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // SizedBox(child: Lottie.asset('assets/no_internet_alert.json')),
            Text(
              'Connection Error',
              style: Sty().largeText.copyWith(
                    color: Clr().primaryColor,
                    fontSize: 18.0,
                  ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'No Internet connection found.',
              style: Sty().smallText,
            ),
            SizedBox(
              height: 32,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                  ),
                ),
                onPressed: () async {
                  var connectivityResult =
                      await (Connectivity().checkConnectivity());
                  if (connectivityResult == ConnectivityResult.mobile ||
                      connectivityResult == ConnectivityResult.wifi) {
                    Navigator.pop(context);
                    STM().replacePage(context, widget);
                  }
                },
                child: Text(
                  "Try Again",
                  style: Sty().largeText.copyWith(
                        color: Clr().white,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    ).show();
  }

  void redirect2page(BuildContext context, Widget widget) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  /// Google SignIn for Task
  // Future<void> signup(BuildContext context) async {
  //   try {
  //     final GoogleSignIn googleSignIn = GoogleSignIn();
  //     googleSignIn.signOut();
  //     final GoogleSignInAccount? googleSignInAccount =
  //     await googleSignIn.signIn();
  //     if (googleSignInAccount != null) {
  //       final GoogleSignInAuthentication googleSignInAuthentication =
  //       await googleSignInAccount.authentication;
  //       final AuthCredential authCredential = GoogleAuthProvider.credential(
  //           idToken: googleSignInAuthentication.idToken,
  //           accessToken: googleSignInAuthentication.accessToken);
  //       // Getting users credential
  //       UserCredential result = await auth.signInWithCredential(authCredential);
  //       User? user = result.user;
  //       if (user != null) {
  //         setState(() {
  //           emailCtrl = TextEditingController(text: user.email);
  //           print(emailCtrl.text);
  //           login = true;
  //           Login();
  //         });
  //       }
  //     } else {
  //       // STM().displayToast('Gmail id is not register.');
  //     }
  //   } catch (_) {
  //     STM().displayToast('Gmail id is not register.');
  //   }
  // }

  void replacePage(BuildContext context, Widget widget) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => widget,
      ),
    );
  }

  void back2Previous(BuildContext context) {
    Navigator.pop(context);
  }

  void displayToast(String string) {
    Fluttertoast.showToast(
      msg: string,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  void finishAffinity(final BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => widget,
      ),
      (Route<dynamic> route) => false,
    );
  }
}

class AppUrl {
  static String mainUrl = "https://fakestoreapi.com/";
}
