import 'package:ecommerce_product_listing/controllers/home_screen_controller.dart';
import 'package:ecommerce_product_listing/data/models/products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreenController extends GetxController {
  final HomeScreenController _homeController = Get.find<HomeScreenController>();

  final TextEditingController searchTextController = TextEditingController();
  final RxList<Products> filteredProducts = <Products>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    filteredProducts.assignAll(_homeController.allProducts);
    searchTextController.addListener(_searchProducts);
  }

  void _searchProducts() {
    final query = searchTextController.text.toLowerCase();

    if (query.isEmpty) {
      filteredProducts.assignAll(_homeController.allProducts);
    } else {
      final results = _homeController.allProducts.where((product) {
        final title = product.title?.toLowerCase() ?? '';
        return title.contains(query);
      }).toList();

      filteredProducts.assignAll(results);
    }
  }

  @override
  void onClose() {
    searchTextController.dispose();
    super.onClose();
  }
}
