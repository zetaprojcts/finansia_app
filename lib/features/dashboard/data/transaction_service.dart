import 'package:supabase_flutter/supabase_flutter.dart';
import 'models/transaction_model.dart';

class TransactionService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // 1. Fungsi untuk Mengambil Semua Transaksi Pengguna Saat Ini
  Future<List<TransactionModel>> getTransactions() async {
    try {
      // Karena kita sudah memasang RLS di Supabase, ini otomatis hanya akan
      // mengambil data milik user yang sedang login. Sangat aman!
      final response = await _supabase
          .from('transactions')
          .select()
          .order('created_at', ascending: false); // Urutkan dari yang terbaru

      // Ubah daftar JSON menjadi daftar TransactionModel
      return (response as List)
          .map((item) => TransactionModel.fromJson(item))
          .toList();
    } catch (e) {
      throw Exception('Gagal mengambil data transaksi: $e');
    }
  }

  // 2. Fungsi untuk Menambah Transaksi Baru
  Future<void> addTransaction({
    required double amount,
    required String type, // 'pemasukan' atau 'pengeluaran'
    String? category,
    String? description,
  }) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('Sesi pengguna tidak ditemukan.');

      await _supabase.from('transactions').insert({
        'user_id': userId,
        'amount': amount,
        'type': type,
        'category': category,
        'description': description,
      });
    } catch (e) {
      throw Exception('Gagal menambahkan transaksi: $e');
    }
  }

  // 3. Fungsi untuk Menghitung Total Saldo, Pemasukan, dan Pengeluaran
  Future<Map<String, double>> getSummary() async {
    try {
      final transactions = await getTransactions();

      double totalIncome = 0;
      double totalExpense = 0;

      for (var t in transactions) {
        if (t.type == 'pemasukan') {
          totalIncome += t.amount;
        } else if (t.type == 'pengeluaran') {
          totalExpense += t.amount;
        }
      }

      return {
        'totalBalance': totalIncome - totalExpense,
        'totalIncome': totalIncome,
        'totalExpense': totalExpense,
      };
    } catch (e) {
      throw Exception('Gagal menghitung ringkasan: $e');
    }
  }
}
