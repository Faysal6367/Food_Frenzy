import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_frenzy/api/restaurant_google_map.dart';
import 'package:food_frenzy/constant/app_color.dart';
import 'package:food_frenzy/pages/cart.dart';
import 'package:food_frenzy/pages/homepage.dart';
import 'package:food_frenzy/pages/search.dart';
import 'package:food_frenzy/ui/all_restaurant_design.dart';
import 'package:food_frenzy/ui/restaurant_design.dart';
import 'package:food_frenzy/widget/custom_text.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Restaurant extends StatefulWidget {
  const Restaurant({super.key});

  @override
  State<Restaurant> createState() => _RestaurantState();
}

class _RestaurantState extends State<Restaurant> {

  final String folder = "/restaurant-slider";
  List<String> imageUrl = [];
  Future<void> loadImage()async{
    try{
      firebase_storage.ListResult result = await firebase_storage.FirebaseStorage.instance.ref(folder).listAll();
      List<firebase_storage.Reference> allFiles = result.items;
      for(var files in allFiles){
        String downloadUrl = await files.getDownloadURL();
        setState(() {
        imageUrl.add(downloadUrl);
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
    loadImage();
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
            children: [
              Container(
                height: 350.h,
                width: double.maxFinite.w,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 60.w,right: 80.w,bottom: 40.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: ()async{
                              SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
                              var email = sharedPreferences.getString('email');
                              Get.to(HomePage(email: email.toString()));
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: AppColor.mainColor,
                              size: 80.sp,
                            ),
                          ),
                          MyText(text: "Restaurants", color: AppColor.mainColor, size: 60.sp, bold: true),
                          Row(
                            children: [
                              Icon(
                                Icons.favorite_border_outlined,
                                color: AppColor.mainColor,
                                size: 80.sp,
                              ),
                              SizedBox(width: 80.w),
                              GestureDetector(
                                onTap:(){
                                  Get.to(const Cart());
                                },
                                child: Icon(
                                  CupertinoIcons.cart,
                                  color: AppColor.mainColor,
                                  size: 80.sp,
                                  ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Get.to(const Search());
                      },
                      child: Container(
                        height: 120.h,
                        width: 970.w,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.all(Radius.circular(100.sp)),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 50.w),
                            Icon(
                              Icons.search,
                              size: 70.sp,
                            ),
                            SizedBox(width: 40.w,),
                            MyText(text: "Search for restaurants and food", color: Colors.black, size: 50.sp, bold: false),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //Body
               Container(
                  height: 1801.h,
                  width: double.maxFinite.w,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 450.h,
                          width: double.maxFinite.w,
                          margin: EdgeInsets.only(top:50.h),
                          color: Colors.transparent,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: imageUrl.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 450.h,
                                width: 400.w,
                                margin: EdgeInsets.only(left: 30.w,right: 30.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(30.sp)),
                                  image: DecorationImage(         
                                    image: NetworkImage(imageUrl[index]),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 40.h),
                        Container(
                          height: 500.h,
                          width: double.maxFinite.w,
                          margin: EdgeInsets.all(40.sp),
                          child: const RestaurantGoogleMap(),
                        ),
                        Container(
                          margin: EdgeInsets.all(30.sp),
                          child: MyText(text: "Recommended for you", color: Colors.black, size: 60.sp, bold: true)
                        ),
                        const RestaurantDesign(collectionName: "Recommended-Restaurant"),
                        Container(
                          margin: EdgeInsets.all(30.sp),
                          child: MyText(text: "Gorom Gorom Biriyani", color: Colors.black, size: 60.sp, bold: true)
                        ),
                        const RestaurantDesign(collectionName: "Gorom-Gorom-Biriyani"),
                        Container(
                          margin: EdgeInsets.all(30.sp),
                          child: MyText(text: "Ghorer Khabar", color: Colors.black, size: 60.sp, bold: true)
                        ),
                        const RestaurantDesign(collectionName: "Ghorer-Khabar"),
                        Container(
                          margin: EdgeInsets.all(30.sp),
                          child: MyText(text: "Fast Food", color: Colors.black, size: 60.sp, bold: true)
                        ),
                        const RestaurantDesign(collectionName: "Fast-Food"),
                        Container(
                          margin: EdgeInsets.all(30.sp),
                          child: MyText(text: "All Restaurant", color: Colors.black, size: 60.sp, bold: true)
                        ),
                        const AllRestaurantDesign(collectionName: "All-Restaurant"),
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