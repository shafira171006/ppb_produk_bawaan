// lib/screens/list_product_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/product_provider.dart';

class ListProductScreen extends StatefulWidget {
  const ListProductScreen({super.key});

  @override
  State<ListProductScreen> createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      final provider = Provider.of<ProductProvider>(context, listen: false);
      provider.fetchProducts();
      provider.fetchCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFEEFE2), // Warna background pink pastel lembut
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.auto_awesome, color: Color(0xFFD53F8C), size: 22),
            SizedBox(width: 8),
            Text(
              'Citra\'s Haven',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A5568),
                fontSize: 18,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFFFD1DC), // Pastel Pink yang manis
        elevation: 0,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.6),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.add_rounded, color: Color(0xFFD53F8C)),
              onPressed: () => context.push('/add'),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar yang lebih cantik & rounded
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            decoration: const BoxDecoration(
              color: Color(0xFFFFD1DC),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari produk impianmu...',
                hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFFE56AB3)),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () {
                          _searchController.clear();
                          provider.fetchProducts();
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              onSubmitted: (val) => provider.searchProducts(val),
              onChanged: (val) {
                if (val.isEmpty) {
                  provider.fetchProducts();
                }
              },
            ),
          ),

          const SizedBox(height: 8),

          // Filter Kategori Horizontal dengan warna-warni pastel yang lucu
          if (provider.categoryList.isNotEmpty)
            SizedBox(
              height: 45,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: provider.categoryList.length,
                itemBuilder: (context, index) {
                  final cat = provider.categoryList[index];
                  final pastelColors = [
                    const Color(0xFFC3CAFD), // Soft Lavender
                    const Color(0xFFB5F2EA), // Soft Mint
                    const Color(0xFFFFECC7), // Soft Peach/Yellow
                    const Color(0xFFFFD6E0), // Soft Pink
                    const Color(0xFFE2D9F3), // Soft Purple
                  ];
                  final colorItem = pastelColors[index % pastelColors.length];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ActionChip(
                      backgroundColor: colorItem,
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide.none,
                      ),
                      labelStyle: const TextStyle(
                        color: Color(0xFF2D3748),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                      label: Text(cat),
                      onPressed: () => provider.filterByCategory(cat),
                    ),
                  );
                },
              ),
            ),

          const SizedBox(height: 8),

          // Daftar Produk (Card dengan aksen pastel warna-warni)
          Expanded(
            child: provider.loading
                ? const Center(child: CircularProgressIndicator(color: Color(0xFFE56AB3)))
                : provider.products.isEmpty
                    ? const Center(child: Text('Produk tidak ditemukan', style: TextStyle(color: Colors.grey)))
                    : ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: provider.products.length,
                        itemBuilder: (context, index) {
                          final item = provider.products[index];
                          
                          final cardAccents = [
                            const Color(0xFFFFB7B2), // Soft Coral
                            const Color(0xFFFFDAC1), // Peach
                            const Color(0xFFE2F0CB), // Light Green
                            const Color(0xFFB5EAD7), // Mint
                            const Color(0xFFC7CEEA), // Periwinkle
                          ];
                          final accentColor = cardAccents[index % cardAccents.length];

                          return Container(
                            margin: const EdgeInsets.only(bottom: 14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: accentColor.withValues(alpha: 0.4),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                              border: Border.all(color: accentColor.withValues(alpha: 0.6), width: 1.5),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(12),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Container(
                                  color: accentColor.withValues(alpha: 0.2),
                                  child: CachedNetworkImage(
                                    imageUrl: item.thumbnail,
                                    width: 65,
                                    height: 65,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Center(
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(strokeWidth: 2),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => const Icon(Icons.error, size: 20),
                                  ),
                                ),
                              ),
                              title: Text(
                                item.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Color(0xFF2D3748),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 4),
                                  Text(
                                    '\$${item.price.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      color: Color(0xFF38A169),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: accentColor.withValues(alpha: 0.5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      item.category,
                                      style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF2D3748),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () => context.push('/detail/${item.id}'),
                              trailing: Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xFFEBF8FF),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.edit_rounded, color: Color(0xFF3182CE), size: 20),
                                  onPressed: () => context.push('/edit/${item.id}', extra: item),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}