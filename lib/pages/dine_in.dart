import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_frenzy/constant/app_color.dart';
import 'package:food_frenzy/pages/cart.dart';
import 'package:food_frenzy/services/cart_controller.dart';
import 'package:food_frenzy/services/cart_data.dart';
import 'package:food_frenzy/widget/custom_text.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class DineIn extends StatefulWidget {
  const DineIn({super.key});

  @override
  State<DineIn> createState() => _DineInState();
}

class _DineInState extends State<DineIn> {

  final ref = FirebaseDatabase.instance.ref('Offer');
  final fireStore = FirebaseFirestore.instance.collection("Dine In");
  
  List<String> imageUrls = [];
  Future<void> loadImageurl() async{
    try{
      firebase_storage.ListResult result = await firebase_storage.FirebaseStorage.instance.ref('Slider2').listAll();
      List<firebase_storage.Reference> allFiles = result.items;
      for(var file in allFiles){
        String downloadUrl = await file.getDownloadURL();
        setState(() {
          imageUrls.add(downloadUrl);
        });
      }
    }
    catch(e){
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  void initState() {
    loadImageurl();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.maxFinite.h,
          width: double.maxFinite.w,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 300.h,
                width: double.maxFinite.w,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 3),
                      spreadRadius: 5,
                      blurRadius: 10,
                    )
                  ]
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 50.w,right: 50.w),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Get.back();
                          },
                          child: Icon(
                            Icons.arrow_back,
                            size: 80.sp,
                            color: AppColor.mainColor,
                          ),
                        ),
                        MyText(text: "Dine In", color: AppColor.mainColor, size: 60.sp, bold: true),
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
              ),
              SizedBox(height: 50.h),
              Container(
                height: 450.h,
                width: double.maxFinite.w,
                color: Colors.transparent,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: imageUrls.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(left: 30.w,right: 30.w),
                      height: 450.h,
                      width: 370.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30.sp)),
                        image: DecorationImage(
                          image: NetworkImage(imageUrls[index]),
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                ),
              ), 
              SizedBox(height: 50.h),
              Container(
                height: 500.h,
                width: double.maxFinite.w,
                color: Colors.transparent,
                margin: EdgeInsets.only(left: 50.w,right: 50.w),
                child: StreamBuilder(
                  stream: ref.onValue,
                  builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                    if(snapshot.hasData){
                      Map<dynamic,dynamic> offerData = snapshot.data!.snapshot.value as dynamic; 
                      List<dynamic> offerList = [];
                      offerList.clear();
                      offerList = offerData.values.toList();
                      return ListView.builder(
                        itemCount: offerData.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 500.h,
                            width: 980.w,
                            margin: EdgeInsets.only(right: 50.w),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(offerList[index]['image-url']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      );
                    }
                    else{
                      return const Center(child:CircularProgressIndicator());
                    }
                  },
                ),
              ),
              SizedBox(height: 50.h),
              Container(
                height: 751.h,
                width: double.maxFinite.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.sp),
                    topRight: Radius.circular(50.sp),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.sp, 3.sp),
                      spreadRadius: 10.sp,
                      blurRadius: 20.sp,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 100.h),
                    Container(
                      margin: EdgeInsets.only(left: 30.w),
                      child: MyText(text: "Dine In Foods", color: Colors.black, size: 70.sp, bold: true)
                    ),
                    SizedBox(height: 50.h),
                    Container(
                      height: 515.h,
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
                                margin: EdgeInsets.only(bottom: 30.h,left: 30.w,right: 30.w,top: 30.h),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(50.sp)),
                                  boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0.sp, 3.sp),
                                      spreadRadius: 2.sp,
                                      blurRadius: 30.sp,
                                    ),
                                  ]
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
                                          image: NetworkImage(foodData['image-url']),
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
                                                  cartController.addData(CartData(foodData['name'], foodData['price'], foodData['image-url'], foodData['restaurant']));
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
            ],
          ),
        ),
      ),
    );
  }
}