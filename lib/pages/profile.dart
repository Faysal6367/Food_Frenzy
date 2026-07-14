import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_frenzy/constant/app_color.dart';
import 'package:food_frenzy/pages/homepage.dart';
import 'package:food_frenzy/widget/custom_text.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String email = "";
  Map<String,String> userInfo = {};

  Future<void> getUserInformation()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userInfo['Email'] = sharedPreferences.getString('email')!;
    email = userInfo['Email'] = sharedPreferences.getString('email')!;

    if(sharedPreferences.containsKey('userName')){
      userInfo['User Name'] = sharedPreferences.getString('userName')!;
    }
    else{
      userInfo['User Name'] = "Not set yet";
    }
    if(sharedPreferences.containsKey('loc')){
      userInfo['Location'] = sharedPreferences.getString('loc')!;
    }
    else{
      userInfo['Location'] = "Not set yet";
    }

  }
  
  Timer? timer;
  void startTimer(){
  timer = Timer.periodic(const Duration(microseconds: 1), (time) { 
    getUserInformation();
    setState(() { });
  });
}


  

  @override
  void initState() {
    startTimer();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.maxFinite.h,
          width: double.maxFinite.w,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 250.h,
                width: double.maxFinite.w,
                color: Colors.white,
                child: Container(
                  margin: EdgeInsets.only(left: 50.w),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.to(HomePage(email: email));
                        },
                        child: Icon(
                          Icons.clear,
                          size: 80.sp,
                          color: AppColor.mainColor,
                        ),
                      ),
                      SizedBox(width: 100.w),
                      MyText(text: "Profile", color: AppColor.mainColor, size: 60.sp, bold: true),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  height: 1901.h,
                  width: double.maxFinite.w,
                  color: Colors.transparent,
                  margin: EdgeInsets.only(left: 50.w,right: 50.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 100.h),
                      MyText(text: "User Information", color: Colors.black, size: 60.sp, bold: true),
                      SizedBox(height: 50.h),
                      Container(
                        height: 950.h,
                        color: Colors.transparent,
                        child: ListView.builder(
                          itemCount: userInfo.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 250.h,
                              width: double.maxFinite.w,
                              margin: EdgeInsets.only(bottom: 50.h),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(40.sp))
                              ),
                              child: ListTile(
                                title: MyText(text: userInfo.keys.elementAt(index), color: Colors.black, size: 50.sp, bold: true),
                                subtitle: MyText(text: userInfo.values.elementAt(index), color:  Colors.black, size: 40.sp, bold: false),
                                trailing: Icon(Icons.edit,
                                  size: 70.sp,
                                  color: AppColor.mainColor,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      MyText(text: "Connected Accounts", color: Colors.black, size: 60.sp, bold: true),
                      SizedBox(height: 50.h),
                      Container(
                        height: 250.h,
                        width: double.maxFinite.w,
                        margin: EdgeInsets.only(bottom: 50.h),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(40.sp))
                        ),
                        child: ListTile(
                          title: MyText(text: "Facebook", color: Colors.black, size: 50.sp, bold: true),
                          leading: Icon(Icons.facebook,
                            size: 120.sp,
                            color: Colors.blue,
                          ),
                          trailing: MyText(text: "Connect", color: AppColor.mainColor , size: 50.sp, bold: true),
                        ),
                      ),
                      Container(
                        height: 250.h,
                        width: double.maxFinite.w,
                        margin: EdgeInsets.only(bottom: 50.h),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(40.sp))
                        ),
                        child: ListTile(
                          title: MyText(text: "Google", color: Colors.black, size: 50.sp, bold: true),
                          subtitle: MyText(text: "Connected", color: Colors.green, size: 50.sp, bold: false),
                          leading: Image(
                            image: const AssetImage("assets/images/google.jpg"),
                            height: 1320.h,
                            width: 130.w,
                          ),
                          trailing: Icon(Icons.clear,
                            size: 90.sp,
                            color: AppColor.mainColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}