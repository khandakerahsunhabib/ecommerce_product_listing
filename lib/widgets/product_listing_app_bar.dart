import 'package:flutter/material.dart';

class ProductListingAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ProductListingAppBar({
    super.key,
    required this.child,
    this.icon,
    this.onTap,
  });

  final Widget child;
  final IconData? icon;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        icon == null
            ? SizedBox()
            : Padding(
              padding: EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () => onTap?.call(),
                icon: Icon(icon, size: 40, color: Colors.grey),
              ),
            ),
      ],
      automaticallyImplyLeading: false,
      title: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: child,
      ),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
