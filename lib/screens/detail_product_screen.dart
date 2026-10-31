// lib/screens/detail_product_screen.dart

import 'package:flutter/material.dart';
import '../service/api_service.dart';
import '../models/product_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DetailProductScreen extends StatelessWidget {
  final String id;
  const DetailProductScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final api = ApiServiceProducts();

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Produk #$id', style: const TextStyle(color: Color(0xFF4A5568))),
        backgroundColor: const Color(0xFFE2D9F3), // Pastel Lavender
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF4A5568)),
      ),
      body: FutureBuilder<Product>(
        future: api.getProduct(int.parse(id)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFFB794F4)));
          }
          if (snapshot.hasError) {
            return Center(child: Text('Gagal memuat detail: ${snapshot.error}'));
          }

          final product = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container Thumbnail dengan latar belakang pastel lembut
                Container(
                  width: double.infinity,
                  height: 280,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF7FAFC),
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
                  ),
                  child: Center(
                    child: CachedNetworkImage(
                      imageUrl: product.thumbnail,
                      height: 220,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFC6F6D5), // Pastel Green
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              product.category.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF22543D),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 18),
                              const SizedBox(width: 4),
                              Text(
                                '${product.rating}',
                                style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF4A5568)),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        product.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3748),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF319795),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          _buildInfoBadge('Brand: ${product.brand.isNotEmpty ? product.brand : "Generic"}', const Color(0xFFFED7D7)),
                          const SizedBox(width: 8),
                          _buildInfoBadge('Stok: ${product.stock}', const Color(0xFFFEFCBF)),
                        ],
                      ),
                      const Divider(height: 32, thickness: 1),
                      const Text(
                        'Deskripsi Produk',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3748),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoBadge(String text, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF2D3748)),
      ),
    );
  }
}