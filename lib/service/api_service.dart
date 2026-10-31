// lib/service/api_service.dart

import 'package:dio/dio.dart';
import '../models/product_model.dart';

class ApiServiceProducts {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://dummyjson.com',
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
    headers: {'Content-Type': 'application/json'},
  ));

  // Mengambil semua data produk dengan opsi limit dan skip (pagination)
  Future<ProductsResponse> getAllProducts({int limit = 30, int skip = 0}) async {
    final res = await _dio.get('/products', queryParameters: {'limit': limit, 'skip': skip});
    return ProductsResponse.fromJson(res.data);
  }

  // Mengambil detail satu produk spesifik berdasarkan ID-nya
  Future<Product> getProduct(int id) async {
    final res = await _dio.get('/products/$id');
    return Product.fromJson(res.data);
  }

  // Mencari produk berdasarkan keyword kata kunci (query)
  Future<ProductsResponse> searchProducts(String query) async {
    final res = await _dio.get('/products/search', queryParameters: {'q': query});
    return ProductsResponse.fromJson(res.data);
  }

  // Mengambil produk secara paginasi dengan tambahan parameter pilihan kolom jika ada
  Future<ProductsResponse> getProductsPaginated({int limit = 10, int skip = 0, String? select}) async {
    Map<String, dynamic> params = {'limit': limit, 'skip': skip};
    if (select != null) params['select'] = select;
    final res = await _dio.get('/products', queryParameters: params);
    return ProductsResponse.fromJson(res.data);
  }

  // Mengurutkan produk berdasarkan kriteria tertentu (sortBy dan order asc/desc)
  Future<ProductsResponse> sortProducts(String sortBy, String order) async {
    final res = await _dio.get('/products', queryParameters: {'sortBy': sortBy, 'order': order});
    return ProductsResponse.fromJson(res.data);
  }

  // Mengambil daftar kategori lengkap dalam bentuk objek
  Future<List<Category>> getCategories() async {
    final res = await _dio.get('/products/categories');
    return (res.data as List).map((e) => Category.fromJson(e)).toList();
  }

  // Mengambil daftar nama kategori dalam bentuk list teks (string)
  Future<List<String>> getCategoryList() async {
    final res = await _dio.get('/products/category-list');
    return (res.data as List).map((e) => e.toString()).toList();
  }

  // Mengambil daftar produk yang masuk ke dalam kategori tertentu
  Future<ProductsResponse> getProductsByCategory(String category) async {
    final res = await _dio.get('/products/category/$category');
    return ProductsResponse.fromJson(res.data);
  }

  // Menambah produk baru ke server
  Future<Product> addProduct(Map<String, dynamic> data) async {
    final res = await _dio.post('/products/add', data: data);
    return Product.fromJson(res.data);
  }

  // Mengubah data produk secara keseluruhan
  Future<Product> updateProduct(int id, Map<String, dynamic> data) async {
    final res = await _dio.put('/products/$id', data: data);
    return Product.fromJson(res.data);
  }

  // Mengubah sebagian data produk
  Future<Product> patchProduct(int id, Map<String, dynamic> partialData) async {
    final res = await _dio.patch('/products/$id', data: partialData);
    return Product.fromJson(res.data);
  }

  // Menghapus produk 
  Future<Product> deleteProduct(int id) async {
    final res = await _dio.delete('/products/$id');
    return Product.fromJson(res.data);
  }
}