import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_frenzy/constant/app_color.dart';
import 'package:food_frenzy/services/cart_controller.dart';
import 'package:food_frenzy/services/cart_data.dart';
import 'package:food_frenzy/widget/custom_text.dart';
import 'package:get/get.dart';

class Search extends StatefulWidget {
  
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> with TickerProviderStateMixin {

  // ignore: prefer_final_fields
  TextEditingController _search = TextEditingController();
  List<String> list = ['pizza','burger','kacchi','meatBox','chezz','pasta','cake','pizzaburg'];
  int currentIndex = -1;

  final restaurant = FirebaseDatabase.instance.ref('Restaurant');
  final food = FirebaseDatabase.instance.ref('Food');

  @override
  Widget build(BuildContext context) {
    TabController tabControler = TabController(length: 2, vsync: this);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: double.maxFinite.h,
          width: double.maxFinite.w,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: 300.h,
                width: double.maxFinite.w,
                color: Colors.white,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: ()async{
                        Get.back();
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 50.w,right: 50.w),
                        child: Icon(Icons.arrow_back,
                        size: 80.sp,
                        color: AppColor.mainColor,
                        ),
                      ),
                    ),
                    Container(
                      height: 120.h,
                      width: 820.w,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.all(Radius.circular(100.sp)),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 50.h),
                          Icon(
                            Icons.search,
                            size: 70.sp,
                          ),
                          SizedBox(width: 40.w,),
                          _showTextField(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 20.h,
                color: Colors.black,
              ),
              SingleChildScrollView(
                child: Container(
                  height: 1831.h,
                  width: double.maxFinite.w,
                  color: Colors.transparent,
                  child: Container(
                    margin: EdgeInsets.all(80.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(text: "Popular Search", color: Colors.black, size: 50.sp, bold: true),
                        SizedBox(height: 50.h),
                        Container(
                          height: 400.h,
                          color: Colors.transparent,
                          child: GridView.builder(
                            itemCount: list.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,childAspectRatio: 2,mainAxisSpacing: 10,crossAxisSpacing: 10,mainAxisExtent: 35), 
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                  setState(() {
                                    currentIndex = index;
                                    _search.text = list[index];
                                  });
                                },
                                child: Container(
                                  height: 20.h,
                                  width: 400.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                     color: (currentIndex == index) ? AppColor.mainColor : Colors.white,
                                    border: Border.all(
                                      width: 3.w,
                                      color: Colors.black
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(50.sp)) 
                                  ),
                                  child: MyText(text: list[index], color: (currentIndex == index) ? Colors.white : Colors.black, size: 40.sp, bold: false),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 50.sp),
                        TabBar(
                          controller: tabControler,
                          unselectedLabelColor: Colors.black,
                          labelColor: AppColor.mainColor,
                          indicatorColor: AppColor.mainColor,
                          tabs: [
                            Text("Restaurant",
                              style: TextStyle(
                              fontSize: 50.sp,
                              ),
                            ),
                            Text("Food",
                              style: TextStyle(
                              fontSize: 50.sp,
                              ),
                            ),
                          ]
                        ),
                        Container(
                          height: 1030.h,
                          width: double.maxFinite.w,
                          color: Colors.white.withOpacity(0.7),
                          child: TabBarView(
                            controller: tabControler,
                            children: [
                              FirebaseAnimatedList(
                                query: restaurant,  
                                itemBuilder: (context, snapshot, animation, index) {
                                  String title = snapshot.child('name').value.toString();
                                  if(_search.text.isEmpty){
                                    return Container(
                                      margin: EdgeInsets.only(top: 20.sp),
                                      child: Card(
                                        child: ListTile(
                                          leading: Container(
                                            height: 200.h,
                                            width: 200.w,
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: NetworkImage(snapshot.child('img').value.toString()),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          title: Text(snapshot.child('name').value.toString()),
                                          subtitle: Text(snapshot.child('location').value.toString()),
                                          trailing: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStatePropertyAll(AppColor.mainColor),
                                              shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(50.sp))
                                                )
                                              ),
                                            ),
                                            onPressed: (){

                                            }, 
                                            child: MyText(text: "Visit", color: Colors.white, size: 40.sp, bold: false)
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  else if(title.toLowerCase().contains(_search.text.toLowerCase())){
                                    return Container(
                                     margin: EdgeInsets.only(top:20.h),
                                      child: Card(
                                        child: ListTile(
                                          leading: Container(
                                            height: 200.h,
                                            width: 200.w,
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: NetworkImage(snapshot.child('img').value.toString()),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          title: Text(snapshot.child('name').value.toString()),
                                          subtitle: Text(snapshot.child('location').value.toString()),
                                          trailing: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStatePropertyAll(AppColor.mainColor),
                                              shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(50.sp))
                                                )
                                              ),
                                            ),
                                            onPressed: (){

                                            }, 
                                            child: MyText(text: "Visit", color: Colors.white, size: 40.sp, bold: false)
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  else{
                                    return Container();
                                  }
                                },
                              ),
                              FirebaseAnimatedList(
                                query: food,  
                                itemBuilder: (context, snapshot, animation, index) {
                                  String title = snapshot.child('name').value.toString();
                                  if(_search.text.isEmpty){
                                    return Container(
                                      margin: EdgeInsets.only(top: 20.sp),
                                      child: Card(
                                        child: ListTile(
                                          leading: Container(
                                            height: 200.h,
                                            width: 200.w,
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: NetworkImage(snapshot.child('img').value.toString()),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          title: Text(snapshot.child('name').value.toString()),
                                          subtitle: Text(snapshot.child('restaurant').value.toString()),
                                          trailing:  PopupMenuButton(
                                            icon: Icon(
                                              Icons.add,
                                              color: AppColor.mainColor,
                                              ),
                                            itemBuilder: (context) => [
                                              PopupMenuItem(
                                                value: 1,
                                                child: GestureDetector(
                                                  onTap: (){
                                                    CartController cartController = Get.find();
                                                    String name = snapshot.child('name').value.toString();
                                                    cartController.addData(CartData(snapshot.child('name').value.toString(), snapshot.child('price').value.toString(), snapshot.child('img').value.toString(), snapshot.child('restaurant').value.toString()));
                                                    Navigator.pop(context);
                                                    Get.snackbar('FoodFrenzy', '$name added to cart',
                                                      backgroundColor: AppColor.mainColor,
                                                      colorText: Colors.white,
                                                      duration: const Duration(seconds: 1),
                                                    );
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      MyText(text: "Add to Cart", color: AppColor.mainColor, size: 40.sp, bold: true),
                                                      Icon(
                                                        CupertinoIcons.cart,
                                                        size: 60.sp,
                                                        color: AppColor.mainColor,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  else if(title.toLowerCase().contains(_search.text.toLowerCase())){
                                    return Container(
                                     margin: EdgeInsets.only(top:20.h),
                                      child: Card(
                                        child: ListTile(
                                          leading: Image(image: NetworkImage(snapshot.child('img').value.toString())),
                                          title: Text(snapshot.child('name').value.toString()),
                                          subtitle: Text(snapshot.child('restaurant').value.toString()),
                                          trailing: PopupMenuButton(
                                            icon: Icon(
                                              Icons.add,
                                              color: AppColor.mainColor,
                                              ),
                                            itemBuilder: (context) => [
                                              PopupMenuItem(
                                                value: 1,
                                                child: GestureDetector(
                                                  onTap: (){
                                                    CartController cartController = Get.find();
                                                    String name = snapshot.child('name').value.toString();
                                                    cartController.addData(CartData(snapshot.child('name').value.toString(), snapshot.child('price').value.toString(), snapshot.child('img').value.toString(), snapshot.child('restaurant').value.toString()));
                                                    Navigator.pop(context);
                                                    Get.snackbar('FoodFrenzy', '$name added to cart',
                                                      backgroundColor: AppColor.mainColor,
                                                      colorText: Colors.white,
                                                      duration: const Duration(seconds: 1),
                                                    );
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      MyText(text: "Add to Cart", color: AppColor.mainColor, size: 40.sp, bold: true),
                                                      Icon(
                                                        CupertinoIcons.cart,
                                                        size: 60.sp,
                                                        color: AppColor.mainColor,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  else{
                                    return Container();
                                  }
                                },
                              ),
                            ]
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }

   _showTextField(){
    return Container(
      height: 230.h,
      width: 600.w,
      color: Colors.transparent,
      child: TextFormField(
        controller: _search,
        decoration: const InputDecoration(
          hintText: 'Search Restaurant and Food',
          border: InputBorder.none,
        ),
        onChanged: (value){
          setState(() {
            
          });
        },
      ),
    );
  }
}