import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import 'dashboard_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardPage(),
    const Scaffold(
        body: Center(
            child: Text("Halaman Transaksi",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))),
    const Scaffold(
        body: Center(
            child: Text("Halaman Laporan",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))),
    const Scaffold(
        body: Center(
            child: Text("Halaman Profil",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              // ✅ FIX: Menggunakan withValues(alpha: ...) menggantikan withOpacity()
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 0,
            currentIndex: _selectedIndex,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.neutral400,
            selectedLabelStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            unselectedLabelStyle:
                const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
            onTap: _onItemTapped,
            items: const [
              BottomNavigationBarItem(
                icon: Padding(
                    padding: EdgeInsets.only(bottom: 4.0),
                    child: Icon(Icons.home_rounded)),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                    padding: EdgeInsets.only(bottom: 4.0),
                    child: Icon(Icons.swap_horiz_rounded)),
                label: 'Transaksi',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                    padding: EdgeInsets.only(bottom: 4.0),
                    child: Icon(Icons.pie_chart_rounded)),
                label: 'Laporan',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                    padding: EdgeInsets.only(bottom: 4.0),
                    child: Icon(Icons.person_rounded)),
                label: 'Profil',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
