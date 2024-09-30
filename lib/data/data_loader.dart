import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/product.dart';

Future<List<Product>> loadProducts() async {
  final String response = await rootBundle.loadString('assets/data/products.json');
  final List<dynamic> data = json.decode(response);
  return data.map((item) => Product.fromJson(item)).toList();
}
