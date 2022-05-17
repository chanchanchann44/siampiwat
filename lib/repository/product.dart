import 'package:flutter/services.dart';
import 'package:test_siampiwat/models/productModel.dart';

class ProductRepo {
  Future<Product> getProductList() async {
    final String response = await rootBundle.loadString('assets/product.json');
    final res = productFromJson(response);

    return res;
  }
}

class NetworkError extends Error {}
