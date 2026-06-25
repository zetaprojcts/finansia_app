import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/transaction_service.dart';
import '../../data/models/transaction_model.dart';

// 1. Menyediakan akses ke TransactionService
final transactionServiceProvider = Provider<TransactionService>((ref) {
  return TransactionService();
});

// 2. Provider untuk mengambil Ringkasan Saldo (Total, Pemasukan, Pengeluaran)
final transactionSummaryProvider = FutureProvider<Map<String, double>>((
  ref,
) async {
  final service = ref.watch(transactionServiceProvider);
  return await service.getSummary();
});

// 3. Provider untuk mengambil Daftar Transaksi Terakhir
final recentTransactionsProvider = FutureProvider<List<TransactionModel>>((
  ref,
) async {
  final service = ref.watch(transactionServiceProvider);
  return await service.getTransactions();
});
