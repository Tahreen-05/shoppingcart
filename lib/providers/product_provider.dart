import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';
import '../repositories/product_repository.dart';

final productProvider = StateNotifierProvider<ProductNotifier, AsyncValue<List<Product>>>(
  (ref) => ProductNotifier(ProductRepository()),
);

class ProductNotifier extends StateNotifier<AsyncValue<List<Product>>> {
  final ProductRepository _repository;
  int _currentPage = 0;
  bool _hasMore = true;
  List<Product> _products = [];

  ProductNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadNextPage();
  }

  Future<void> loadNextPage() async {
    if (!_hasMore) return;

    try {
      final response = await _repository.getProducts(page: _currentPage);
      _products.addAll(response.products);
      _hasMore = response.products.length == response.limit;
      _currentPage++;
      state = AsyncValue.data(_products);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
