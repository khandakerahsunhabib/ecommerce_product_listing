import 'package:ecommerce_product_listing/data/models/network_response.dart';
import 'package:ecommerce_product_listing/data/models/products.dart';
import 'package:ecommerce_product_listing/data/services/network_caller.dart';
import 'package:ecommerce_product_listing/data/utils/urls.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  final int _itemsPerPage = 6;
  int _currentPage = 1;

  List<Products> _allProducts = [];
  List<Products> _visibleProducts = [];

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  List<Products> get productsList => _visibleProducts;

  int get currentPage => _currentPage;

  int get totalPages => (_allProducts.length / _itemsPerPage).ceil();

  Future<bool> getProductList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.productList,
    );

    if (response.isSuccess) {
      final List<dynamic> data = response.responseData;
      _allProducts = data.map((e) => Products.fromJson(e)).toList();
      _currentPage = 1;
      _setVisibleProducts();
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }

  void changePage(int page) {
    _currentPage = page;
    _setVisibleProducts();
    update();
  }

  void _setVisibleProducts() {
    int start = (_currentPage - 1) * _itemsPerPage;
    int end = start + _itemsPerPage;
    _visibleProducts = _allProducts.sublist(
      start,
      end > _allProducts.length ? _allProducts.length : end,
    );
  }
}
