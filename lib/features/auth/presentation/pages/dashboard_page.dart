import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_colors.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengatur status bar menjadi terang karena header kita akan berwarna hijau/primary
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: AppColors.background, // Latar belakang abu-abu sangat muda/putih
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. HEADER & KARTU SALDO (Bagian Atas Melengkung)
            _buildHeaderAndBalanceCard(context),
            
            const SizedBox(height: 24),
            
            // 2. QUICK ACTIONS (Aksi Cepat)
            _buildQuickActions(),
            
            const SizedBox(height: 32),
            
            // 3. TRANSAKSI TERAKHIR
            _buildRecentTransactions(),
          ],
        ),
      ),
      // TODO: Kita akan menambahkan BottomNavigationBar di langkah selanjutnya
    );
  }

  // --- WIDGET PEMBANTU ---

  Widget _buildHeaderAndBalanceCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 32),
      decoration: const BoxDecoration(
        color: AppColors.primary, // Warna hijau utama Finansia
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          // Header Profil
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Selamat Pagi,",
                    style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Budi Santoso", // Nama Statis Sementara
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.2),
                  image: const DecorationImage(
                    image: NetworkImage('https://ui-avatars.com/api/?name=Budi+Santoso&background=random'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          
          // Kartu Saldo
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Total Saldo", style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
                const SizedBox(height: 8),
                const Text(
                  "Rp 12.500.000",
                  style: TextStyle(color: AppColors.neutral900, fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                const Divider(color: AppColors.neutral200),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildIncomeExpenseInfo(isIncome: true, amount: "Rp 5.200.000"),
                    Container(height: 40, width: 1, color: AppColors.neutral200),
                    _buildIncomeExpenseInfo(isIncome: false, amount: "Rp 1.450.000"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncomeExpenseInfo({required bool isIncome, required String amount}) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isIncome ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isIncome ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded,
            color: isIncome ? Colors.green : Colors.red,
            size: 16,
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(isIncome ? "Pemasukan" : "Pengeluaran", style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            const SizedBox(height: 4),
            Text(amount, style: const TextStyle(color: AppColors.neutral900, fontWeight: FontWeight.w700, fontSize: 14)),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildActionItem(icon: Icons.download_rounded, label: "Pemasukan", color: Colors.green),
          _buildActionItem(icon: Icons.upload_rounded, label: "Pengeluaran", color: Colors.red),
          _buildActionItem(icon: Icons.swap_horiz_rounded, label: "Transfer", color: Colors.blue),
          _buildActionItem(icon: Icons.account_balance_wallet_rounded, label: "Dompet", color: Colors.purple),
        ],
      ),
    );
  }

  Widget _buildActionItem({required IconData icon, required String label, required Color color}) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: AppColors.neutral700, fontSize: 12, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildRecentTransactions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Transaksi Terakhir", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.neutral900)),
              TextButton(onPressed: () {}, child: const Text("Lihat Semua")),
            ],
          ),
          const SizedBox(height: 16),
          
          // List Transaksi Statis
          _buildTransactionItem(title: "Makan Siang", category: "Makanan & Minuman", amount: "- Rp 45.000", isIncome: false, icon: Icons.restaurant),
          _buildTransactionItem(title: "Gaji Bulanan", category: "Pendapatan", amount: "+ Rp 8.000.000", isIncome: true, icon: Icons.work),
          _buildTransactionItem(title: "Netflix", category: "Hiburan", amount: "- Rp 153.000", isIncome: false, icon: Icons.movie),
          _buildTransactionItem(title: "Beli Kopi", category: "Makanan & Minuman", amount: "- Rp 25.000", isIncome: false, icon: Icons.local_cafe),
          const SizedBox(height: 40), // Spasi ekstra di bawah
        ],
      ),
    );
  }

  Widget _buildTransactionItem({required String title, required String category, required String amount, required bool isIncome, required IconData icon}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.neutral100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.neutral700),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.neutral900)),
                const SizedBox(height: 4),
                Text(category, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: isIncome ? Colors.green : AppColors.neutral900,
            ),
          ),
        ],
      ),
    );
  }
}
