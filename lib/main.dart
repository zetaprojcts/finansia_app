import 'package:flutter/material.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart'; // Jika Anda sudah memisahkan theme

void main() {
  runApp(const FinansiaApp());
}

class FinansiaApp extends StatelessWidget {
  const FinansiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Finansia App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins', // Set font default ke Poppins
        useMaterial3: true,
      ),
      routerConfig: appRouter, // Menggunakan konfigurasi go_router
    );
  }
}
