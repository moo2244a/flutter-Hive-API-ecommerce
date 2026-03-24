import 'package:hive_flutter/hive_flutter.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class ProductModel extends HiveObject {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final String thumbnail;
  final List<String> images;
  int? quantity = 0; // ✅ الاسم الصحيح

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.thumbnail,
    required this.images,
    this.quantity,
  });
  ProductModel copyWith({int? quantity}) {
    return ProductModel(
      id: id,
      title: title,
      description: description,
      category: category,
      price: price,
      thumbnail: thumbnail,
      images: images,
      quantity: quantity ?? this.quantity,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      price: (json['price'] as num).toDouble(),
      thumbnail: json['thumbnail'] ?? "",
      images: List<String>.from(json['images'] ?? []),
      quantity: json['quantity'] != null ? json['quantity'] as int : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'thumbnail': thumbnail,
      'images': images,
      'quantity': quantity,
    };
  }
}
