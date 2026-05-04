import 'package:flutter/material.dart';

/// Konstanta yang digunakan di seluruh aplikasi.
///
/// Berisi definisi warna tema, mock credentials untuk login,
/// dan konfigurasi lainnya.

class AppConstants {
  // ============================================================
  // MOCK CREDENTIALS (untuk keperluan ujian)
  // ============================================================
  static const String mockEmail = 'admin@test.com';
  static const String mockPassword = 'Admin123';
  static const String mockUserName = 'Admin';

  // ============================================================
  // ROUTE NAMES
  // ============================================================
  static const String loginRoute = '/login';
  static const String forgotPasswordRoute = '/forgot-password';
  static const String dashboardRoute = '/dashboard';

  // ============================================================
  // WARNA TEMA APLIKASI
  // ============================================================
  static const Color primaryColor = Color(0xFF6C63FF);
  static const Color primaryDark = Color(0xFF4A42D1);
  static const Color primaryLight = Color(0xFF8B83FF);
  static const Color accentColor = Color(0xFF00D2FF);
  static const Color backgroundColor = Color(0xFFF5F7FF);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color errorColor = Color(0xFFFF5252);
  static const Color successColor = Color(0xFF4CAF50);
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color cardShadowColor = Color(0x1A6C63FF);

  // Gradient untuk background dan tombol
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryColor, accentColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [Color(0xFFF5F7FF), Color(0xFFE8ECFF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // ============================================================
  // DURASI ANIMASI
  // ============================================================
  static const Duration loadingDuration = Duration(seconds: 2);
  static const Duration snackBarDuration = Duration(seconds: 3);

  // ============================================================
  // DUMMY DATA DASHBOARD
  // ============================================================
  static const List<Map<String, dynamic>> dashboardItems = [
    {'icon': Icons.account_balance_wallet, 'title': 'Saldo Digital', 'subtitle': 'Rp 2.500.000', 'color': Color(0xFF6C63FF)},
    {'icon': Icons.shopping_bag, 'title': 'Belanja Online', 'subtitle': '12 transaksi bulan ini', 'color': Color(0xFF00D2FF)},
    {'icon': Icons.receipt_long, 'title': 'Tagihan', 'subtitle': '3 tagihan belum dibayar', 'color': Color(0xFFFF6B6B)},
    {'icon': Icons.trending_up, 'title': 'Investasi', 'subtitle': '+5.2% bulan ini', 'color': Color(0xFF4CAF50)},
    {'icon': Icons.credit_card, 'title': 'Kartu Virtual', 'subtitle': '2 kartu aktif', 'color': Color(0xFFFF9800)},
    {'icon': Icons.local_offer, 'title': 'Promo & Diskon', 'subtitle': '8 promo tersedia', 'color': Color(0xFFE91E63)},
    {'icon': Icons.history, 'title': 'Riwayat Transaksi', 'subtitle': 'Lihat semua riwayat', 'color': Color(0xFF9C27B0)},
    {'icon': Icons.notifications_active, 'title': 'Notifikasi', 'subtitle': '5 notifikasi baru', 'color': Color(0xFF00BCD4)},
    {'icon': Icons.settings, 'title': 'Pengaturan', 'subtitle': 'Kelola akun Anda', 'color': Color(0xFF607D8B)},
    {'icon': Icons.help_outline, 'title': 'Bantuan', 'subtitle': 'FAQ & Customer Service', 'color': Color(0xFF795548)},
    {'icon': Icons.security, 'title': 'Keamanan', 'subtitle': 'Verifikasi 2 langkah aktif', 'color': Color(0xFF3F51B5)},
    {'icon': Icons.star, 'title': 'Rewards', 'subtitle': '1.250 poin terkumpul', 'color': Color(0xFFFFC107)},
  ];
}
