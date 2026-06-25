import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  // Memanggil klien Supabase utama
  final SupabaseClient _supabase = Supabase.instance.client;

  // 1. Fungsi untuk Daftar Akun Baru (Email & Password)
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {'full_name': fullName}, // Menyimpan nama ke database Supabase
      );
      return response;
    } catch (e) {
      throw Exception('Gagal mendaftar: $e');
    }
  }

  // 2. Fungsi untuk Masuk (Email & Password)
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      throw Exception('Gagal masuk. Periksa kembali email dan password Anda.');
    }
  }

  // 3. Fungsi untuk Masuk dengan Google (OAuth)
  Future<bool> signInWithGoogle() async {
    try {
      final response = await _supabase.auth.signInWithOAuth(
        OAuthProvider.google,
      );
      return response;
    } catch (e) {
      throw Exception('Gagal login dengan Google: $e');
    }
  }

  // 4. Fungsi untuk Keluar (Logout)
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  // 5. Fungsi untuk Cek Sesi (Apakah user sedang login?)
  User? getCurrentUser() {
    return _supabase.auth.currentUser;
  }
}
