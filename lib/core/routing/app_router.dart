import 'package:go_router/go_router.dart';

// --- IMPORT MODULE AUTH ---
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/onboarding_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/pin_lock_screen_page.dart';
import '../../features/auth/presentation/pages/biometric_screen_page.dart';
import '../../features/auth/presentation/pages/lock_screen_page.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';

// --- IMPORT MODULE DASHBOARD ---
import '../../features/dashboard/presentation/pages/main_page.dart'; // ✅ TAMBAHAN: Import MainPage
import '../../features/dashboard/presentation/pages/dashboard_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/pin',
        name: 'pin',
        builder: (context, state) => const PinLockScreenPage(),
      ),
      GoRoute(
        path: '/lockscreen',
        name: 'lockscreen', // ✅ TAMBAHAN: Menambahkan name agar konsisten
        builder: (context, state) => const LockScreenPage(),
      ),
      GoRoute(
        path: '/biometric',
        name: 'biometric', // ✅ TAMBAHAN: Menambahkan name agar konsisten
        builder: (context, state) => const BiometricScreenPage(),
      ),
      GoRoute(
        path: '/forgot-password',
        name: 'forgot-password',
        builder: (context, state) => const ForgotPasswordPage(),
      ),

      // ✅ TAMBAHAN UTAMA: Mendaftarkan rute /main yang dipanggil setelah login/PIN berhasil
      GoRoute(
        path: '/main',
        name: 'main',
        builder: (context, state) => const MainPage(),
      ),

      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        builder: (context, state) => const DashboardPage(),
      ),
    ],
  );
}
