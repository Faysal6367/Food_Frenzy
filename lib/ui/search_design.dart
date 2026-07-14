import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_frenzy/pages/search.dart';
import 'package:get/get.dart';

class SearchDesign extends StatelessWidget {
  final double height;
  final double width;

  const SearchDesign({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(const Search()),
      child: Container(
        height: height.h,
        width: width.w,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.4),
          borderRadius: BorderRadius.circular(100.r),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search,
              size: 50.sp, // lowered for safe layout
              color: Colors.black87,
            ),

            SizedBox(width: 20.w),

            /// TEXT WILL NEVER OVERFLOW NOW
            Expanded(
              child: Text(
                "Search foods here",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 40.sp,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
