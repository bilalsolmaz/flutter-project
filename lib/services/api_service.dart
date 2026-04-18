import 'dart:io';
import 'dart:convert';
import '../models/product.dart';

/// Ürün verilerini API'den çeker.
/// Birincil kaynak: wantapi.com/products.php
/// Yedek kaynak   : dummyjson.com/products
/// İkisi de başarısız olursa yerleşik mock veriler döner.
class ApiService {
  static const String _primaryUrl = 'https://wantapi.com/products.php';
  static const String _fallbackUrl =
      'https://dummyjson.com/products?limit=20';

  Future<List<Product>> fetchProducts() async {
    try {
      return await _fetchFromUrl(_primaryUrl);
    } catch (_) {
      try {
        return await _fetchFromUrl(_fallbackUrl);
      } catch (_) {
        return _mockProducts();
      }
    }
  }

  Future<List<Product>> _fetchFromUrl(String url) async {
    final client = HttpClient();
    client.connectionTimeout = const Duration(seconds: 10);
    try {
      final request = await client.getUrl(Uri.parse(url));
      request.headers.set('Accept', 'application/json');
      final response = await request.close();
      if (response.statusCode != 200) {
        throw Exception('HTTP ${response.statusCode}');
      }
      final body = await response.transform(utf8.decoder).join();
      final dynamic decoded = jsonDecode(body);

      List<dynamic> list;
      if (decoded is List) {
        list = decoded;
      } else if (decoded is Map && decoded.containsKey('products')) {
        list = decoded['products'] as List;
      } else {
        throw Exception('Unexpected JSON format');
      }
      return list
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList();
    } finally {
      client.close();
    }
  }

  List<Product> _mockProducts() => [
        const Product(
          id: 1,
          name: 'AirPods (2nd Gen)',
          description:
              'Effortless setup, high-quality audio, and comfortable fit for all-day wear.',
          price: 129,
          image:
              'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MME73',
          category: 'Audio',
        ),
        const Product(
          id: 2,
          name: 'AirPods Max',
          description:
              'High-fidelity audio, Active Noise Cancellation, and Spatial Audio with over-ear design.',
          price: 549,
          image:
              'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/airpods-max-select-202011',
          category: 'Audio',
        ),
        const Product(
          id: 3,
          name: 'HomePod',
          description:
              'Powerful speaker delivering rich, deep bass and stunning high-frequency detail.',
          price: 299,
          image:
              'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/homepod-select-202301',
          category: 'Smart Home',
        ),
        const Product(
          id: 4,
          name: 'HomePod Mini',
          description:
              'Surprisingly powerful sound in a small package with 360-degree audio.',
          price: 99,
          image:
              'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/homepod-mini-select-202104',
          category: 'Smart Home',
        ),
        const Product(
          id: 5,
          name: 'iPhone 15 Pro',
          description:
              'Titanium design, A17 Pro chip, and a customizable Action button.',
          price: 999,
          image:
              'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-15-pro-finish-select-202309-6-1inch',
          category: 'iPhone',
        ),
        const Product(
          id: 6,
          name: 'MacBook Pro 14"',
          description:
              'Supercharged by M3 Pro chip for exceptional performance and battery life.',
          price: 1999,
          image:
              'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/mbp14-spacegray-select-202310',
          category: 'Mac',
        ),
        const Product(
          id: 7,
          name: 'iPad Air',
          description:
              'Serious performance with M1 chip in a thin, light design with stunning display.',
          price: 599,
          image:
              'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/ipad-air-select-202203',
          category: 'iPad',
        ),
        const Product(
          id: 8,
          name: 'Apple Watch Series 9',
          description:
              'The most powerful Apple Watch with S9 chip and new Double Tap gesture.',
          price: 399,
          image:
              'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/watch-s9-select-202309',
          category: 'Watch',
        ),
      ];
}
