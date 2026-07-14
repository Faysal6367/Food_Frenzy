import 'package:food_frenzy/services/cart_data.dart';
import 'package:get/get.dart';

class CartController extends GetxController{

  static final RxList<CartData>  cartData = <CartData>[].obs;

  void addData(CartData data){
    cartData.add(data);
  }
}