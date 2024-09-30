import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/product.dart';

class ProductAddScreen extends StatefulWidget {
  final Function(Product) onAddProduct;

  const ProductAddScreen({super.key, required this.onAddProduct});

  @override
  _ProductAddScreenState createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController shortDescriptionController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? imagePath;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imagePath = pickedFile?.path; // Получение пути к выбранному изображению
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить продукт'),
      ),
      body: SingleChildScrollView( // Обернуть в SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Название'),
              ),
              TextField(
                controller: shortDescriptionController,
                decoration: const InputDecoration(labelText: 'Краткое описание'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Описание'),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 100,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: imagePath == null
                      ? const Center(child: Text('Нажмите для выбора изображения'))
                      : Image.file(
                          File(imagePath!),
                          fit: BoxFit.fitHeight,
                        ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Проверка на пустые значения
                  if (titleController.text.isEmpty || 
                      shortDescriptionController.text.isEmpty || 
                      descriptionController.text.isEmpty || 
                      imagePath == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Пожалуйста, заполните все поля и выберите изображение.')),
                    );
                    return;
                  }

                  // Отладка
                  print("Создание нового продукта...");

                  final newProduct = Product(
                    title: titleController.text,
                    shortDescription: shortDescriptionController.text,
                    description: descriptionController.text,
                    image: imagePath!,
                  );

                  print("Передача продукта в родительский виджет...");
                  widget.onAddProduct(newProduct); // Передача нового продукта в родительский виджет
                  print("Возврат назад...");
                  Navigator.pop(context); // Возврат назад
                },
                child: const Text('Добавить продукт'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
