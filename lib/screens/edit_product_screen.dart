// lib/screens/edit_product_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../providers/product_provider.dart';

class EditProductScreen extends StatefulWidget {
  final Product product;
  const EditProductScreen({super.key, required this.product});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  late TextEditingController _titleController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.product.title);
    _priceController = TextEditingController(text: widget.product.price.toString());
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFEEFE2),
      appBar: AppBar(
        title: Text(
          'Edit ${widget.product.title}',
          style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF4A5568), fontSize: 18),
        ),
        backgroundColor: const Color(0xFFC7CEEA),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF4A5568)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Perbarui Informasi Produk',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF4A5568)),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Judul Produk',
                labelStyle: const TextStyle(color: Color(0xFF718096)),
                prefixIcon: const Icon(Icons.shopping_bag_outlined, color: Color(0xFF7A91B8)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: 'Harga (\$)',
                labelStyle: const TextStyle(color: Color(0xFF718096)),
                prefixIcon: const Icon(Icons.attach_money_rounded, color: Color(0xFF7A91B8)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB5EAD7),
                  foregroundColor: const Color(0xFF2D3748),
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: provider.loading
                    ? null
                    : () async {
                        final updatedProduct = widget.product.copyWith(
                          title: _titleController.text,
                          price: double.tryParse(_priceController.text) ?? widget.product.price,
                        );
                        bool success = await provider.updateProduct(widget.product.id, updatedProduct);
                        if (!mounted) return;
                        if (success) {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Berhasil memperbarui produk! ✨')),
                          );
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                        }
                      },
                child: provider.loading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF2D3748)),
                      )
                    : const Text('Simpan Perubahan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}