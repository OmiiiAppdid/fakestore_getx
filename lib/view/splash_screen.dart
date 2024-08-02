import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../static_methods/styles.dart';
import 'login_screen.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {

    Timer(const Duration(seconds: 3), () {
      return STM().finishAffinity(context, const LoginScreen());
    });

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SvgPicture.asset(
                  "assets/cart_logo.svg",
                  // color: Clr().primaryColor,
                  width: 450,
                  height: 450,
                )
                    .animate()
                    .rotate(
                  begin: -0.0,
                  end: -0.5,
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeInOutQuad,
                )
                    .rotate(
                  delay: const Duration(milliseconds: 1000),
                  begin: -0.0,
                  end: -0.5,
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeInOutQuad,
                )
                    .scale(
                  delay: const Duration(milliseconds: 1000),
                  end: const Offset(.5, .5),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "FakeStore",
                style: Sty()
                    .largeText
                    .copyWith(fontSize: 32, fontWeight: FontWeight.w600),
              ).animate().fadeIn(
                delay: const Duration(milliseconds: 1100),
                duration: const Duration(milliseconds: 700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
