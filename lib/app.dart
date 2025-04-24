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
      routes: {
        HomeScreen.name: (context) => const HomeScreen(),
        SearchScreen.name: (context) => const SearchScreen(),
      },
    );
  }
}
