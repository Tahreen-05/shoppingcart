import 'package:dio/dio.dart';
import '../models/product.dart';

class ProductRepository {
  final Dio _dio = Dio();
  static const int _limit = 10;

  Future<ProductResponse> getProducts({required int page}) async {
    final response = await _dio.get(
      'https://dummyjson.com/products',
      queryParameters: {
        'limit': _limit,
        'skip': page * _limit,
      },
    );
    return ProductResponse.fromJson(response.data);
  }
}

class ProductResponse {
  final List<Product> products;
  final int total;
  final int skip;
  final int limit;

  ProductResponse({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      products: (json['products'] as List).map((p) => Product.fromJson(p)).toList(),
      total: json['total'],
      skip: json['skip'],
      limit: json['limit'],
    );
  }
} 