import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Menambahkan Controller untuk menangkap input pengguna
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // State untuk menampilkan/menyembunyikan password
  bool _isObscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Full Screen
          Image.asset(
            'assets/images/bg_auth.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Text(
                    "Masuk ke Finansia",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.neutral900,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Kelola keuangan Anda dengan aman dan cerdas",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const SizedBox(height: 48),

                  // Input Email
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Alamat Email",
                      prefixIcon: const Icon(Icons.email_outlined,
                          color: AppColors.neutral500),
                      filled: true,
                      fillColor: AppColors.neutral100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Input Password dengan Toggle Mata
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      hintText: "Kata Sandi",
                      prefixIcon: const Icon(Icons.lock_outline,
                          color: AppColors.neutral500),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.neutral500,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                      filled: true,
                      fillColor: AppColors.neutral100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  // Lupa Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {}, // Tambahkan rute lupa password nanti
                      child: const Text("Lupa Sandi?",
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Tombol Masuk Utama
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () => context.go('/pin'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text("Masuk",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Pemisah (Divider)
                  const Row(
                    children: [
                      Expanded(child: Divider(color: AppColors.neutral300)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text("ATAU",
                            style: TextStyle(
                                color: AppColors.neutral500,
                                fontWeight: FontWeight.bold,
                                fontSize: 12)),
                      ),
                      Expanded(child: Divider(color: AppColors.neutral300)),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Tombol Google
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      side: const BorderSide(color: AppColors.neutral300),
                    ),
                    onPressed: () {},
                    icon: SvgPicture.asset('assets/icons/ic_google.svg',
                        width: 24),
                    label: const Text("Lanjut dengan Google",
                        style: TextStyle(
                            color: AppColors.neutral900,
                            fontWeight: FontWeight.w600)),
                  ),

                  const SizedBox(height: 32),

                  // Navigasi ke Halaman Register
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Belum punya akun?",
                          style: TextStyle(color: AppColors.textSecondary)),
                      TextButton(
                        onPressed: () => context.push('/register'),
                        child: const Text("Daftar Baru",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
