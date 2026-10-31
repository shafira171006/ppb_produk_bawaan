// lib/providers/product_provider.dart

import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../service/api_service.dart';

class ProductProvider extends ChangeNotifier {
  // inisialisasi service api
  final ApiServiceProducts _api = ApiServiceProducts();

  List<Product> _products = [];
  List<String> _categoryList = [];
  bool _loading = false;
  int _total = 0;

  List<Product> get products => _products;
  List<String> get categoryList => _categoryList;
  bool get loading => _loading;
  int get total => _total;

  // buat ambil semua data produk dari server
  Future<void> fetchProducts({int limit = 30, int skip = 0}) async {
    _loading = true;
    notifyListeners();
    try {
      final res = await _api.getAllProducts(limit: limit, skip: skip);
      _products = res.products;
      _total = res.total;
    } catch (e) {
      debugPrint('gagal load produk: $e');
    }
    _loading = false;
    notifyListeners();
  }

  // narik list kategori buat filter
  Future<void> fetchCategories() async {
    try {
      _categoryList = await _api.getCategoryList();
      notifyListeners();
    } catch (e) {
      debugPrint('gagal ambil kategori: $e');
    }
  }

  // fitur search produk
  Future<void> searchProducts(String query) async {
    if (query.trim().isEmpty) return fetchProducts();
    _loading = true;
    notifyListeners();
    try {
      final res = await _api.searchProducts(query);
      _products = res.products;
    } catch (e) {
      debugPrint('error pas nyari: $e');
    }
    _loading = false;
    notifyListeners();
  }

  // filter berdasarkan kategori yang dipilih
  Future<void> filterByCategory(String category) async {
    _loading = true;
    notifyListeners();
    try {
      final res = await _api.getProductsByCategory(category);
      _products = res.products;
    } catch (e) {
      debugPrint('error pas filter kategori: $e');
    }
    _loading = false;
    notifyListeners();
  }

  // update data produk
  Future<bool> updateProduct(int id, Product updated) async {
    _loading = true;
    notifyListeners();
    try {
      final result = await _api.updateProduct(id, updated.toJson());
      int idx = _products.indexWhere((p) => p.id == id);
      if (idx != -1) {
        _products[idx] = result;
      }
      _loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _loading = false;
      notifyListeners();
      return false;
    }
  }
}