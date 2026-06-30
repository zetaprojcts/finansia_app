import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';

class LockScreenPage extends StatefulWidget {
  const LockScreenPage({super.key});

  @override
  State<LockScreenPage> createState() => _LockScreenPageState();
}

class _LockScreenPageState extends State<LockScreenPage> {
  String _enteredPin = '';
  final int _pinLength = 6;

  void _onNumberPressed(String number) {
    if (_enteredPin.length < _pinLength) {
      setState(() => _enteredPin += number);
      if (_enteredPin.length == _pinLength) {
        // Logika verifikasi PIN ke Dashboard
        Future.delayed(const Duration(milliseconds: 300), () {
          if (!mounted) return;
          context.go('/dashboard');
        });
      }
    }
  }

  void _onBackspacePressed() {
    if (_enteredPin.isNotEmpty) {
      setState(
          () => _enteredPin = _enteredPin.substring(0, _enteredPin.length - 1));
    }
  }

  // Tombol kiri bawah akan mengarahkan user ke Layar Biometrik (Screen 3)
  void _goToBiometricScreen() {
    context.push('/biometric');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 1),
            Text("Masukkan PIN Anda",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold, color: AppColors.neutral900)),
            const SizedBox(height: 10),
            const Text("Silakan masukkan 6 digit PIN keamanan",
                style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
            const SizedBox(height: 56),

            // Indikator PIN
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
                      color:
                          isFilled ? AppColors.primary : AppColors.neutral200),
                );
              }),
            ),

            const Spacer(flex: 2),

            // Numpad dengan Ikon Sidik Jari (Khas Screen 2)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 24),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.3,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16),
                itemCount: 12,
                itemBuilder: (context, index) {
                  if (index == 9) {
                    return IconButton(
                        onPressed: _goToBiometricScreen,
                        icon: const Icon(Icons.fingerprint_rounded,
                            size: 40, color: AppColors.primary));
                  }
                  if (index == 10) {
                    return _buildNumpadButton("0", () => _onNumberPressed("0"));
                  }
                  if (index == 11) {
                    return IconButton(
                        onPressed: _onBackspacePressed,
                        icon: const Icon(Icons.backspace_outlined,
                            size: 26, color: AppColors.neutral800));
                  }

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

  Widget _buildNumpadButton(String number, VoidCallback onTap) {
    return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(40),
        child: Center(
            child: Text(number,
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: AppColors.neutral900))));
  }
}
