class Product {
  final String title;
  final String image;
  final String description;
  final String shortDescription;

  const Product({
    required this.title,
    required this.image,
    required this.description,
    required this.shortDescription,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json['title'],
      image: json['image'],
      description: json['description'],
      shortDescription: json['shortDescription'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'shortDescription': shortDescription,
      'description': description,
      'image': image,
    };
  }
}
