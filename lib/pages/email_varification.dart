import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_frenzy/constant/app_color.dart';
import 'package:food_frenzy/pages/email_verification_check.dart';
import 'package:food_frenzy/widget/custom_text.dart';

class EmailVarification extends StatefulWidget {
  final User ? user;
  final String ? email;
  const EmailVarification({super.key, this.user, required this.email});

  @override
  State<EmailVarification> createState() => _EmailVarificationState();
}

class _EmailVarificationState extends State<EmailVarification> {
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
              MyText(text: "Verify your email address to get started", color: Colors.black, size: 55.sp, bold: true),
              SizedBox(height: 50.h),
              MyText(text: "This helps us mitigate fraud and keep your personal", color: Colors.black, size: 42.sp, bold: false),
              MyText(text: "data safe", color: Colors.black, size: 42.sp, bold: false),
              SizedBox(height: 650.h),
              ElevatedButton(
                onPressed: () async{
                  if(widget.user!=null){
                    await widget.user!.sendEmailVerification();
                    final sendEmail = widget.email;
                    // ignore: use_build_context_synchronously
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>EmailVerificationCheck(email: sendEmail.toString())));
                  }
                },  
                style: ButtonStyle(
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.sp)),
                )
                ),
                backgroundColor: MaterialStateProperty.all(AppColor.mainColor),
              ),
                child:  Padding(
                padding: EdgeInsets.only(top:40.h,bottom: 40.h,left: 200.w,right: 200.w),
                child: MyText(text: "Send Verification email", color: Colors.white, size: 50.sp, bold: false)
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