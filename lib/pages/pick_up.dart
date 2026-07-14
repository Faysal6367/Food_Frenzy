import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_frenzy/constant/app_color.dart';
import 'package:food_frenzy/pages/cart.dart';
import 'package:food_frenzy/pages/homepage.dart';
import 'package:food_frenzy/pages/splash_screen.dart';
import 'package:food_frenzy/ui/empty_pick_up.dart';
import 'package:food_frenzy/widget/custom_text.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PickUp extends StatefulWidget {
  const PickUp({super.key});

  @override
  State<PickUp> createState() => _PickUpState();
}

class _PickUpState extends State<PickUp> {  

  int _totalSeconds = 1 * 60;
  DateTime _countdownStartTime = DateTime.now();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    if(_totalSeconds<=0){
      remove();
    }
    _loadCountdownStartTime();
    _startTimer();
  }

  Future remove() async{
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     sharedPreferences.remove('countdown_start_time');
     order = false;
     setState(() {
            
     });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _loadCountdownStartTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? savedStartTimeInMillis = prefs.getInt('countdown_start_time');
    if (savedStartTimeInMillis != null) {
      _countdownStartTime = DateTime.fromMillisecondsSinceEpoch(savedStartTimeInMillis);
      DateTime currentTime = DateTime.now();
      int elapsedSeconds = currentTime.difference(_countdownStartTime).inSeconds;
      if (elapsedSeconds >= 0 && elapsedSeconds <= _totalSeconds) {
        _totalSeconds -= elapsedSeconds;
      } else {
        _totalSeconds = 0;
      }
    }
  }

  Future<void> _saveCountdownStartTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('countdown_start_time', _countdownStartTime.millisecondsSinceEpoch);
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_totalSeconds > 0) {
          _totalSeconds--;
          _saveCountdownStartTime();
        } else {
          timer.cancel();
          remove();
        }
      });
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.maxFinite.h,
          width: double.maxFinite.w,
          color: Colors.white,
          child : Column(
            children: [
              Container(
                height: 200.h,
                width: double.maxFinite.w,
                color: Colors.white,
                child: Row(
                  children: [
                    SizedBox(width: 50.w),
                    GestureDetector(
                      onTap: (){
                        Get.to(HomePage(email: email));
                      },
                      child: Icon(
                        Icons.clear,
                        size: 70.sp,
                        color: AppColor.mainColor,
                      ),
                    ),
                    SizedBox(width: 100.w),
                    MyText(text: "Pick Up", color: AppColor.mainColor, size: 60.sp, bold: true),
                  ],
                ),
              ),
              SizedBox(height: 50.h),
              Container(
                height: 1900.h,
                width: double.maxFinite.w,
                color: Colors.white,
                //margin: EdgeInsets.only(left: 30.w,right: 30.w),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (!order)? const EmptyPickUp() : Container(
                      height: 1900.h,
                      width: double.maxFinite.w,
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 200.h,
                            width: double.maxFinite.w,
                            color: Colors.transparent,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: ScreenUtil().setHeight(70),
                                  bottom: ScreenUtil().setHeight(110),
                                  left: ScreenUtil().setWidth(0),
                                  right: ScreenUtil().setWidth(0),     
                                  child: AnimatedContainer(
                                    duration: const Duration(seconds: 1),  
                                    color: AppColor.mainColor,
                                  )
                                ),
                                Positioned(
                                  top: ScreenUtil().setHeight(40),
                                  bottom: ScreenUtil().setHeight(80),
                                  left: ScreenUtil().setWidth(0),
                                  right: ScreenUtil().setWidth(600),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColor.mainColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: MyText(text: "1", color: Colors.white, size: 40.sp, bold: false),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: ScreenUtil().setHeight(40),
                                  bottom: ScreenUtil().setHeight(80),
                                  left: ScreenUtil().setWidth(30),
                                  right: ScreenUtil().setWidth(0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColor.mainColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: MyText(text: "2", color: Colors.white, size: 40.sp, bold: false),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: ScreenUtil().setHeight(40),
                                  bottom: ScreenUtil().setHeight(80),
                                  left: ScreenUtil().setWidth(620),
                                  right: ScreenUtil().setWidth(0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColor.mainColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: MyText(text: "3", color: Colors.white, size: 40.sp, bold: false),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 170.w),
                              MyText(text: "Menu", color: AppColor.mainColor, size: 50.sp, bold: false),
                              SizedBox(width: 210.w),
                              MyText(text: "Cart", color: AppColor.mainColor, size: 50.sp, bold: false),
                              SizedBox(width: 150.w),
                              MyText(text: "OrderFood", color: AppColor.mainColor, size: 50.sp, bold: false),
                            ],
                          ),
                          Container(
                            height: 400.h,
                            width: double.maxFinite.w,
                            margin: EdgeInsets.only(top:100.h,left: 50.w,right: 50.w,bottom: 50.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: const Offset(0,3),
                                  spreadRadius: 10.sp,
                                  blurRadius: 20.sp,
                                ),
                              ]
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyText(text: "Estimated Delivery Time", color: Colors.black, size: 60.sp, bold: false),
                                MyText(text: _formatTime(_totalSeconds), color: Colors.black, size: 50, bold: true), 
                              ],
                            ),
                          ),
                          Container(
                            height: 400.h,
                            width: double.maxFinite.w,
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                              image: DecorationImage(
                                image: AssetImage("assets/images/order.gif"),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 320.w),
                            child: MyText(text: "Get your order!", color: Colors.black, size: 70.sp, bold: true)
                          ),
                          Container(
                            height: 400.h,
                            width: double.maxFinite.w,
                            margin: EdgeInsets.all(50.sp),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                image: AssetImage("assets/images/discount.jpg"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),   
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}