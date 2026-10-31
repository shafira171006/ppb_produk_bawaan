// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'providers/product_provider.dart';
import 'models/product_model.dart';
import 'screens/list_product_screen.dart';
import 'screens/detail_product_screen.dart';
import 'screens/edit_product_screen.dart';
import 'screens/add_product_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

// setting go_router buat navigasi antar halaman
final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ListProductScreen(),
    ),
    GoRoute(
      path: '/detail/:id',
      builder: (context, state) => DetailProductScreen(
        id: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: '/edit/:id',
      builder: (context, state) => EditProductScreen(
        product: state.extra as Product,
      ),
    ),
    GoRoute(
      path: '/add',
      builder: (context, state) => const AddProductScreen(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Citra\'s Haven',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFD1DC), // Pastel Pink
          primary: const Color(0xFFE56AB3),
          secondary: const Color(0xFFC3CAFD), // Soft Lavender
          surface: const Color(0xFFFEEFE2),
        ),
        scaffoldBackgroundColor: const Color(0xFFFEEFE2),
      ),
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}