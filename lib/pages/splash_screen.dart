import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_frenzy/constant/app_color.dart';
import 'package:food_frenzy/pages/homepage.dart';
import 'package:food_frenzy/pages/login.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: prefer_typing_uninitialized_variables
var email;
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    getValidation().whenComplete((){
      Timer(const Duration(seconds: 2), () { 
        (email == null) ? Get.to(const Login()) : Get.to(HomePage(email: email.toString()));
      });
    });
    super.initState();
  }

  Future getValidation() async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var getEmail = sharedPreferences.getString('email');
    email = getEmail;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.maxFinite.h,
          width: double.maxFinite.w,
          color: AppColor.mainColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: const AssetImage("assets/images/logo.webp"),
                height: 400.h,
                width: 800.w,
              ),
              SpinKitWave(
                itemBuilder: (context, index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: (index.isEven) ? Colors.blue : Colors.lime,
                    )
                  );
                },
              )
            ]
          ),
        )
      )
    );
  }
}