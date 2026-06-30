import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isObscure = true;

  // Variabel untuk indikator kekuatan password (Bar)
  double _strengthValue = 0.0;
  String _strengthLabel = '';
  Color _strengthColor = Colors.transparent;

  // Variabel untuk validasi checklist per karakter
  bool _hasMinLength = false;
  bool _hasUpperLower = false;
  bool _hasNumber = false;
  bool _hasSymbol = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Fungsi Cek Kekuatan & Syarat Password secara Real-Time
  void _evaluatePasswordStrength(String password) {
    if (password.isEmpty) {
      setState(() {
        _strengthValue = 0.0;
        _strengthLabel = '';
        _strengthColor = Colors.transparent;
        _hasMinLength = false;
        _hasUpperLower = false;
        _hasNumber = false;
        _hasSymbol = false;
      });
      return;
    }

    // Evaluasi masing-masing syarat
    bool minLength = password.length >= 8;
    bool upperLower = RegExp(r'(?=.*[a-z])(?=.*[A-Z])').hasMatch(password);
    bool number = RegExp(r'(?=.*\d)').hasMatch(password);
    bool symbol = RegExp(r'(?=.*[!@#$%^&*(),.?":{}|<>])').hasMatch(password);

    int score = 0;
    if (minLength) score += 1;
    if (upperLower) score += 1;
    if (number) score += 1;
    if (symbol) score += 1;

    setState(() {
      // Update status checklist
      _hasMinLength = minLength;
      _hasUpperLower = upperLower;
      _hasNumber = number;
      _hasSymbol = symbol;

      // Update bar indikator
      if (score == 0 || score == 1) {
        _strengthValue = 0.25;
        _strengthLabel = 'Lemah';
        _strengthColor = Colors.red;
      } else if (score == 2) {
        _strengthValue = 0.50;
        _strengthLabel = 'Sedang';
        _strengthColor = Colors.orange;
      } else if (score == 3) {
        _strengthValue = 0.75;
        _strengthLabel = 'Kuat';
        _strengthColor = Colors.lightGreen;
      } else if (score == 4) {
        _strengthValue = 1.0;
        _strengthLabel = 'Sangat Kuat';
        _strengthColor = Colors.green;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new, color: AppColors.neutral900),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                "Buat Akun Baru",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.neutral900,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                "Mulai perjalanan finansial Anda bersama kami",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              const SizedBox(height: 40),

              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "Nama Lengkap",
                  prefixIcon: const Icon(Icons.person_outline,
                      color: AppColors.neutral500),
                  filled: true,
                  fillColor: AppColors.neutral100,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 20),

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
                      borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 20),

              // Input Password
              TextFormField(
                controller: _passwordController,
                obscureText: _isObscure,
                onChanged: (val) => _evaluatePasswordStrength(val),
                decoration: InputDecoration(
                  hintText: "Kata Sandi",
                  prefixIcon: const Icon(Icons.lock_outline,
                      color: AppColors.neutral500),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _isObscure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.neutral500),
                    onPressed: () => setState(() => _isObscure = !_isObscure),
                  ),
                  filled: true,
                  fillColor: AppColors.neutral100,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none),
                ),
              ),

              // UI Indikator Kekuatan & Syarat Password (Muncul saat mulai mengetik)
              if (_strengthValue > 0) ...[
                const SizedBox(height: 16),

                // 1. Progress Bar
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: _strengthValue,
                          backgroundColor: AppColors.neutral200,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(_strengthColor),
                          minHeight: 6,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 80,
                      child: Text(
                        _strengthLabel,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: _strengthColor,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // 2. Daftar Periksa (Checklist) Syarat Karakter
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRequirementItem("Minimal 8 karakter", _hasMinLength),
                    const SizedBox(height: 8),
                    _buildRequirementItem(
                        "Mengandung huruf besar & kecil", _hasUpperLower),
                    const SizedBox(height: 8),
                    _buildRequirementItem("Mengandung angka (0-9)", _hasNumber),
                    const SizedBox(height: 8),
                    _buildRequirementItem(
                        "Mengandung simbol (!@#\$...)", _hasSymbol),
                  ],
                ),
              ],

              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // Logic registrasi di fase selanjutnya
                    context.pop();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text("Daftar Sekarang",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget Pembantu untuk membuat Baris Checklist
  Widget _buildRequirementItem(String text, bool isMet) {
    return Row(
      children: [
        Icon(
          isMet ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isMet ? Colors.green : AppColors.neutral400,
          size: 18,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: isMet ? AppColors.neutral900 : AppColors.neutral500,
            fontWeight: isMet ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
