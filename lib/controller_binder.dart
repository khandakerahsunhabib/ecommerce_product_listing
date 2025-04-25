import 'package:ecommerce_product_listing/controllers/home_screen_controller.dart';
import 'package:ecommerce_product_listing/controllers/search_screen_controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeScreenController());
    Get.put(SearchScreenController());
  }
}
