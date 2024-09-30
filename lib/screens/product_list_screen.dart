import 'dart:io'; // Импортируем для работы с файлами
import 'package:flutter/material.dart';
import 'package:flutter_market_alpha/screens/product_add_screen.dart';
import '../data/data_loader.dart';
import '../models/product.dart';
import 'product_detail_screen.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final loadedProducts = await loadProducts();
    setState(() {
      products = loadedProducts;
    });
  }

  void _addProduct(Product product) {
    setState(() {
      products.add(product);
    });
  }

  void _removeProduct(Product product) {
  setState(() {
    products.remove(product);
  });
}

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Перечень семян'),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProductAddScreen(onAddProduct: _addProduct)),
            );
          },
        ),
      ],
    ),
    body: ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: Card.filled(
            color: Theme.of(context).cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                    child: products[index].image.startsWith('assets/')
                        ? Image.asset(
                            products[index].image,
                            fit: BoxFit.cover,
                            height: 150,
                          )
                        : Image.file(
                            File(products[index].image),
                            fit: BoxFit.cover,
                            height: 150,
                          ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          products[index].title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          products[index].shortDescription,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailScreen(
                                    product: products[index],
                                    onRemoveProduct: _removeProduct, // Передаем функцию удаления
                                  ),
                                ),
                              );
                            },
                            child: const Text('Прочитать подробнее'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
}