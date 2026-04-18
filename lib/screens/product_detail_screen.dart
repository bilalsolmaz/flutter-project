import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/cart_service.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cart = CartService();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(child: _buildScrollContent(context)),
          _buildBottomBar(context, cart),
        ],
      ),
    );
  }

  // ─── Scrollable Content ──────────────────────────────────────────────────

  Widget _buildScrollContent(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _buildSliverAppBar(context),
        SliverToBoxAdapter(child: _buildInfo(context)),
      ],
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 310,
      pinned: true,
      backgroundColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new,
                size: 17, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: const Color(0xFFF5F5F7),
          padding: const EdgeInsets.all(24),
          child: product.image.isNotEmpty
              ? Image.network(
                  product.image,
                  fit: BoxFit.contain,
                  loadingBuilder: (_, child, progress) {
                    if (progress == null) return child;
                    return const Center(
                        child: CircularProgressIndicator(color: Colors.black));
                  },
                  errorBuilder: (_, __, ___) => const Center(
                    child: Icon(Icons.image_not_supported_outlined,
                        size: 80, color: Colors.grey),
                  ),
                )
              : const Center(
                  child: Icon(Icons.image_not_supported_outlined,
                      size: 80, color: Colors.grey),
                ),
        ),
      ),
    );
  }

  Widget _buildInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ad + Fiyat
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  product.name,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '\$${product.price.toStringAsFixed(0)}',
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          ),

          if (product.category.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              product.category,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
            ),
          ],

          const SizedBox(height: 24),
          const _SectionTitle('Description'),
          const SizedBox(height: 8),
          Text(
            product.description.isNotEmpty
                ? product.description
                : 'Bu ürün hakkında açıklama bulunmamaktadır.',
            style: TextStyle(
                fontSize: 14, color: Colors.grey.shade600, height: 1.55),
          ),

          const SizedBox(height: 28),
          const _SectionTitle('Specifications'),
          const SizedBox(height: 12),
          _SpecRow(label: 'Category',
              value: product.category.isNotEmpty ? product.category : 'N/A'),
          _SpecRow(label: 'Price',
              value: '\$${product.price.toStringAsFixed(2)}'),
          _SpecRow(label: 'Product ID', value: '#${product.id}'),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  // ─── Bottom Bar ──────────────────────────────────────────────────────────

  Widget _buildBottomBar(BuildContext context, CartService cart) {
    return ValueListenableBuilder<List<Product>>(
      valueListenable: cart.cartNotifier,
      builder: (context, items, _) {
        final inCart = cart.isInCart(product);
        return Container(
          padding: EdgeInsets.fromLTRB(
              20, 12, 20, MediaQuery.of(context).padding.bottom + 16),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 10,
                offset: Offset(0, -3),
              ),
            ],
          ),
          child: SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: inCart ? const Color(0xFFEEEEEE) : Colors.black,
                foregroundColor: inCart ? Colors.black : Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: () {
                if (inCart) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CartScreen()),
                  );
                } else {
                  cart.addProduct(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${product.name} sepete eklendi ✓'),
                      duration: const Duration(seconds: 2),
                      backgroundColor: Colors.black87,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  );
                }
              },
              child: Text(
                inCart ? 'Sepete Git  →' : 'Sepete Ekle',
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ─── Helpers ─────────────────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: const TextStyle(
            fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
      );
}

class _SpecRow extends StatelessWidget {
  final String label;
  final String value;
  const _SpecRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(label,
                style: TextStyle(
                    fontSize: 13, color: Colors.grey.shade500)),
          ),
          Expanded(
            flex: 3,
            child: Text(value,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
