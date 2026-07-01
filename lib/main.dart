import 'package:flutter/material.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: Inisialisasi Supabase dan Local Storage di sini nantinya

  runApp(const FinansiaApp());
}

class FinansiaApp extends StatelessWidget {
  const FinansiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color hijauFinansia = Color(0xff16A34A);

    return MaterialApp.router(
      title: 'Finansia',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme.copyWith(
        primaryColor: hijauFinansia,
        colorScheme: ColorScheme.fromSeed(
          seedColor: hijauFinansia,
          primary: hijauFinansia,
          secondary: hijauFinansia,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: hijauFinansia,
          selectionColor: Color(0x3316A34A),
          selectionHandleColor: hijauFinansia,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: hijauFinansia,
          ),
        ),
      ),
      // ✅ KEMBALI MENGGUNAKAN AppRouter.router SESUAI BAWAAN KODE ANDA
      routerConfig: AppRouter.router,
    );
  }
}
