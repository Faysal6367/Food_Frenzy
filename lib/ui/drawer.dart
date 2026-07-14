import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_frenzy/constant/app_color.dart';
import 'package:food_frenzy/pages/address.dart';
import 'package:food_frenzy/pages/login.dart';
import 'package:food_frenzy/pages/order_and_reorder.dart';
import 'package:food_frenzy/pages/profile.dart';
import 'package:food_frenzy/widget/custom_text.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {

  final String email;
  const MyDrawer({super.key, required this.email});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

final TextEditingController _userName = TextEditingController();
String userName = "";
String finalName = "";

  @override
  void initState() {
    getUserName().whenComplete(() => finalName = userName);
    super.initState();
  }
  Future getUserName() async{
    SharedPreferences setUserName = await SharedPreferences.getInstance();
    userName = setUserName.getString('userName')!;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: ListView(
        children: [  
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: AppColor.mainColor,
            ),
            currentAccountPicture: const CircleAvatar(backgroundImage: AssetImage("assets/images/logo.webp") ),
            accountName:  MyText(text: finalName, color: Colors.white, size: 50.sp, bold: true),
            accountEmail: MyText(text: widget.email, color: Colors.white, size: 50.sp, bold: false),
          ),
          InkWell(
            onTap: (){
              _showMyDialog();
            },
            child: ListTile(
              leading: Icon(Icons.face,size: 80.sp,color: AppColor.mainColor),
              title: MyText(text: "Set user name", color: Colors.black, size: 50.sp, bold: false),
            ),
          ),
          InkWell(
            onTap: (){
              
            },
            child: ListTile(
              leading: Icon(Icons.favorite_outline,size: 80.sp,color: AppColor.mainColor),
              title: MyText(text: "Favourites (Will available soon)", color: Colors.black, size: 50.sp, bold: false),
            ),
          ),
          InkWell(
            onTap: (){
              
            },
            child: InkWell(
              onTap: (){
                Get.to(const OrderAndReorder());
              },
              child: ListTile(
                leading: Icon(Icons.restaurant_menu,size: 80.sp,color: AppColor.mainColor),
                title: MyText(text: "Orders & reordering", color: Colors.black, size: 50.sp, bold: false),
              ),
            ),
          ),
          InkWell(
            onTap: (){
              Get.to(const Profile());
            },
            child: ListTile(
              leading: Icon(Icons.person,size: 80.sp,color: AppColor.mainColor),
              title: MyText(text: "Profile", color: Colors.black, size: 50.sp, bold: false),
            ),
          ),
          InkWell(
            onTap: (){
              Get.to(const Address());
            },
            child: ListTile(
              leading: Icon(CupertinoIcons.location_solid,size: 80.sp,color: AppColor.mainColor),
              title: MyText(text: "Address", color: Colors.black, size: 50.sp, bold: false),
            ),
          ),
          InkWell(
            onTap: () async{
              SharedPreferences  sharedPreferences = await SharedPreferences.getInstance();
              sharedPreferences.remove('email');
              sharedPreferences.remove('userName');
              sharedPreferences.remove('lat');
              sharedPreferences.remove('lng');
              sharedPreferences.remove('loc');
              Get.to(const Login());
            },
            child: ListTile(
              leading: Icon(Icons.logout_rounded,size: 80.sp,color: AppColor.mainColor),
              title: MyText(text: "Log out", color: Colors.black, size: 50.sp, bold: false),
            ),
          ),
        ],
      ),
    );
  }
  _showMyDialog(){
    return showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          icon: const Icon(Icons.person),
          title: MyText(text: "User Name", color: AppColor.mainColor, size: 60.sp, bold: true),
          content: TextFormField(
            controller: _userName,
            style: TextStyle(
              height: 2.h,
            ),
            decoration: const InputDecoration(
              border: OutlineInputBorder(
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async{
                Navigator.pop(context);
            }, 
            child: const Text("Cancel")
            ),
            TextButton(
              onPressed: () async{
                SharedPreferences setUserName = await SharedPreferences.getInstance();
                setUserName.setString('userName', _userName.text);
                finalName= _userName.text;
                setState(() {});
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
            }, 
            child: const Text("Set")
            ),
          ],
        );
      },
    );
  }
}