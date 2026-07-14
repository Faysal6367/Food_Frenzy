import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_frenzy/firebase_options.dart';
import 'package:food_frenzy/pages/splash_screen.dart';
import 'package:food_frenzy/services/cart_controller.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(CartController());
  runApp(const FoodFrenzy());
}

// cxjhvc

class FoodFrenzy extends StatelessWidget {
  const FoodFrenzy({super.key});

  @override
  Widget build(BuildContext context) {
    //ScreenUtilInit for responsive
    return ScreenUtilInit(
      designSize: const Size(1080, 2220),
      builder: (context, child) {
        return GetMaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
          ),
          home: const SplashScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

