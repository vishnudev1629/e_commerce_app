import 'review.dart';

class Product {
  int? productId;
  String? name;
  String? description;
  double? price;
  String? unit;
  String? image;
  int? discount;
  bool? availability;
  String? brand;
  String? category;
  double? rating;
  List<Review>? reviews;

  Product({
    this.productId,
    this.name,
    this.description,
    this.price,
    this.unit,
    this.image,
    this.discount,
    this.availability,
    this.brand,
    this.category,
    this.rating,
    this.reviews,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json['product_id'] as int?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        price: (json['price'] as num?)?.toDouble(),
        unit: json['unit'] as String?,
        image: json['image'] as String?,
        discount: json['discount'] as int?,
        availability: json['availability'] as bool?,
        brand: json['brand'] as String?,
        category: json['category'] as String?,
        rating: (json['rating'] as num?)?.toDouble(),
        reviews: (json['reviews'] as List<dynamic>?)
            ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'product_id': productId,
        'name': name,
        'description': description,
        'price': price,
        'unit': unit,
        'image': image,
        'discount': discount,
        'availability': availability,
        'brand': brand,
        'category': category,
        'rating': rating,
        'reviews': reviews?.map((e) => e.toJson()).toList(),
      };
}
