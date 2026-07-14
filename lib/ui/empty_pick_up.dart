import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_frenzy/constant/app_color.dart';
import 'package:food_frenzy/pages/foods.dart';
import 'package:food_frenzy/widget/custom_text.dart';
import 'package:get/get.dart';

class EmptyPickUp extends StatefulWidget {
  const EmptyPickUp({super.key});

  @override
  State<EmptyPickUp> createState() => _EmptyPickUpState();
}

class _EmptyPickUpState extends State<EmptyPickUp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1900.h,
      width: double.maxFinite.w,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage("assets/images/empty_pickUp.jpg"),
          ),
          Container(
            height: 600.h,
            width: double.maxFinite.w,
            margin: EdgeInsets.all(50.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: const Offset(0,3),
                  blurRadius: 20.sp,
                  spreadRadius: 10.sp,
                ),
              ]
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      height: 300.h,
                      width: 500.w,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/empty_order.gif"),
                        ),
                      ),
                    ),
                    SizedBox(width: 80.w),
                    MyText(text: "No order!", color: AppColor.mainColor, size: 60.sp, bold: false),
                    SizedBox(width: 30.w),
                    Icon(
                      Icons.restaurant_menu,
                      size: 60.sp,
                      color: AppColor.mainColor,
                    ),
                    SizedBox(width: 60.w),
                  ],
                ),
                SizedBox(height: 50.h),
                ElevatedButton(
                  onPressed: (){
                     Get.to(const Food());     
                  }, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.mainColor,
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.sp),
                    )
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top:30.h,bottom: 30.h,left: 100.w,right: 100.w),
                      child: Text('Order now !',
                        style: TextStyle(
                        fontSize: 50.sp,
                        color: Colors.white,
                        ),
                      ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}