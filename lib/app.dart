import 'package:ecommerce_product_listing/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
class EcommerceProductListingApp extends StatelessWidget {
  const EcommerceProductListingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
