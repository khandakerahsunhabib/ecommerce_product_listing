import 'package:ecommerce_product_listing/data/models/network_response.dart';
import 'package:ecommerce_product_listing/data/models/products.dart';
import 'package:ecommerce_product_listing/data/services/network_caller.dart';
import 'package:ecommerce_product_listing/data/utils/urls.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  List<Products> _productsList = [];

  List<Products> get productsList => _productsList;

  Future<bool> getProductList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.productList,
    );
    if (response.isSuccess) {
      final Products products = Products.fromJson(response.responseData);
      _productsList.add(products);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
