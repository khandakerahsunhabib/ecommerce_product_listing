import 'package:ecommerce_product_listing/controllers/search_screen_controller.dart';
import 'package:ecommerce_product_listing/data/models/products.dart';
import 'package:ecommerce_product_listing/widgets/product_listing_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  static const String name = 'search_screen';

  @override
  Widget build(BuildContext context) {
    final SearchScreenController controller = Get.put(SearchScreenController());

    return Scaffold(
      appBar: ProductListingAppBar(
        onTap: () => _showSortBottomSheet(context),
        icon: Icons.filter_list_rounded,
        child: _buildSearchField(controller),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.searchTextController.text.isNotEmpty &&
            controller.filteredProducts.isEmpty) {
          return const Center(child: Text('No products found.'));
        }

        return GridView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: controller.filteredProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            mainAxisExtent: 250,
          ),
          itemBuilder: (context, index) {
            final Products product = controller.filteredProducts[index];
            return _buildProductCard(product);
          },
        );
      }),
    );
  }

  Widget _buildSearchField(SearchScreenController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextFormField(
        controller: controller.searchTextController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide.none),
          contentPadding: EdgeInsets.zero,
          prefixIcon: Icon(Icons.search_rounded, color: Colors.grey),
          hintText: 'Search Anything...',
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildProductCard(Products product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(8),
                ),
                child: Image.network(
                  product.image ?? '',
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (_, __, ___) => const Icon(Icons.broken_image, size: 100),
                ),
              ),
              const Positioned(
                top: 8,
                right: 8,
                child: Icon(Icons.favorite_border, color: Colors.grey),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.title ?? '',
              style: const TextStyle(fontSize: 13),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: FittedBox(
              child: Row(
                children: [
                  Text(
                    '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '\$${(product.price != null ? product.price! + 50 : 0)
                        .toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 12,
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    '10% OFF',
                    style: TextStyle(fontSize: 11, color: Colors.red),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 8),
            child: Row(
              children: [
                const Icon(Icons.star, color: Colors.orange, size: 16),
                const SizedBox(width: 4),
                Text(
                  '${product.rating?.rate ?? 0}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  ' (${product.rating?.count ?? 0})',
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSortBottomSheet(BuildContext context) {
    final controller = Get.find<SearchScreenController>();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Sort By',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Price - High to Low'),
                onTap: () {
                  controller.filteredProducts.sort(
                        (a, b) => (b.price ?? 0).compareTo(a.price ?? 0),
                  );
                  controller.filteredProducts.refresh();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Price - Low to High'),
                onTap: () {
                  controller.filteredProducts.sort(
                        (a, b) => (a.price ?? 0).compareTo(b.price ?? 0),
                  );
                  controller.filteredProducts.refresh();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
