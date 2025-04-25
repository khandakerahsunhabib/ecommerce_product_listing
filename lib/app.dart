import 'package:ecommerce_product_listing/controller_binder.dart';
import 'package:ecommerce_product_listing/screens/home/home_screen.dart';
import 'package:ecommerce_product_listing/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EcommerceProductListingApp extends StatelessWidget {
  const EcommerceProductListingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'E-commerce Product Listing App',
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.name,
      initialBinding: ControllerBinder(),
      routes: {
        HomeScreen.name: (context) => HomeScreen(),
        SearchScreen.name: (context) => const SearchScreen(),
      },
    );
  }
}
