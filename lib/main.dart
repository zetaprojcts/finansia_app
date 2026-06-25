import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart'; // Paket Google Fonts diaktifkan
import 'core/constants/app_colors.dart';
import 'core/routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Supabase
  await Supabase.initialize(
    url: 'https://mzyvcmzmedfdeofyhxyf.supabase.co',
    publishableKey: 'sb_publishable_9l0EkT-_thW1sPeG79Km5A_zs6FWk0Q',
  );

  runApp(const ProviderScope(child: FinansiaApp()));
}

class FinansiaApp extends StatelessWidget {
  const FinansiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Finansia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,

        // A. PENERAPAN FONT POPPINS SECARA GLOBAL
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),

        // B. SENTRALISASI GAYA INPUT FIELD (TEXTFIELD FINANSIA)
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF3F4F6),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          hintStyle: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
        ),

        // C. SENTRALISASI GAYA TOMBOL UTAMA (ELEVATED BUTTON FINANSIA)
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      routerConfig: appRouter,
    );
  }
}
