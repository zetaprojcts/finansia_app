import 'package:go_router/go_router.dart';

// --- IMPORT SEMUA HALAMAN MODUL 1 (AUTH) ---
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/auth/presentation/pages/pin_lock_screen_page.dart';
import '../../features/auth/presentation/pages/lock_screen_page.dart';
import '../../features/auth/presentation/pages/biometric_screen_page.dart';

// --- IMPORT SEMUA HALAMAN MODUL 2 (DASHBOARD) ---
import '../../features/dashboard/presentation/pages/main_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';

final GoRouter appRouter = GoRouter(
  // initialLocation mengatur halaman pertama yang dibuka saat aplikasi dijalankan
  // Sementara kita atur ke '/login'. Nanti saat modul Splash selesai, kita ubah ke '/splash'.
  initialLocation: '/login',

  routes: [
    // --- RUTE MODUL AUTH ---
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
      path: '/forgot-password',
      name: 'forgot-password',
      builder: (context, state) => const ForgotPasswordPage(),
    ),
    GoRoute(
      path: '/pin',
      name: 'pin',
      builder: (context, state) => const PinLockScreenPage(),
    ),
    GoRoute(
      path: '/lockscreen',
      name: 'lockscreen',
      builder: (context, state) => const LockScreenPage(),
    ),
    GoRoute(
      path: '/biometric',
      name: 'biometric',
      builder: (context, state) => const BiometricScreenPage(),
    ),

    // --- RUTE MODUL DASHBOARD ---
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
