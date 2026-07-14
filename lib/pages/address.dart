import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_frenzy/constant/app_color.dart';
import 'package:food_frenzy/pages/homepage.dart';
import 'package:food_frenzy/pages/splash_screen.dart';
import 'package:food_frenzy/ui/text_field.dart';
import 'package:food_frenzy/widget/custom_text.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Address extends StatefulWidget {
  const Address({super.key});

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  
  TextEditingController controller = TextEditingController();
  String location = "";
  Future<void> getUserLocation() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    location = sharedPreferences.getString('loc')!;
    setState(() {
      
    });
  }

  @override
  void initState() {
    super.initState();
    getUserLocation();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.maxFinite.h,
          width: double.maxFinite.w,
          color: Colors.white,
          child : Column(
            children: [
              Container(
                height: 200.h,
                width: double.maxFinite.w,
                color: Colors.white,
                child: Row(
                  children: [
                    SizedBox(width: 50.w),
                    GestureDetector(
                      onTap: (){
                        Get.to(HomePage(email: email));
                      },
                      child: Icon(
                        Icons.clear,
                        size: 60.sp,
                        color: AppColor.mainColor,
                      ),
                    ),
                    SizedBox(width: 100.w),
                    MyText(text: "Location", color: Colors.black, size: 60.sp, bold: true),
                  ],
                ),
              ),
              Divider(
                thickness: 3.sp,
                color: Colors.grey,
              ),
              SizedBox(height: 50.h),
              Container(
                height: 1856.h,
                width: double.maxFinite.w,
                color: Colors.white,
                margin: EdgeInsets.only(left: 30.w,right: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 300.h,
                      width: double.maxFinite.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20.sp)),
                        boxShadow:[
                          BoxShadow(
                            color: Colors.grey,
                            offset:const Offset (0,3),
                            spreadRadius: 10.sp,
                            blurRadius: 20.sp,
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 50.w),
                          Icon(
                            Icons.location_on,
                            color: AppColor.mainColor,
                            size: 100.sp,
                          ),
                          SizedBox(width: 50.w),
                          Container(
                            height: 100.h,
                            width: 500.w,
                            color: Colors.transparent,
                            child: Text(
                              (location=="")?"No location added" : location,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 55.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(width: 50.w),
                          GestureDetector(
                            onTap: (){
                              showMyDialog();
                            },
                            child: Icon(
                              Icons.edit,
                              color: AppColor.mainColor,
                              size: 80.sp,
                            ),
                          ),
                          SizedBox(width: 30.w),
                          GestureDetector(
                            onTap: () async{
                              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                              sharedPreferences.remove('lat');
                              sharedPreferences.remove('lng');
                              sharedPreferences.remove('loc');
                              location = "";
                              setState(() {
                                
                              });
                            },
                            child: Icon(
                              Icons.delete,
                              color: AppColor.mainColor,
                              size: 100.sp,
                            ),
                          ),
                          SizedBox(width: 50.w),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showMyDialog(){
    return showDialog(
      context: context,
       builder: (context) {
         return AlertDialog(
          title: MyText(text: "Add new Location", color: Colors.black, size: 60.sp, bold: true),
          content: MyTextField(width: 100.w, text: "Type location Manually", icon: Icons.location_on, controller: controller, check: false),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.pop(context);
              }, 
              child: MyText(text: "Cancel", color: AppColor.mainColor, size: 50.sp, bold: false),
            ),
            TextButton(
              onPressed: (){
                Navigator.pop(context);
                Get.to(HomePage(email: email));
              }, 
              child: MyText(text: "Google map", color: AppColor.mainColor, size: 50.sp, bold: false),
            ),
            TextButton(
              onPressed: () async{
                Navigator.pop(context);
                SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('loc', controller.text.toString());
                sharedPreferences.remove('lat');
                sharedPreferences.remove('lng');
                location = controller.text.toString();
                setState(() {
                  
                });
              }, 
              child: MyText(text: "Add", color: AppColor.mainColor, size: 50.sp, bold: false),
            ),
          ],
         );
       },
    );
  }
}