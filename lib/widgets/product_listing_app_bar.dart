import 'package:flutter/material.dart';

class ProductListingAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ProductListingAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: _buildSearchFieldContents(context),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  Widget _buildSearchFieldContents(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.search_rounded, color: Colors.grey, size: 30),
            const SizedBox(width: 10),
            Text(
              'Search Anything...',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
