import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_frenzy/constant/app_color.dart';
import 'package:food_frenzy/pages/email_varification.dart';
import 'package:food_frenzy/pages/login.dart';
import 'package:food_frenzy/ui/text_field.dart';
import 'package:food_frenzy/widget/custom_text.dart';
import 'package:get/get.dart';

class SignUP extends StatefulWidget {
  const SignUP({super.key});

  @override
  State<SignUP> createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  
  void registerUserAccount() async {
    try {
      final auth = FirebaseAuth.instance;
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email.text.toString(),
        password: password.text.toString(),
      );
      // ignore: use_build_context_synchronously
      Navigator.push(context, MaterialPageRoute(builder: (context) => EmailVarification(user: userCredential.user,email: email.text.toString()),
      ),
     );
    } on FirebaseAuthException catch(e){
      if(e.code == 'weak-password'){
        Get.snackbar('Weak Password', 'Your Password Is Weak',
        backgroundColor: AppColor.mainColor,
        colorText: Colors.white,
       );
      }
      else if(e.code == 'email-already-in-use'){
        Get.snackbar('Reused Email', 'Your Email Is Already Used',
        backgroundColor: AppColor.mainColor,
        colorText: Colors.white,
       );
      }
    }catch (error) {
      Get.snackbar('Error', 'FoodFrenzy Server is Down');
    }
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
                Container(
                  margin: EdgeInsets.only(top:ScreenUtil().setHeight(80.0),left: 10.w,right: 50.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.to(const Login());
                        },
                        child: Icon(Icons.arrow_back,
                        color: AppColor.mainColor,
                        size: 80.sp,
                        ),
                      ),
                      MyText(text: "Continue", color: AppColor.mainColor, size: 60.sp, bold: false)
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top:ScreenUtil().setHeight(80.0)),
                  child: Image(
                    height: 300.h,
                    width: 300.w,
                    image: const AssetImage("assets/images/signup.jpg"),
                  ),
                ),
                SizedBox(height: 50.h),
                MyText(text: "Sign Up with your email", color: Colors.black, size: 80.sp, bold: true),
                SizedBox(height: 20.h),
                MyText(text: "Busy Today? Feeling Lazy? Order your food now", color: Colors.black, size: 45.sp, bold: false),
                SizedBox(height: 100.h),
                MyTextField(width: 970,text: "Email",icon: Icons.email,controller:email,check: false),
                SizedBox(height: 50.h),
                MyTextField(width: 970,text: "Password",icon: Icons.key,controller:password,check: true),
                SizedBox(height: 700.h),
                ElevatedButton(
                  onPressed: (){
                    String validateEmail = email.text.toString();
                    if(validateEmail.contains("@gmail.com")){
                      registerUserAccount();
                      //Get.to(const EmailVarification());
                    }
                    else{
                       Get.snackbar('FoodFrenzy', 'Invalid Email Address',
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
                    child: MyText(text: "Continue", color: Colors.white, size: 50.sp, bold: false)
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