import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RestaurantFood extends StatefulWidget {
  final String restaurantName;
  const RestaurantFood({super.key, required this.restaurantName});

  @override
  State<RestaurantFood> createState() => _RestaurantFoodState();
}

class _RestaurantFoodState extends State<RestaurantFood> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔥 TOP BANNER SECTION (Scrollable)
            SizedBox(
              height: 250.h, // responsive safe height
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Sultan Dine - Top Banner')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final bannerList =
                  snapshot.data!.docs.map((doc) => doc.data()).toList();

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: bannerList.length,
                    itemBuilder: (context, index) {
                      final data =
                      bannerList[index] as Map<String, dynamic>;

                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.w),
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: Colors.grey.shade200,
                          image: DecorationImage(
                            image: NetworkImage(data['image-url']),
                            fit: BoxFit.cover, // better look, no stretch
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            SizedBox(height: 20.h),

            /// 🔥 FUTURE SECTIONS LIKE FOOD LIST HERE
            Expanded(
              child: Center(
                child: Text(
                  "Food List Coming Soon...",
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
