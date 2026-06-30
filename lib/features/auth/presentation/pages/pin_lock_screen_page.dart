import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';

class PinLockScreenPage extends StatefulWidget {
  const PinLockScreenPage({super.key});

  @override
  State<PinLockScreenPage> createState() => _PinLockScreenPageState();
}

class _PinLockScreenPageState extends State<PinLockScreenPage> {
  String _enteredPin = '';
  final int _pinLength = 6;

  // Fungsi memproses input angka dari papan numpad
  void _onNumberPressed(String number) {
    if (_enteredPin.length < _pinLength) {
      setState(() {
        _enteredPin += number;
      });

      // Jika digit PIN sudah lengkap (6 angka), otomatis proses ke halaman utama
      if (_enteredPin.length == _pinLength) {
        _processVerification();
      }
    }
  }

  // Fungsi menghapus satu angka di posisi paling belakang
  void _onBackspacePressed() {
    if (_enteredPin.isNotEmpty) {
      setState(() {
        _enteredPin = _enteredPin.substring(0, _enteredPin.length - 1);
      });
    }
  }

  // Simulasi verifikasi sukses dan navigasi menuju Dashboard Utama
  void _processVerification() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      // Menuju rute dashboard setelah PIN terverifikasi
      context.go('/dashboard');
    });
  }

  // Fungsi untuk memicu Lembar Interaksi Biometrik (Sidik Jari) dari bawah
  void _triggerBiometricOverlay() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              // Ikon Sidik Jari Utama Finansia
              const Icon(
                Icons.fingerprint_rounded,
                size: 76,
                color:
                    AppColors.primary, // Menggunakan warna utama hijau Finansia
              ),
              const SizedBox(height: 24),
              const Text(
                "Autentikasi Sidik Jari",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.neutral900,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Sentuh sensor pemindai sidik jari pada perangkat Anda untuk verifikasi instan.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 36),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        side: const BorderSide(color: AppColors.neutral300),
                      ),
                      child: const Text("Batal",
                          style: TextStyle(
                              color: AppColors.neutral700,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        context.go('/dashboard');
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text("Simulasi Sukses",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors
          .white, // Latar belakang putih bersih sesuai gambar kedua/ketiga
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // Memastikan status bar (baterai, jam, sinyal) otomatis berwarna hitam di layar putih
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 1),

            // Teks Atas
            Text(
              "Masukkan PIN Anda",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.neutral900,
                  ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Silakan masukkan 6 digit kode keamanan Anda",
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
            ),
            const SizedBox(height: 56),

            // Indikator 6 Titik PIN Responsif
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pinLength, (index) {
                bool isFilled = index < _enteredPin.length;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 120),
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // Titik terisi berubah hijau (primary), titik kosong berwarna abu-abu lembut
                    color: isFilled ? AppColors.primary : AppColors.neutral200,
                  ),
                );
              }),
            ),

            const Spacer(flex: 2),

            // Grid Papan Angka (Numpad) Minimalis
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 24),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio:
                      1.3, // Mengatur kerapatan spasi tombol agar simetris
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemCount: 12,
                itemBuilder: (context, index) {
                  // Tombol Kiri Bawah (Index 9): Akses Sidik Jari
                  if (index == 9) {
                    return IconButton(
                      onPressed: _triggerBiometricOverlay,
                      icon: const Icon(
                        Icons.fingerprint_rounded,
                        size: 40,
                        color: AppColors.primary,
                      ),
                    );
                  }

                  // Tombol Tengah Bawah (Index 10): Angka 0
                  if (index == 10) {
                    return _buildNumpadButton("0", () => _onNumberPressed("0"));
                  }

                  // Tombol Kanan Bawah (Index 11): Hapus (Backspace)
                  if (index == 11) {
                    return IconButton(
                      onPressed: _onBackspacePressed,
                      icon: const Icon(
                        Icons.backspace_outlined,
                        size: 26,
                        color: AppColors.neutral800,
                      ),
                    );
                  }

                  // Tombol Angka Standar (1 - 9)
                  final number = (index + 1).toString();
                  return _buildNumpadButton(
                      number, () => _onNumberPressed(number));
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // Komponen pembantu untuk merender tombol angka numpad yang konsisten
  Widget _buildNumpadButton(String number, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(40),
      child: Center(
        child: Text(
          number,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: AppColors.neutral900,
          ),
        ),
      ),
    );
  }
}
