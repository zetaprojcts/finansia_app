import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/auth_service.dart';

// 1. Provider untuk menyediakan akses ke AuthService
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

// 2. StateNotifier untuk mengontrol status loading dan error di UI
class AuthNotifier extends StateNotifier<AsyncValue<void>> {
  final AuthService _authService;

  AuthNotifier(this._authService) : super(const AsyncValue.data(null));

  // Logika Daftar (Register)
  Future<void> register(String email, String password, String fullName) async {
    state = const AsyncValue.loading();
    try {
      await _authService.signUp(
        email: email,
        password: password,
        fullName: fullName,
      );
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  // Logika Masuk (Login)
  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      await _authService.signIn(email: email, password: password);
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

// 3. Provider utama yang akan dipanggil oleh halaman Login & Register
final authProvider = StateNotifierProvider<AuthNotifier, AsyncValue<void>>((
  ref,
) {
  final authService = ref.watch(authServiceProvider);
  return AuthNotifier(authService);
});
