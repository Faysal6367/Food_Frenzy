import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_frenzy/ui/restaurant_foods.dart';
import 'package:food_frenzy/widget/custom_text.dart';
import 'package:get/get.dart';

class RestaurantDesign extends StatefulWidget {
  final String collectionName;
  const RestaurantDesign({super.key, required this.collectionName});

  @override
  State<RestaurantDesign> createState() => _RestaurantDesignState();
}

class _RestaurantDesignState extends State<RestaurantDesign> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 650.h,
      width: double.maxFinite.w,
      color: Colors.white,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection(widget.collectionName).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.hasData){
          List<dynamic> restaurantList = snapshot.data!.docs.map((doc) => doc.data()).toList();
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: restaurantList.length,
            itemBuilder: (context, index) {
              Map<String,dynamic> restaurantData = restaurantList[index] as Map<String,dynamic>;
              return GestureDetector(
                onTap:(){
                   Get.to(RestaurantFood(restaurantName: restaurantData['name']));
                },
                child: Container(
                  height: 500.h,
                  width: 700.w,
                  color: Colors.transparent,
                  margin: EdgeInsets.only(left: 30.w,right: 30.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 400.h,
                        width: 700.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50.sp)),
                          image: DecorationImage(
                            image: NetworkImage(restaurantData['image-url']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),
                      MyText(text: restaurantData['name'], color: Colors.black, size: 50.sp, bold: true),
                      SizedBox(height: 10.h),
                      MyText(text: restaurantData['type'], color: Colors.black, size: 40.sp, bold: false),
                      SizedBox(height: 10.h),
                      MyText(text: restaurantData['location'], color: Colors.black, size: 40.sp, bold: false),
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