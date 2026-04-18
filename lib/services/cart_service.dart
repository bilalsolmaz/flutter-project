import 'package:flutter/material.dart';
import '../models/product.dart';

/// Singleton sepet yöneticisi.
/// ValueNotifier ile tüm dinleyiciler anlık güncellenir.
class CartService {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final ValueNotifier<List<Product>> cartNotifier =
      ValueNotifier<List<Product>>([]);

  List<Product> get items => List.unmodifiable(cartNotifier.value);

  int get itemCount => cartNotifier.value.length;

  double get total =>
      cartNotifier.value.fold(0.0, (sum, p) => sum + p.price);

  bool isInCart(Product product) =>
      cartNotifier.value.any((p) => p.id == product.id);

  void addProduct(Product product) {
    if (!isInCart(product)) {
      cartNotifier.value = [...cartNotifier.value, product];
    }
  }

  void removeProduct(Product product) {
    cartNotifier.value =
        cartNotifier.value.where((p) => p.id != product.id).toList();
  }

  void clear() {
    cartNotifier.value = [];
  }
}
