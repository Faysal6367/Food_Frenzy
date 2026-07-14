import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_frenzy/constant/app_color.dart';
import 'package:food_frenzy/pages/cart.dart';
import 'package:food_frenzy/services/food_catagory_design.dart';
import 'package:food_frenzy/ui/search_design.dart';
import 'package:food_frenzy/widget/custom_text.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FoodCatagory extends StatefulWidget {
  const FoodCatagory({super.key});

  @override
  State<FoodCatagory> createState() => _FoodCatagoryState();
}

class _FoodCatagoryState extends State<FoodCatagory> with TickerProviderStateMixin{

  List<String> imageUrls = [];
  Future<void> loadImageUrls() async{
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
    super.initState();
    loadImageUrls();
  }

  @override
  Widget build(BuildContext context) {
    TabController controller = TabController(length: 5,vsync: this);
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.maxFinite.h,
          width: double.maxFinite.w,
          color: Colors.white,
          child: Column(
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
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MyText(text: "Food Catagory", color: AppColor.mainColor, size: 60.sp, bold: true),
                          SizedBox(height: 30.h),
                          SearchDesign(height: 300.h,width: 2000.w),
                        ],
                      ),
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
              TabBar(
                controller: controller,
                unselectedLabelColor: Colors.black,
                labelColor: AppColor.mainColor,
                indicatorColor: AppColor.mainColor,
                indicatorSize: TabBarIndicatorSize.label,
                isScrollable: true,
                tabs: [
                  Text("Biriyani",
                    style: TextStyle(
                      fontSize: 50.sp,
                    ),
                  ),
                  Text("Pizza",
                    style: TextStyle(
                      fontSize: 50.sp,
                    ),
                  ),
                  Text("Burger",
                    style: TextStyle(
                      fontSize: 50.sp,
                    ),
                  ),
                  Text("Pasta",
                    style: TextStyle(
                      fontSize: 50.sp,
                    ),
                  ),
                  Text("Dessert",
                    style: TextStyle(
                      fontSize: 50.sp,
                    ),
                  ),
               ],
              ),
              SizedBox(height: 50.h),
              Container(
                height: 1186.h,
                width: double.maxFinite.w,
                color: Colors.transparent,
                // margin: EdgeInsets.only(left: 50.w,right: 50.w),
                child: TabBarView(
                  controller: controller,
                  children: const[
                    FoodCatagoryDesign(collection: "Food-Catagory-Biriyani"),
                    FoodCatagoryDesign(collection: "Food-Catagory-Pizza"),
                    FoodCatagoryDesign(collection: "Food-Catagory-Burger"),
                    FoodCatagoryDesign(collection: "Food-Catagory-Pasta"),
                    FoodCatagoryDesign(collection: "Food-Catagory-Dessert"),
                  ]
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}