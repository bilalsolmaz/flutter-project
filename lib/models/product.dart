class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String image;
  final String category;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    double parsePrice(dynamic val) {
      if (val == null) return 0.0;
      if (val is num) return val.toDouble();
      return double.tryParse(
            val.toString().replaceAll(RegExp(r'[^0-9.]'), ''),
          ) ??
          0.0;
    }

    int parseId(dynamic val) {
      if (val == null) return 0;
      if (val is int) return val;
      return int.tryParse(val.toString()) ?? 0;
    }

    return Product(
      id: parseId(json['id']),
      name: (json['name'] ?? json['title'] ?? 'Ürün').toString(),
      description: (json['description'] ?? '').toString(),
      price: parsePrice(json['price']),
      image: (json['image'] ??
              json['thumbnail'] ??
              json['img'] ??
              '')
          .toString(),
      category: (json['category'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'image': image,
        'category': category,
      };
}
