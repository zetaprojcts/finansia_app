import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/constants/app_colors.dart'; // Memanggil file warna kita

void main() {
  runApp(const ProviderScope(child: FinansiaApp()));
}

class FinansiaApp extends StatelessWidget {
  const FinansiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finansia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Kita gunakan warna dari AppColors di sini!
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Text(
            'Finansia App\nSistem Warna Berhasil Diterapkan!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primary, // Menggunakan warna hijau kita
            ),
          ),
        ),
      ),
    );
  }
}
