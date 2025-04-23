import 'package:ecommerce_product_listing/widgets/product_listing_app_bar.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  ProductListingAppBar(),
        body: const Center(child: Text('Your content here')),
    );
  }
}


