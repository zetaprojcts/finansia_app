import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  // ProviderScope wajib ada agar Riverpod (State Management) kita bisa berfungsi
  runApp(const ProviderScope(child: FinansiaApp()));
}

class FinansiaApp extends StatelessWidget {
  const FinansiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finansia',
      debugShowCheckedModeBanner: false, // Menghilangkan pita "DEBUG" di pojok kanan atas
      home: const Scaffold(
        backgroundColor: Color(0xFFFAFAFA), // Warna latar belakang putih bersih
        body: Center(
          child: Text(
            'Finansia App\nFondasi Berhasil Dipasang!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF065F46), // Warna hijau utama Finansia
            ),
          ),
        ),
      ),
    );
  }
}
