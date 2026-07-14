import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_frenzy/constant/app_color.dart';
import 'package:food_frenzy/services/cart_controller.dart';
import 'package:food_frenzy/services/cart_data.dart';
import 'package:food_frenzy/widget/custom_text.dart';
import 'package:get/get.dart';

class FoodCatagoryDesign extends StatefulWidget {
  final String collection;
  const FoodCatagoryDesign({super.key, required this.collection});

  @override
  State<FoodCatagoryDesign> createState() => _FoodCatagoryDesignState();
}

class _FoodCatagoryDesignState extends State<FoodCatagoryDesign> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite.h,
      width: double.maxFinite.w,
      color: Colors.white,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection(widget.collection).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.hasData){
            List<dynamic> foodList = snapshot.data!.docs.map((doc) => doc.data()).toList();
            return ListView.builder(
              itemCount: foodList.length,
              itemBuilder: (context, index) {
                Map<String,dynamic> foodData = foodList[index] as Map<String,dynamic>;
                return Container(
                  height: 300.h,
                  width: double.maxFinite.w,
                  margin: EdgeInsets.only(bottom: 25.h,top:25.h,left: 50.w,right: 50.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(50.sp)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.8),
                        offset: const Offset(0, 3),
                        spreadRadius: 5,
                        blurRadius: 7,
                      )
                    ],
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: 30.w,right: 30.w,top: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(text: foodData['name'], color: Colors.black, size: 50.sp, bold: true),
                            SizedBox(height: 10.h),
                            MyText(text: foodData['quantity'], color: Colors.black, size: 40.sp, bold: false),
                            SizedBox(height: 10.h),
                            MyText(text: foodData['restaurant'], color: Colors.black, size: 40.sp, bold: false),
                            SizedBox(height: 10.h),
                            Row(
                              children: [
                                MyText(text: 'TK ${foodData['price']}', color: Colors.black, size: 40.sp, bold: false),
                                SizedBox(width: 50.w),
                                (foodData.containsKey('popularity')) ? Container(
                                  height: 70.h,
                                  width: 350.w,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    borderRadius: BorderRadius.all(Radius.circular(50.sp))
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      MyText(text: foodData['popularity'], color: Colors.black, size: 40.sp, bold: false),
                                      Icon(
                                        CupertinoIcons.flame,
                                          size: 50.sp,
                                          color: Colors.black,
                                      ),
                                    ],
                                  ),
                                ) : SizedBox(
                                  height: 70.h,
                                  width: 350.w,
                                ),
                              ],
                            ),
                          ],
                        ),
                      Container(
                        height: 250.h,
                        width: 250.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50.sp)),
                            image: DecorationImage(
                              image: NetworkImage(foodData['url']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              height: 80.h,
                              width: 80.w,
                              margin: EdgeInsets.only(bottom: 10.h,right: 10.w),
                              decoration: BoxDecoration(
                                color: AppColor.mainColor,
                                  shape: BoxShape.circle,
                              ),
                              child: Center(
                              child: PopupMenuButton(
                                icon: Icon(
                                CupertinoIcons.add,
                                  size: 40.sp,
                                  color: Colors.white,
                                ),
                                itemBuilder: (context) =>[
                                  PopupMenuItem(
                                    value: 1,
                                    child: GestureDetector(
                                    onTap: (){
                                      CartController cartController = Get.find();
                                        cartController.addData(CartData(foodData['name'], foodData['price'], foodData['url'], foodData['restaurant']));
                                        Navigator.pop(context);
                                        Get.snackbar('FoodFrenzy', '${foodData['name']} added to cart',
                                          backgroundColor: AppColor.mainColor,
                                          colorText: Colors.white,
                                          duration: const Duration(seconds: 1),
                                        );
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          MyText(text: "Add to Cart", color: AppColor.mainColor, size: 40.sp, bold: true),
                                          Icon(
                                            CupertinoIcons.cart,
                                              size: 60.sp,
                                              color: AppColor.mainColor,
                                          ),
                                        ],
                                      ),
                                    )
                                  ),
                                ],  
                              ),
                            )
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ),                
                );
              },
            );
          }
          else{
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}