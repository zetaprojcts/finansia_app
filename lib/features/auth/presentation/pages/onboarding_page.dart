import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  String _selectedLanguage = 'ID';
  Timer? _timer; // Timer untuk auto-slide

  final List<Map<String, String>> _onboardingData = [
    {
      "title": "Selamat Datang di Finansia",
      "desc":
          "Kelola seluruh keuangan Anda dengan mudah, cerdas, dan aman dalam satu aplikasi.",
      "image": "assets/images/onboarding_1.svg"
    },
    {
      "title": "Dompet Bersama (Shared Wallet)",
      "desc":
          "Transparansi keuangan dengan pasangan atau keluarga kini lebih terorganisir.",
      "image": "assets/images/onboarding_2.svg"
    },
    {
      "title": "AI Financial Planner",
      "desc":
          "Pindai struk Anda dengan AI dan dapatkan rekomendasi anggaran otomatis yang pintar.",
      "image": "assets/images/onboarding_3.svg"
    },
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  // Logika untuk ganti slide otomatis setiap 2.5 detik
  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(milliseconds: 3500), (timer) {
      if (_currentPage < _onboardingData.length - 1) {
        _currentPage++;
        if (_pageController.hasClients) {
          _pageController.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        }
      } else {
        // Berhenti otomatis jika sudah di slide terakhir
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Mencegah memory leak
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Mengubah warna teks dan ikon status bar menjadi hitam (gelap)
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() => _currentPage = value);
                  // Reset timer jika user menggeser manual
                  _timer?.cancel();
                  if (value < _onboardingData.length - 1) {
                    _startAutoSlide();
                  }
                },
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) =>
                    _buildSlide(_onboardingData[index]),
              ),
            ),
            _buildBottomControls(),
          ],
        ),
      ),
    );
  }

  // Header: Chip Bahasa (Kiri) dan Tombol Skip (Kanan)
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Sejajar kiri dan kanan
        children: [
          // 1. Tombol Pilih Bahasa (Desain Chip)
          PopupMenuButton<String>(
            color: AppColors.background,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            onSelected: (String value) {
              setState(() => _selectedLanguage = value);
            },
            itemBuilder: (BuildContext context) => [
              _buildLanguageMenuItem('ID', 'assets/icons/ic_flag_id.svg'),
              _buildLanguageMenuItem('EN', 'assets/icons/ic_flag_en.svg'),
            ],
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.neutral200, // Warna background chip
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    _selectedLanguage == 'ID'
                        ? 'assets/icons/ic_flag_id.svg'
                        : 'assets/icons/ic_flag_en.svg',
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _selectedLanguage,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                  ),
                  // Panah bawah sudah dihilangkan
                ],
              ),
            ),
          ),

          // 2. Tombol Skip
          TextButton(
            onPressed: () {
              _timer?.cancel(); // Matikan timer sebelum pindah
              context.go('/login');
            },
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary, // Warna abu-abu
            ),
            child: Text(
              _selectedLanguage == 'ID' ? 'Lewati' : 'Skip',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  PopupMenuItem<String> _buildLanguageMenuItem(String value, String iconPath) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          SvgPicture.asset(iconPath, width: 24, height: 24),
          const SizedBox(width: 12),
          Text(value == 'ID' ? 'Indonesia' : 'English',
              style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildSlide(Map<String, String> data) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 6,
            child: SvgPicture.asset(
              data["image"]!,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            data["title"]!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Text(
            data["desc"]!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }

  Widget _buildBottomControls() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: List.generate(
              _onboardingData.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.only(right: 8),
                height: 8,
                width: _currentPage == index ? 24 : 8,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? AppColors.primary
                      : AppColors.neutral300,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_currentPage == _onboardingData.length - 1) {
                _timer?.cancel();
                context.go('/login');
              } else {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            child: Text(_currentPage == _onboardingData.length - 1
                ? 'Mulai'
                : 'Lanjut'),
          ),
        ],
      ),
    );
  }
}
