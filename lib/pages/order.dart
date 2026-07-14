import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_frenzy/widget/custom_text.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.maxFinite.h,
        width: double.maxFinite.w,
        color: Colors.white,
        child: Center(
          child: MyText(text: "You Placed your order", color: Colors.black, size: 50.sp, bold: false),
        ),
      ),
    );
  }
}