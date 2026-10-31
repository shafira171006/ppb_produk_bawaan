// lib/screens/add_product_screen.dart

import 'package:flutter/material.dart';
import '../service/api_service.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEEFE2),
      appBar: AppBar(
        title: const Text(
          'Tambah Produk Baru',
          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF4A5568), fontSize: 18),
        ),
        backgroundColor: const Color(0xFFFFDAC1),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF4A5568)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Masukkan Detail Produk',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A5568),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Judul Produk',
                labelStyle: const TextStyle(color: Color(0xFF718096)),
                prefixIcon: const Icon(Icons.edit_note_rounded, color: Color(0xFFE28743)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: 'Harga (\$)',
                labelStyle: const TextStyle(color: Color(0xFF718096)),
                prefixIcon: const Icon(Icons.sell_rounded, color: Color(0xFFE28743)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFB7B2),
                  foregroundColor: const Color(0xFF2D3748),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: _loading
                    ? null
                    : () async {
                        if (_titleController.text.isEmpty || _priceController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Semua kolom harus diisi ya!')),
                          );
                          return;
                        }

                        setState(() => _loading = true);
                        final api = ApiServiceProducts();
                        final result = await api.addProduct({
                          'title': _titleController.text,
                          'price': double.tryParse(_priceController.text) ?? 0.0,
                        });

                        if (!mounted) return;
                        setState(() => _loading = false);

                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Produk berhasil ditambahkan! ✨ (ID: ${result.id})'),
                            backgroundColor: const Color(0xFFFFB7B2),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        );
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      },
                child: _loading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF2D3748)),
                      )
                    : const Text(
                        'Tambah Produk',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}