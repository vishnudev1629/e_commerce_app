// services/api_service.dart
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/Models/get_product/get_product.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'https://fake-store-api.mock.beeceptor.com/api/products';

  Future<Either<int, List<Product>>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        // Success response
        final List data = json.decode(response.body);

        final products = data.map((json) => Product.fromJson(json)).toList();
        return Right(products);
      } else if (response.statusCode == 404) {
        // Not Found Error
        return const Left(1); // Error code 1 for 404 Not Found
      } else if (response.statusCode == 500) {
        // Internal Server Error
        return const Left(2); // Error code 2 for 500 Server Error
      } else {
        // Other errors
        return const Left(3); // Error code 3 for any other HTTP errors
      }
    } catch (error) {
      if (error is http.ClientException) {
        return const Left(0); // Error code 0 for network issues
      } else {
        return const Left(4); // Error code 4 for any other general exceptions
      }
    }
  }
}
