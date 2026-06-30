import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_colors.dart';

class QuickActionData {
  final String id;
  final IconData icon;
  final String label;
  final Color color;

  QuickActionData({
    required this.id,
    required this.icon,
    required this.label,
    required this.color,
  });
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool _isExpanded = false;

  final List<QuickActionData> _actions = [
    QuickActionData(
        id: '1',
        icon: Icons.download_rounded,
        label: "Pemasukan",
        color: Colors.green),
    QuickActionData(
        id: '2',
        icon: Icons.upload_rounded,
        label: "Pengeluaran",
        color: Colors.red),
    QuickActionData(
        id: '3',
        icon: Icons.swap_horiz_rounded,
        label: "Transfer",
        color: Colors.blue),
    QuickActionData(
        id: '4',
        icon: Icons.account_balance_wallet_rounded,
        label: "Dompet",
        color: Colors.purple),
    QuickActionData(
        id: '5',
        icon: Icons.pie_chart_outline_rounded,
        label: "Budget",
        color: Colors.orange),
    QuickActionData(
        id: '6',
        icon: Icons.bar_chart_rounded,
        label: "Laporan",
        color: Colors.teal),
    QuickActionData(
        id: '7',
        icon: Icons.receipt_long_rounded,
        label: "Tagihan",
        color: Colors.amber),
    QuickActionData(
        id: '8',
        icon: Icons.document_scanner_rounded,
        label: "AI Scan",
        color: Colors.indigo),
  ];

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      final item = _actions.removeAt(oldIndex);
      _actions.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    // ✅ FIX: Menggunakan AnnotatedRegion alih-alih SystemChrome langsung di build()
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderAndBalanceCard(context),
              const SizedBox(height: 24),
              _buildQuickActionsSection(),
              const SizedBox(height: 32),
              _buildRecentTransactions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderAndBalanceCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 32),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ✅ FIX: withOpacity -> withValues(alpha: ...)
                  Text("Selamat Pagi,",
                      style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 14)),
                  const SizedBox(height: 4),
                  const Text("Budi Santoso",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
                child: ClipOval(
                  child: SvgPicture.asset('assets/images/avatar_male.svg',
                      fit: BoxFit.cover),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                // ✅ FIX: withOpacity -> withValues(alpha: ...)
                BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 10)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Total Saldo",
                    style: TextStyle(
                        color: AppColors.textSecondary, fontSize: 14)),
                const SizedBox(height: 8),
                const Text("Rp 12.500.000",
                    style: TextStyle(
                        color: AppColors.neutral900,
                        fontSize: 28,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 24),
                const Divider(color: AppColors.neutral200),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildIncomeExpenseInfo(
                        isIncome: true, amount: "Rp 5.200.000"),
                    Container(
                        height: 40, width: 1, color: AppColors.neutral200),
                    _buildIncomeExpenseInfo(
                        isIncome: false, amount: "Rp 1.450.000"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncomeExpenseInfo(
      {required bool isIncome, required String amount}) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            // ✅ FIX: withOpacity -> withValues(alpha: ...)
            color: isIncome
                ? Colors.green.withValues(alpha: 0.1)
                : Colors.red.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isIncome
                ? Icons.arrow_downward_rounded
                : Icons.arrow_upward_rounded,
            color: isIncome ? Colors.green : Colors.red,
            size: 16,
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(isIncome ? "Pemasukan" : "Pengeluaran",
                style: const TextStyle(
                    color: AppColors.textSecondary, fontSize: 12)),
            const SizedBox(height: 4),
            Text(amount,
                style: const TextStyle(
                    color: AppColors.neutral900,
                    fontWeight: FontWeight.w700,
                    fontSize: 14)),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActionsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Aksi Cepat",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.neutral900)),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    child: _isExpanded
                        ? const Text("Tekan lama dan geser untuk memindahkan",
                            style: TextStyle(
                                fontSize: 11, color: AppColors.textSecondary))
                        : const SizedBox.shrink(),
                  )
                ],
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Text(
                  _isExpanded ? "Tutup" : "Lihat Semua",
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AnimatedSize(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
            child: GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.8,
                mainAxisSpacing: 16,
                crossAxisSpacing: 8,
              ),
              itemCount: _isExpanded ? _actions.length : 4,
              itemBuilder: (context, index) {
                return _buildDraggableActionItem(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDraggableActionItem(int index) {
    final item = _actions[index];

    return DragTarget<int>(
      onWillAcceptWithDetails: (details) => true,
      onAcceptWithDetails: (details) => _onReorder(details.data, index),
      builder: (context, candidateData, rejectedData) {
        final isHovered = candidateData.isNotEmpty;

        return LongPressDraggable<int>(
          data: index,
          feedback: Material(
            color: Colors.transparent,
            child: Transform.scale(
              scale: 1.1,
              child: _buildActionIcon(item, isHovered: true),
            ),
          ),
          childWhenDragging: Opacity(
            opacity: 0.3,
            child: _buildActionIcon(item, isHovered: false),
          ),
          child: _buildActionIcon(item, isHovered: isHovered),
        );
      },
    );
  }

  Widget _buildActionIcon(QuickActionData item, {required bool isHovered}) {
    return Container(
      decoration: BoxDecoration(
        color: isHovered ? AppColors.neutral200 : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              // ✅ FIX: withOpacity -> withValues(alpha: ...)
              color: item.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(item.icon, color: item.color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            item.label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: AppColors.neutral700,
                fontSize: 11,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
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
              const Text("Transaksi Terakhir",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.neutral900)),
              TextButton(
                  onPressed: () {},
                  child: const Text("Lihat Semua",
                      style: TextStyle(fontWeight: FontWeight.w600))),
            ],
          ),
          const SizedBox(height: 16),
          _buildTransactionItem(
              title: "Makan Siang",
              category: "Makanan & Minuman",
              amount: "- Rp 45.000",
              isIncome: false,
              icon: Icons.restaurant_rounded),
          _buildTransactionItem(
              title: "Gaji Bulanan",
              category: "Pendapatan",
              amount: "+ Rp 8.000.000",
              isIncome: true,
              icon: Icons.work_rounded),
          _buildTransactionItem(
              title: "Netflix",
              category: "Hiburan",
              amount: "- Rp 153.000",
              isIncome: false,
              icon: Icons.movie_rounded),
          _buildTransactionItem(
              title: "Beli Kopi",
              category: "Makanan & Minuman",
              amount: "- Rp 25.000",
              isIncome: false,
              icon: Icons.local_cafe_rounded),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(
      {required String title,
      required String category,
      required String amount,
      required bool isIncome,
      required IconData icon}) {
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
                borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: AppColors.neutral700),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.neutral900)),
                const SizedBox(height: 4),
                Text(category,
                    style: const TextStyle(
                        color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          Text(amount,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: isIncome ? Colors.green : AppColors.neutral900)),
        ],
      ),
    );
  }
}
