import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_frenzy/constant/app_color.dart';
import 'package:food_frenzy/pages/homepage.dart';
import 'package:food_frenzy/pages/sign_up.dart';
import 'package:food_frenzy/ui/text_field.dart';
import 'package:food_frenzy/widget/custom_text.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;

  Future loginWithEmail() async{
    try{
      final auth = FirebaseAuth.instance;
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: email.text.toString(),
      password: password.text.toString(),
      );
      User ? users = userCredential.user;
      if(users!=null){
        final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString('email', email.text);
        Get.to(HomePage(email: email.text,));
        isLoading = false;
        setState(() {
          
        });
      }
    } on FirebaseAuthException catch(e){
      
      if(e.code == 'user-not-found'){
        Get.snackbar('Invalid Email', 'Your Email Is Incorrect',
        backgroundColor: AppColor.mainColor,
        colorText: Colors.white,
       );
      }
      else if(e.code == 'wrong-password'){
        Get.snackbar('Wrong Password', 'Your Password Is Wrong',
        backgroundColor: AppColor.mainColor,
        colorText: Colors.white,
       );
      }
    }
    catch(e){
       Get.snackbar('Error', 'FoodFrenzy Server is Down');
    }
  }

  @override
  void initState() {
    isLoading = false;
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: double.maxFinite.h,
          width: double.maxFinite.w,
          color: Colors.white,
          child: Container(
            margin: EdgeInsets.only(left: 60.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100.h),
                Container(
                  margin: EdgeInsets.only(top:ScreenUtil().setHeight(80.0)),
                  child: Image(
                    height: 300.h,
                    width: 300.w,
                    image: const AssetImage("assets/images/login.jpg"),
                  ),
                ),
                SizedBox(height: 50.h),
                MyText(text: "Log in with your email", color: Colors.black, size: 80.sp, bold: true),
                SizedBox(height: 20.h),
                MyText(text: "Order now! Delicious meals delivered fresh to your door", color: Colors.black, size: 40.sp, bold: false),
                SizedBox(height: 100.h),
                MyTextField(width: 970,text: "Email",icon: Icons.email,controller:email,check: false),
                SizedBox(height: 50.h),
                MyTextField(width: 970,text: "Password",icon: Icons.key,controller:password,check: true),
                SizedBox(height: 70.h),
                TextButton(
                  onPressed: (){
                    Get.to(const SignUP());
                  }, 
                  child: MyText(text: "Forgot Password", color: AppColor.mainColor, size: 50.sp, bold: true)
                ),
                TextButton(
                  onPressed: (){
                    Get.to(const SignUP());
                  }, 
                  child: MyText(text: "Don't Have an Account ?", color: AppColor.mainColor, size: 50.sp, bold: true)
                ),
                SizedBox(height: 350.h),
                ElevatedButton(
                  onPressed: (){
                    if(email.text.isNotEmpty  && password.text.isNotEmpty){
                      isLoading = true;
                      setState(() { });
                      loginWithEmail();
                    }
                    else{
                      Get.snackbar('Food Frenzy', 'Please enter email and password',
                      backgroundColor: AppColor.mainColor,
                      colorText: Colors.white,
                      );
                    }
                  },  
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.sp)),
                     )
                    ),
                    backgroundColor: MaterialStateProperty.all(AppColor.mainColor),
                  ),
                  child:  Padding(
                    padding: EdgeInsets.only(top:40.h,bottom: 40.h,left: 350.w,right: 350.w),
                    child: (isLoading ==true)? const CircularProgressIndicator(color: Colors.white)
                    : MyText(text: "Log In", color: Colors.white, size: 50.sp, bold: false),
                  ),
                ),
              ]
            ),
          ),
        ),
      )
    );
  }
}