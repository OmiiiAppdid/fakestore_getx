import 'package:fakestore_app_getx/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_button/sign_in_button.dart';
import '../../static_methods/styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    _auth.authStateChanges().listen((event) {
      setState(() {
        _user = event;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Clr().bgWhite,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 110,
            ),
            SvgPicture.asset(
              "assets/cart_logo.svg",
              width: 150,
              // color: Clr().primaryColor,
            ),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: userCtrl,
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              cursorColor: Clr().hintColor,
              style: Sty().mediumText,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              obscureText: false,
              decoration: Sty().textFieldOutlineStyle.copyWith(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 0.3),
                      borderRadius: BorderRadius.circular(18)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: userCtrl.text.isNotEmpty
                          ? Clr().primaryColor
                          : Clr().hintColor,
                    ),
                  ),
                  hintStyle: Sty().smallText.copyWith(
                        color: Clr().grey,
                      ),
                  hintText: "Enter Username",
                  counterText: "",
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 14,
                  ),
                  prefixIconConstraints:
                      BoxConstraints(minWidth: 23, maxHeight: 20),
                  prefixIcon: Padding(
                      padding: const EdgeInsets.only(right: 8, left: 12),
                      child: Icon(Icons.person,
                          color: userCtrl.text.isEmpty
                              ? Clr().hintColor
                              : Clr().primaryColor))),
              maxLength: 6,
            ),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: passCtrl,
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              cursorColor: Clr().hintColor,
              style: Sty().mediumText,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              obscureText: false,
              decoration: Sty().textFieldOutlineStyle.copyWith(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 0.3),
                        borderRadius: BorderRadius.circular(18)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: passCtrl.text.isNotEmpty
                            ? Clr().primaryColor
                            : Clr().hintColor,
                      ),
                    ),
                    hintStyle: Sty().smallText.copyWith(
                          color: Clr().grey,
                        ),
                    hintText: "Enter Password",
                    counterText: "",
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 14,
                    ),
                    prefixIconConstraints:
                        const BoxConstraints(minWidth: 23, maxHeight: 20),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(right: 8, left: 12),
                      child: Icon(
                        Icons.lock,
                        color: passCtrl.text.isEmpty
                            ? Clr().hintColor
                            : Clr().primaryColor,
                      ),
                    ),
                  ),
              maxLength: 6,
            ),
            const SizedBox(
              height: 32,
            ),
            Center(
              child: SizedBox(
                height: 48,
                width: MediaQuery.of(context).size.width / 1.2,
                child: ElevatedButton(
                  onPressed: () {
                    if (passCtrl.text.isNotEmpty && userCtrl.text.isNotEmpty) {
                      loginAPI();
                    } else if (passCtrl.text.isEmpty && userCtrl.text.isEmpty) {
                      STM().displayToast("Please enter username & password");
                    } else if (userCtrl.text.isEmpty) {
                      STM().displayToast("Please enter username");
                    } else if (passCtrl.text.isEmpty) {
                      STM().displayToast("Please enter password");
                    }
                  },
                  // style: ElevatedButton.styleFrom(
                  //     backgroundColor: Clr().greenColor, elevation: 1),
                  child: Text(
                    "Sign In",
                    style: Sty().mediumText.copyWith(
                        color: Clr().white, fontWeight: FontWeight.w500),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          passCtrl.text.isNotEmpty && userCtrl.text.isNotEmpty
                              ? Clr().primaryColor
                              : Clr().hintColor.withOpacity(0.5),
                      elevation:
                          passCtrl.text.isNotEmpty && userCtrl.text.isNotEmpty
                              ? 1
                              : 0),
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Center(
              child: SizedBox(
                height: 48,
                width: MediaQuery.of(context).size.width / 1.2,
                child: ElevatedButton(
                  onPressed: () {
                    _handeleGoogleSignin();

                  },
                  child: Text(
                    "Sign In With Google",
                    style: Sty().mediumText.copyWith(
                        color: Clr().white, fontWeight: FontWeight.w500),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Clr().primaryColor,
                      elevation:
                          passCtrl.text.isNotEmpty && userCtrl.text.isNotEmpty
                              ? 1
                              : 0),
                ),
              ),
            ),
            _user != null ? _userInfo() : _googleSignInButton()
          ],
        ),
      ),
    );
  }

  Widget _googleSignInButton() {
    return Center(
      child: SignInButton(
        Buttons.google,
        onPressed: () {
          _handeleGoogleSignin();
        },
        text: "Sign In With Google",
      ),
    );
  }

  Widget _userInfo() {
    return const SizedBox();
  }

  void _handeleGoogleSignin() {
    try {
      GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
      _auth.signInWithProvider(_googleAuthProvider);
    } catch(error) {
      print("Error :: $error");
    }
  }

  ///Login API
  void loginAPI() async {
    var result = await STM().get(context, "Signin In...", "users");

    setState(() {
      STM().finishAffinity(context, HomeScreen());
    });
  }
}
