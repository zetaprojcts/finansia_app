import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../providers/transaction_provider.dart';

class AddTransactionBottomSheet extends ConsumerStatefulWidget {
  const AddTransactionBottomSheet({super.key});

  @override
  ConsumerState<AddTransactionBottomSheet> createState() =>
      _AddTransactionBottomSheetState();
}

class _AddTransactionBottomSheetState
    extends ConsumerState<AddTransactionBottomSheet> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  String _transactionType = 'pengeluaran'; // Default pilihan adalah pengeluaran
  bool _isLoading = false;

  void _submitTransaction() async {
    final amountText = amountController.text.replaceAll(
      RegExp(r'[^0-9]'),
      '',
    ); // Hanya ambil angka
    final amount = double.tryParse(amountText) ?? 0.0;

    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Masukkan nominal yang valid!'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 1. Kirim data ke Supabase
      await ref
          .read(transactionServiceProvider)
          .addTransaction(
            amount: amount,
            type: _transactionType,
            category: categoryController.text.trim(),
            description: descController.text.trim(),
          );

      // 2. Menyuruh Riverpod untuk mengambil ulang data terbaru dari Supabase
      ref.invalidate(transactionSummaryProvider);
      ref.invalidate(recentTransactionsProvider);

      if (mounted) {
        Navigator.pop(context); // Tutup form pop-up setelah sukses
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Transaksi berhasil ditambahkan!'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Memastikan form muncul dengan baik di atas keyboard
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(24, 24, 24, bottomInset + 24),
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Tambah Transaksi',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 24),

            // Pilihan Pemasukan / Pengeluaran
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(
                  value: 'pengeluaran',
                  label: Text('Pengeluaran'),
                  icon: Icon(Icons.arrow_upward),
                ),
                ButtonSegment(
                  value: 'pemasukan',
                  label: Text('Pemasukan'),
                  icon: Icon(Icons.arrow_downward),
                ),
              ],
              selected: {_transactionType},
              onSelectionChanged: (Set<String> newSelection) {
                setState(() => _transactionType = newSelection.first);
              },
              style: SegmentedButton.styleFrom(
                selectedBackgroundColor: _transactionType == 'pemasukan'
                    ? AppColors.success.withValues(alpha: 0.2)
                    : AppColors.error.withValues(alpha: 0.2),
                selectedForegroundColor: _transactionType == 'pemasukan'
                    ? AppColors.success
                    : AppColors.error,
              ),
            ),
            const SizedBox(height: 24),

            // Input Nominal Uang
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                hintText: '0',
                prefixText: 'Rp ',
                prefixStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Input Kategori
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(
                hintText: 'Kategori (contoh: Makanan, Gaji)',
              ),
            ),
            const SizedBox(height: 16),

            // Input Deskripsi (Opsional)
            TextField(
              controller: descController,
              decoration: const InputDecoration(
                hintText: 'Catatan tambahan (opsional)',
              ),
            ),
            const SizedBox(height: 24),

            // Tombol Simpan
            ElevatedButton(
              onPressed: _isLoading ? null : _submitTransaction,
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text('Simpan Transaksi'),
            ),
          ],
        ),
      ),
    );
  }
}
