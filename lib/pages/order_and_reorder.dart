import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_frenzy/constant/app_color.dart';
import 'package:food_frenzy/pages/splash_screen.dart';
import 'package:food_frenzy/services/cart_controller.dart';
import 'package:food_frenzy/services/cart_data.dart';
import 'package:food_frenzy/widget/custom_text.dart';
import 'package:get/get.dart';

class OrderAndReorder extends StatefulWidget {
  const OrderAndReorder({super.key});

  @override
  State<OrderAndReorder> createState() => _OrderAndReorderState();
}

class _OrderAndReorderState extends State<OrderAndReorder> {
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
                        Get.back();
                      },
                      child: Icon(
                        Icons.clear,
                        size: 60.sp,
                        color: AppColor.mainColor,
                      ),
                    ),
                    SizedBox(width: 100.w),
                    MyText(text: "Orders & reordering", color: Colors.black, size: 60.sp, bold: true),
                  ],
                ),
              ),
              Divider(
                thickness: 3.sp,
                color: Colors.grey,
              ),
              SizedBox(height: 50.h),
              Container(
                height: 1856.h,
                width: double.maxFinite.w,
                color: Colors.white,
                margin: EdgeInsets.only(left: 30.w,right: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(text: "Past orders", color: Colors.black, size: 60.sp, bold: true),
                    Container(
                      height: 1780.h,
                      width: double.maxFinite.w,
                      color: Colors.transparent,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection(email).snapshots(),
                        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if(snapshot.hasData){
                            List<dynamic> ordersList = snapshot.data!.docs.map((doc) => doc.data()).toList();
                            return ListView.builder(
                              itemCount: ordersList.length,
                              itemBuilder: (context, index) {
                                Map<String,dynamic> orderData = ordersList[index] as Map<String,dynamic>;
                                return Container(
                                  height: 450.h,
                                  width: double.maxFinite.w,
                                  margin: EdgeInsets.only(bottom: 30.h,top: 30.h),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(20.sp)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: const Offset(0,3),
                                        blurRadius: 20.sp,
                                        spreadRadius: 10.sp,
                                      )
                                    ]
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SizedBox(width: 20.w),
                                          Container(
                                            height: 300.h,
                                            width: 300.w,
                                            decoration: BoxDecoration(
                                              color: AppColor.mainColor,
                                              image: DecorationImage(
                                                image: NetworkImage(orderData['image-url']),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 20.w),
                                          Container(
                                            height: 300.h,
                                            width: 500.w,
                                            color: Colors.transparent,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(orderData['name'],
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 50.sp,
                                                    fontWeight: FontWeight.bold,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                SizedBox(height: 20.h),
                                                Text(orderData['restaurant'],
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 50.sp,
                                                    fontWeight: FontWeight.normal,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                SizedBox(height: 20.h),
                                                Text(orderData['date-time'],
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 40.sp,
                                                    fontWeight: FontWeight.normal,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),   
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 10.w),
                                          MyText(text: "Tk ${orderData['price']}", color: Colors.black, size: 40.sp, bold: true),
                                        ],
                                      ),
                                      ElevatedButton(
                                        onPressed: (){
                                           CartController cartController = Get.find();
                                           cartController.addData(CartData(orderData['name'], orderData['price'], orderData['image-url'], orderData['restaurant']));
                                           Get.snackbar('FoodFrenzy', '${orderData['name']} added to cart',
                                              backgroundColor: AppColor.mainColor,
                                              colorText: Colors.white,
                                              duration: const Duration(seconds: 1),
                                          );
                                        }, 
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColor.mainColor,
                                          shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20.sp),
                                          )
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(top:20.h,bottom: 20.h,left: 150.w,right: 150.w),
                                            child: Text('Select item for reorder',
                                              style: TextStyle(
                                              fontSize: 50.sp,
                                              color: Colors.white,
                                              ),
                                            ),
                                        ),
                                      ),
                                    ],
                                  )
                                );
                              },
                            );
                          }
                          else{
                            return Container(

                            );
                          }
                        },
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