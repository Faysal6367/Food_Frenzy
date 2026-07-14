import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_frenzy/pages/cart.dart';
import 'package:food_frenzy/pages/pick_up.dart';
import 'package:food_frenzy/pages/splash_screen.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoodOrder{

  static late DateTime currentTime;

  static Future<void> orderFood(String name,String restaurant,String price,String url) async{
     
    currentTime = DateTime.now().toLocal();
    int milliseconds = currentTime.microsecondsSinceEpoch;

    String formattedDate = DateFormat('d MMMM yyyy').format(currentTime);
    String formattedTime = DateFormat('h:mm a').format(currentTime);
    String currentDateTime = "$formattedDate , $formattedTime";
    
    final ref = FirebaseFirestore.instance.collection(email.toString());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userName = sharedPreferences.getString('userName');
    var location = sharedPreferences.getString('loc');
    ref.doc(milliseconds.toString()).set({
      'name' : name, 
      'user Name' : userName.toString(),
      'user location' : location.toString(),
      'restaurant' : restaurant, 
      'price' : price,
      'image-url' : url,
      'date-time' : currentDateTime,
    }).then((value){
      Get.to(const PickUp());
      order = true;
    }).then((error){
      // ignore: avoid_print
      print(error);
    });
  }
}