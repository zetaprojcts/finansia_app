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

  // TAMBAHAN BARU: Mengunci pilihan jenis kelamin pengguna untuk default avatar (.svg)
  String? _selectedGender;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Fungsi Cek Kekuatan & Syarat Password secara Real-Time (Tetap Dipertahankan)
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

      // Update bar indikator warna
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
        // Status bar tetap berwarna hitam konsisten sesuai request sebelumnya
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

              // 1. Input Nama
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

              // 2. Input Email
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

              // 3. TAMBAHAN BARU: Dropdown Jenis Kelamin disisipkan di sini secara simetris
              DropdownButtonFormField<String>(
                initialValue: _selectedGender,
                hint: const Text("Jenis Kelamin"),
                icon: const Icon(Icons.keyboard_arrow_down_rounded,
                    color: AppColors.neutral500),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.face_rounded,
                      color: AppColors.neutral500),
                  filled: true,
                  fillColor: AppColors.neutral100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: ['Laki-laki', 'Perempuan'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                        style: const TextStyle(color: AppColors.neutral900)),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedGender = newValue;
                  });
                },
              ),
              const SizedBox(height: 20),

              // 4. Input Password
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

              // UI Indikator Kekuatan & Syarat Password (Tetap Dipertahankan Utuh)
              if (_strengthValue > 0) ...[
                const SizedBox(height: 16),

                // Progress Bar Warna Indikator
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

                // Checklist Syarat Karakter (Tetap Dipertahankan)
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

              // Tombol Utama
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
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

  // Widget Pembuat Baris Checklist (Tetap Dipertahankan)
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
