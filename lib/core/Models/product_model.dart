class Product {  
  final String name;  
  final double price;  
  final String brand;  
  final double rating;  
    
  Product({required this.name, required this.price, required this.brand, required this.rating});  
  
  factory Product.fromJson(Map<String, dynamic> json) {  
    return Product(  
      name: json['name'],  
      price: json['price'].toDouble(),  
      brand: json['brand'],  
      rating: json['rating'].toDouble(),  
    );  
  }  
}
