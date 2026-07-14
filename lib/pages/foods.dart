import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_frenzy/constant/app_color.dart';
import 'package:food_frenzy/pages/cart.dart';
import 'package:food_frenzy/pages/homepage.dart';
import 'package:food_frenzy/pages/search.dart';
import 'package:food_frenzy/pages/splash_screen.dart';
import 'package:food_frenzy/services/cart_controller.dart';
import 'package:food_frenzy/services/cart_data.dart';
import 'package:food_frenzy/widget/custom_text.dart';
import 'package:get/get.dart';

class Food extends StatefulWidget {
  const Food({super.key});

  @override
  State<Food> createState() => _FoodState();
}

class _FoodState extends State<Food> {


  final fireStore = FirebaseFirestore.instance.collection('Food');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.maxFinite.h,
          width: double.maxFinite.w,
          decoration: const BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              //fit: BoxFit.fill,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0.h,
                left: 0.w,
                right: 0.w,
                bottom: 1600.h,
                child: Container(
                  height: 500.h,
                  width: double.maxFinite.w,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/burger.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: 500.h,
                  left: 0.w,
                  right: 0.w,
                  bottom: 0.h,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.sp),
                        topRight: Radius.circular(50.sp),
                      ),
                      image: const DecorationImage(
                      image: AssetImage("assets/images/background.jpg"),
                      fit: BoxFit.cover,
                     ),
                    ),
                    child: SingleChildScrollView(
                      child: Container(
                          height: 1600.h,
                          width: double.maxFinite.w,
                          color: Colors.transparent,
                          margin: EdgeInsets.only(top: 50.h,left: 30.w,right: 30.w),
                          child: Column(
                            children: [
                              Container(
                                height: 150.h,
                                width: double.maxFinite.w,
                                color: Colors.transparent,
                                child:Row(
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        Get.to(HomePage(email: email));
                                      },
                                      child: Icon(
                                        Icons.arrow_back,
                                        size: 90.sp,
                                        color: AppColor.mainColor,
                                      ),
                                    ),
                                    SizedBox(width: 520.w),
                                    GestureDetector(
                                      onTap: (){
                                        Get.to(HomePage(email: email));
                                      },
                                      child: Icon(
                                        Icons.favorite_border,
                                        size: 90.sp,
                                        color: AppColor.mainColor,
                                      ),
                                    ),
                                    SizedBox(width: 50.w),
                                    GestureDetector(
                                      onTap: (){
                                        Get.to(const Search());
                                      },
                                      child: Icon(
                                        Icons.search,
                                        size: 90.sp,
                                        color: AppColor.mainColor,
                                      ),
                                    ),
                                    SizedBox(width: 50.w),
                                    GestureDetector(
                                      onTap: (){
                                        Get.to(const Cart());
                                      },
                                      child: Icon(
                                        CupertinoIcons.cart,
                                        size: 90.sp,
                                        color: AppColor.mainColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 150.h,
                                width: double.maxFinite.w,
                                alignment: Alignment.center,
                                color:AppColor.mainColor.withOpacity(0.1),
                                child: Container(
                                  margin: EdgeInsets.only(left: 50.w,right: 50.w),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                       MyText(text: "FoodFrenzy", color: AppColor.mainColor, size: 80.sp, bold: true),
                                       Icon(
                                          Icons.star,
                                          size: 100.sp,
                                          color: Colors.amber,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 300.h,
                                width: double.maxFinite.w,
                                margin: EdgeInsets.only(top: 50.h),
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/images/Food-Background.jpg"),
                                  ),
                                ),
                              ),
                              SizedBox(height: 50.h),
                              //Foods Section
                              Container(
                                height: 900.h,
                                width: double.maxFinite.w,
                                color: Colors.transparent,
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: fireStore.snapshots(),
                                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if(snapshot.hasData){
                                      List<dynamic> foodList = snapshot.data!.docs.map((doc) => doc.data()).toList();
                                      return ListView.builder(
                                        itemCount: foodList.length,
                                        itemBuilder: (context, index) {
                                          Map<String,dynamic> foodData = foodList[index] as Map<String,dynamic>;
                                          // Custom Food Card
                                          return Container(
                                            height: 300.h,
                                            width: double.maxFinite.w,
                                            margin: EdgeInsets.only(bottom: 50.h),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(Radius.circular(50.sp)),
                                            ),
                                            child: Container(
                                              margin: EdgeInsets.only(left: 30.w,right: 30.w,top: 10.h),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      MyText(text: foodData['name'], color: Colors.black, size: 60.sp, bold: true),
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
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
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
