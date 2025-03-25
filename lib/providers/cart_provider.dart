import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';

final cartProvider = StateNotifierProvider<CartNotifier, Map<Product, int>>(
  (ref) => CartNotifier(),
);

class CartNotifier extends StateNotifier<Map<Product, int>> {
  CartNotifier() : super({});

  void addToCart(Product product) {
    state = {
      ...state,
      product: (state[product] ?? 0) + 1,
    };
  }

  void decrementQuantity(Product product) {
    if (!state.containsKey(product)) return;
    
    if (state[product] == 1) {
      final newState = Map<Product, int>.from(state);
      newState.remove(product);
      state = newState;
    } else {
      state = {
        ...state,
        product: state[product]! - 1,
      };
    }
  }
}
