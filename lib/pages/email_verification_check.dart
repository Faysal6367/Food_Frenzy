import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_frenzy/constant/app_color.dart';
import 'package:food_frenzy/pages/homepage.dart';
import 'package:food_frenzy/widget/custom_text.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailVerificationCheck extends StatefulWidget {

  final String email;
  const EmailVerificationCheck({super.key, required this.email});

  @override
  State<EmailVerificationCheck> createState() => _EmailVerificationCheckState();
}

class _EmailVerificationCheckState extends State<EmailVerificationCheck> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
         height: double.maxFinite.h,
         width: double.maxFinite.w,
         color: Colors.white,
         child: Container(
          margin: EdgeInsets.only(top:650.h),
           child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: const AssetImage("assets/images/signup.jpg"),
                height: 300.h,
                width: 300.w,
              ),
              SizedBox(height: 80.h),
              MyText(text: "We've sent a verification link to", color: Colors.black, size: 55.sp, bold: true),
              MyText(text: widget.email.toString(), color: Colors.black, size: 55.sp, bold: true),
              SizedBox(height: 50.h),
              MyText(text: "Please check the verification link in your inbox", color: Colors.black, size: 42.sp, bold: false),
              SizedBox(height: 450.h),
              ElevatedButton(
                onPressed: () async{
                },  
                style: ButtonStyle(
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.sp)),
                )
                ),
                backgroundColor: MaterialStateProperty.all(AppColor.mainColor),
              ),
                child:  Padding(
                padding: EdgeInsets.only(top:40.h,bottom: 40.h,left: 280.w,right: 280.w),
                child: MyText(text: "Check Inbox", color: Colors.white, size: 50.sp, bold: false)
               ),
              ),

              SizedBox(height: 30.h),
              ElevatedButton(
                onPressed: () async{
                 SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                 sharedPreferences.setString('email', widget.email);
                 Get.to(HomePage(email: widget.email));
                },  
                style: ButtonStyle(
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.sp)),
                )
                ),
                backgroundColor: MaterialStateProperty.all(AppColor.mainColor),
              ),
                child:  Padding(
                padding: EdgeInsets.only(top:40.h,bottom: 40.h,left: 280.w,right: 280.w),
                child: MyText(text: "Verify My Email", color: Colors.white, size: 50.sp, bold: false)
               ),
              ),
            ],
           ),
         ),
       ),
      )
    );
  }
}