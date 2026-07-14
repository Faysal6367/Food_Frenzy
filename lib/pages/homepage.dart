import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_frenzy/constant/app_color.dart';
import 'package:food_frenzy/pages/cart.dart';
import 'package:food_frenzy/pages/dine_in.dart';
import 'package:food_frenzy/pages/food_catagory.dart';
import 'package:food_frenzy/pages/foods.dart';
import 'package:food_frenzy/pages/pick_up.dart';
import 'package:food_frenzy/pages/restaurant.dart';
import 'package:food_frenzy/pages/search.dart';
import 'package:food_frenzy/ui/bottom_sheet.dart';
import 'package:food_frenzy/ui/drawer.dart';
import 'package:food_frenzy/ui/home_page_container.dart';
import 'package:food_frenzy/ui/home_page_container2.dart';
import 'package:food_frenzy/widget/custom_text.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomePage extends StatefulWidget {
  final String email;
  const HomePage({super.key, required this.email});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

final String storageFolder = 'Slider';

 List<String> imageUrls = [];

  Future<void> loadImageUrls() async {
   try{
     firebase_storage.ListResult result = await firebase_storage.FirebaseStorage.instance.ref(storageFolder).listAll();
     List<firebase_storage.Reference> allFiles = result.items;
     for(var file in allFiles){
      String url = await file.getDownloadURL();
      setState(() {
        imageUrls.add(url);
      });
     }
   }
   catch(e){
    //Error
   }
  }
int currentIndex = 0;
bool check = false;
Timer?timer;

void startTimer(){
  timer = Timer.periodic(const Duration(seconds: 1), (time) { 
    getLocationName();
    setState(() { });
  });
}



String location ="";
Future<void> getLocationName()async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  location = sharedPreferences.getString('loc')!;
  setState(() {
    
  });
}



  @override
  void initState() {
    super.initState();
    loadImageUrls();
    getLocationName();
    startTimer();
  }

  final firestore = FirebaseFirestore.instance.collection("Sponsor");

  @override
  Widget build(BuildContext context) {
    return SafeArea( 
      child: Scaffold(
        key: _globalKey,
        drawer: MyDrawer(email: widget.email),
        body: Container(
          height: double.maxFinite.h,
          width: double.maxFinite.w,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 380.h,
                width: double.maxFinite.w,
                color: AppColor.mainColor,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(50.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (){
                              _globalKey.currentState!.openDrawer();
                            },
                            child: Icon(
                              Icons.menu,
                              size: 80.sp,
                              color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                               MyBottomSheet.showMyBottomSheet(context);
                            },
                            child: Container(
                              height: 100.h,
                              width: 550.w,
                              alignment: Alignment.center,
                              color: Colors.transparent,
                                child: Text((location=="")?"Location" : location,
                                  style: TextStyle(
                                    fontSize: 50.sp,
                                    color: Colors.white,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              )),
                          Row(
                            children: [
                              Icon(
                                Icons.favorite_border,
                                size: 80.sp,
                                color: Colors.white,
                              ),
                              SizedBox(width: 50.w,),
                              GestureDetector(
                                onTap : (){
                                  Get.to(const Cart());
                                },
                                child: Icon(
                                  CupertinoIcons.cart,
                                  size: 80.sp,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 50.w,),
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
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(100.sp)),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 50.h),
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

              //Main part of Home Page
              Container(
                height: 1771.h,
                width: double.maxFinite.w,
                color: Colors.transparent,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(50.sp),
                        height: 1050.h,
                        width: double.maxFinite.w,
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Get.to(const FoodCatagory());
                                  },
                                  child: MyContainer(height: 700.h, width: (MediaQuery.of(context).size.width/2)-50.w, heading: "Food Catagory", text: "Best deals on your favourites!", url: "assets/images/biriyanii.jpg", imgHeight: 400.h,imgWidth: 400.w,sizedHeight1: 20.h,sizedHeight2: 70.w,left: 50.w)),
                              SizedBox(width: 50.sp),
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      Get.to(const Restaurant());
                                    },
                                    child: MyContainer(height: 420.h, width: (MediaQuery.of(context).size.width/2)-100.w, heading: "Restaurants", text: "Find our restaurants", url: "assets/images/halim.jpg",imgHeight: 260.h,imgWidth: 260.w,sizedHeight1: 0.h,sizedHeight2: 0.h,left: 100.w)),
                                  SizedBox(height: 30.h,),
                                  GestureDetector(
                                    onTap: (){
                                      Get.to(const Food());
                                    },
                                    child: MyContainer2(height: 250.h, width: (MediaQuery.of(context).size.width/2)-100.w, heading: "Foods", text: "Best food",text2: "here", url: "assets/images/food.jpg",imgHeight: 200.h,imgWidth: 200.w,sizedHeight1: 10.h,left: 0.w)),
                                ],
                              )
                              ],  
                            ),
                            SizedBox(height: 30.h,),
                            Row(
                              children: [
                              GestureDetector(
                                onTap: (){
                                  Get.to(const PickUp());
                                },
                                child: MyContainer2(height: 300.h, width: (MediaQuery.of(context).size.width/2)-50.w, heading: "Pick up", text: "Takeway in",text2: "15 min", url: "assets/images/pick.jpg",imgHeight: 200.h,imgWidth: 200.w,sizedHeight1: 10.h,left: 0.w)),
                              SizedBox(width: 50.w,),
                              GestureDetector(
                                onTap: (){
                                  Get.to(const DineIn());
                                },
                                child: MyContainer2(height: 300.h, width: (MediaQuery.of(context).size.width/2)-100.w, heading: "Dine In", text: "Eat Out and",text2: "save 25%", url: "assets/images/dine.png",imgHeight: 190.h,imgWidth: 190.w,sizedHeight1: 10.h,left: 0.w)),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 1850.h,
                        width: double.maxFinite.w,
                        color: Colors.white,
                        child: Column(
                          children: [
                            // Popular Restaurant
                            Container(
                              //margin: EdgeInsets.only(top: 30.h,left: 50.w),
                              height: 1000.h,
                              width: double.maxFinite.w,
                              color: Colors.transparent,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 50.w,top: 20.h),
                                    child: MyText(text: "Popular Restaurant", color: Colors.black, size: 60.sp, bold: true)),
                                  Container(
                                    height: 900.h,
                                    width: double.maxFinite.w,
                                    color: Colors.transparent,
                                    child: StreamBuilder<QuerySnapshot>(
                                      stream: firestore.snapshots(),
                                      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if(snapshot.hasData){
                                          List<dynamic> list = snapshot.data!.docs.map((doc) => doc.data()).toList();
                                          return ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: list.length,
                                            itemBuilder: (context, index) {
                                              Map<String,dynamic> data = list[index] as Map<String,dynamic>;
                                              return Container(
                                                height: 500.h,
                                                width: 700.w,
                                                margin: EdgeInsets.only(top: 50.h,left: 50.w,right: (index == list.length-1) ? 50.w : 0.w),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: 400.h,
                                                      width: double.maxFinite.w,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(Radius.circular(50.sp)),
                                                        image: DecorationImage(
                                                          image: NetworkImage(data['url']),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 30.h),
                                                    MyText(text: data['name'], color: Colors.black, size: 50.sp, bold: true),
                                                    SizedBox(height: 10.h),
                                                    MyText(text: data['dishes'], color: Colors.black, size: 40.sp, bold: false),
                                                    SizedBox(height: 10.h),
                                                    MyText(text: data['location'], color: Colors.black, size: 40.sp, bold: false),
                                                    SizedBox(height: 10.h),
                                                    MyText(text: data['fee'], color: Colors.black.withOpacity(0.8), size: 40.sp, bold: true),
                                                    //SizedBox(height: 10.h),
                                                    Row(
                                                      children: [
                                                        const Icon(Icons.star_border),
                                                        SizedBox(width: 20.w,),
                                                        MyText(text: data['rating'], color: Colors.black, size: 40.sp, bold: false),
                                                      ],
                                                    ),
                                                  ],
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
                            Container(
                              height: 500.h,
                              width: double.maxFinite.w,
                              color: Colors.transparent,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 50.w),
                                    child: MyText(text: "Your daily deals", color: Colors.black, size: 60.sp, bold: true)),
                                    SizedBox(height: 30.h,),
                                  Container(
                                    height: 350.h,
                                    width: double.maxFinite.w,
                                    color: Colors.transparent,
                                    child: (imageUrls.isEmpty) ? const Center(child: CircularProgressIndicator()) 
                                     : PageView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: imageUrls.length,
                                      itemBuilder:  (context, index) {
                                      String url = imageUrls[index];
                                       return Container(
                                        height: 400.h,
                                        width: 1000.w,
                                        margin: EdgeInsets.only(top:20.h,left: 50.w,right: 50.w),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(50.sp)),
                                          image: DecorationImage(
                                            image: NetworkImage(url),
                                            fit: BoxFit.fill,  
                                          ),
                                        ),      
                                       );
                                     },
                                   ),
                                  ), 
                                ],
                              ),
                            ),
                            SizedBox(height: 50.h),
                            AnimatedContainer(
                              duration: const Duration(seconds: 2),
                              height: 230.h,
                              width: double.maxFinite.w,
                              margin: EdgeInsets.only(left: 50.w,right: 50.w),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.all(Radius.circular(50.sp)),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 5.w,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 30.h),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        MyText(text: "Try foodfrenzy reward", color: Colors.black, size: 50.sp, bold: true),
                                        SizedBox(height: 30.h),
                                        MyText(text: "Get coin from order & reedem gift ", color: Colors.black, size: 40.sp, bold: false)
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    CupertinoIcons.gift_fill,
                                    color: AppColor.mainColor,
                                    size: 120.sp,
                                  ),
                                ],
                              ),
                            ),
                          ],
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