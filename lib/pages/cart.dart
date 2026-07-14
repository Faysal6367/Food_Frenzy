import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_frenzy/constant/app_color.dart';
import 'package:food_frenzy/pages/foods.dart';
import 'package:food_frenzy/pages/restaurant.dart';
import 'package:food_frenzy/services/cart_controller.dart';
import 'package:food_frenzy/services/cart_data.dart';
import 'package:food_frenzy/services/food_order.dart';
import 'package:food_frenzy/widget/custom_text.dart';
import 'package:get/get.dart';

bool order = false;
class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

  final List<CartData> cartData = CartController.cartData;
  List<String> foodList = [];
  int totalPrice = 0;

  void calculatePrice(){
    for(int i=0;i<cartData.length;i++){
      totalPrice+=10;
      String p = cartData[i].price.toString();
      totalPrice+= int.parse(p);
      setState(() {
        
      });
    }
  }

  void orderFood(){
    for(int i=0;i<cartData.length;i++){
      FoodOrder.orderFood(cartData[i].name.toString(),cartData[i].restaurant.toString(),cartData[i].price.toString(),cartData[i].url.toString());    
    }
    foodList.add(totalPrice.toString());
    cartData.clear();
  }

  @override
  void initState() {
    calculatePrice();
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
                height: 200.h,
                width: double.maxFinite.w,
                color: Colors.transparent,
                margin: EdgeInsets.only(left: 70.w),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap : (){
                        Get.back();
                      },
                      child: Icon(
                        Icons.clear,
                        size: 80.sp,
                        color: AppColor.mainColor,
                      ),
                    ),
                    SizedBox(width: 100.w),
                    MyText(text: "Cart", color: AppColor.mainColor, size: 60.sp, bold: true),
                  ],
                ),
              ),
              (cartData.isEmpty) ? Container(
                height: 1000.h,
                width: double.maxFinite.w,
                color: Colors.transparent,
                margin: EdgeInsets.only(top: 400.h,left: 50.w,right: 50.w),
                child: Column(
                  children: [
                    Container(
                      height: 500.h,
                      width: 500.w,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/cart.jpg'),
                        ),
                      ),
                    ),
                    SizedBox(height: 100.h),
                    MyText(text: "Hungry?", color: Colors.black, size: 60.sp, bold: true),
                    SizedBox(height: 30.h),
                    MyText(text: "You haven't added anything into your cart!", color: Colors.black, size: 50.sp, bold: false),
                    SizedBox(height: 40.h),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.mainColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.sp)),
                      ),
                      onPressed: (){
                        Get.to(const Food());
                      }, 
                      child: MyText(text: "Browse", color: Colors.white, size: 40.sp, bold: true),
                    ),
                  ],
                ),
              ) : Container(
                height: 1951.h,
                width: double.maxFinite.w,
                color: Colors.transparent,
                child: Column(
                  children: [
                    // Upper design
                    Container(
                      height: 200.h,
                      width: double.maxFinite.w,
                      color: Colors.transparent,
                      child: Stack(
                        children: [
                          Positioned(
                            top: ScreenUtil().setHeight(70),
                            bottom: ScreenUtil().setHeight(110),
                            left: ScreenUtil().setWidth(0),
                            right: ScreenUtil().setWidth(500),     
                            child: AnimatedContainer(
                              duration: const Duration(seconds: 1),  
                              color: AppColor.mainColor,
                            )
                          ),
                          Positioned(
                            top: ScreenUtil().setHeight(40),
                            bottom: ScreenUtil().setHeight(80),
                            left: ScreenUtil().setWidth(0),
                            right: ScreenUtil().setWidth(600),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColor.mainColor,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: MyText(text: "1", color: Colors.white, size: 40.sp, bold: false),
                              ),
                            ),
                          ),
                          Positioned(
                            top: ScreenUtil().setHeight(40),
                            bottom: ScreenUtil().setHeight(80),
                            left: ScreenUtil().setWidth(30),
                            right: ScreenUtil().setWidth(0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColor.mainColor,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: MyText(text: "2", color: Colors.white, size: 40.sp, bold: false),
                              ),
                            ),
                          ),
                          Positioned(
                            top: ScreenUtil().setHeight(70),
                            bottom: ScreenUtil().setHeight(110),
                            left: ScreenUtil().setWidth(594),
                            right: ScreenUtil().setWidth(0),     
                            child: AnimatedContainer(
                              duration: const Duration(seconds: 1),  
                              color: Colors.grey.withOpacity(0.4),
                            )
                          ),
                          Positioned(
                            top: ScreenUtil().setHeight(40),
                            bottom: ScreenUtil().setHeight(80),
                            left: ScreenUtil().setWidth(620),
                            right: ScreenUtil().setWidth(0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 5.w,
                                ),
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: MyText(text: "3", color: Colors.black, size: 40.sp, bold: false),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(width: 170.w),
                        MyText(text: "Menu", color: AppColor.mainColor, size: 50.sp, bold: false),
                        SizedBox(width: 210.w),
                        MyText(text: "Cart", color: AppColor.mainColor, size: 50.sp, bold: false),
                        SizedBox(width: 150.w),
                        MyText(text: "OrderFood", color: AppColor.mainColor, size: 50.sp, bold: false),
                      ],
                    ),
                    //Main design of cart
                    SingleChildScrollView(
                      child: Container(
                        height: 1641.h,
                        width: double.maxFinite.w,
                        color: Colors.transparent,
                        margin: EdgeInsets.only(top: 50.h,left: 30.w,right: 30.w),
                        child: Column(
                          children: [
                            Container(
                              height: 300.h,
                              width: double.maxFinite.w,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 10,
                                    color: Colors.grey,
                                    offset: Offset(0, 2),
                                  ),
                                ]
                              ),
                              child: Row(
                                children: [
                                  const Image(
                                    image: AssetImage('assets/images/delivary.gif')
                                  ),
                                  SizedBox(width: 100.w),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      MyText(text: "Estimated delivery", color: Colors.black, size: 40.sp, bold: false),
                                      SizedBox(height: 20.h),
                                      MyText(text: "ASAP (30 min)", color: Colors.black, size: 50.sp, bold: true),
                                    ],
                                  ), 
                                ],
                              ),
                            ),
                            SizedBox(height: 50.h),
                            Container(
                              height: 890.h,
                              width: double.maxFinite.w,
                              color: Colors.transparent,
                              child: ListView.builder(
                                itemCount: cartData.length,
                                itemBuilder: (context, index) {
                                  final CartData data = cartData[index];
                                  return Container(
                                    height: 220.h,
                                    width: double.maxFinite.w,
                                    margin: EdgeInsets.only(bottom: 30.w),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 10,
                                          color: Colors.grey,
                                          offset: Offset(0, 2),
                                        ),
                                      ]
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(width: 50.w),
                                        Container(
                                          height: 200.h,
                                          width: 230.w,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(data.url),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 50.w),
                                        Container(
                                          height: 220.h,
                                          width: 450.w,
                                          color: Colors.transparent,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              MyText(text: data.name, color: Colors.black, size: 50.sp, bold: true),
                                              SizedBox(height: 20.h),
                                              Text(data.restaurant,
                                               style: TextStyle(
                                                fontSize: 40.sp,
                                                color: Colors.black,
                                                overflow: TextOverflow.ellipsis,
                                               ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 60.w),
                                        MyText(text: 'TK ${data.price}', color: Colors.black, size: 45.sp, bold: false),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: (){
                                    Get.to(const Restaurant());
                                  },
                                   child: MyText(text: 'Add more item', color: AppColor.mainColor, size: 50.sp, bold: true),
                                ),
                                MyText(text: 'Total $totalPrice TK', color: Colors.black, size: 50.sp, bold: false),
                              ],
                            ),
                            Container(
                              height: 244.h,
                              width: double.maxFinite.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50.sp),
                                  topRight: Radius.circular(50.sp),
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 10,
                                    offset: Offset(0,2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: (!order) ? ElevatedButton(
                                  onPressed: (){
                                    orderFood();
                                  }, 
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.mainColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.sp),
                                    )
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(30.sp),
                                    child: Text('Place Order Here',
                                      style: TextStyle(
                                        fontSize: 40.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ) : MyText(text: "You can,t order now", color: AppColor.mainColor, size: 60.sp, bold: true),
                              ),
                            )
                          ],
                        ),
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