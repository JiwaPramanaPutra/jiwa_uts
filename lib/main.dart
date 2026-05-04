import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/dashboard_screen.dart';
import 'utils/constants.dart';

/// Entry point aplikasi Flutter UTS.
///
/// MaterialApp dikonfigurasi dengan:
/// - Named routes untuk navigasi antar halaman
/// - Theme modern dengan warna primary indigo/ungu
/// - 3 route terdaftar: /login, /forgot-password, /dashboard
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jiwa UTS App',
      debugShowCheckedModeBanner: false,

      // ============================================================
      // THEME CONFIGURATION
      // ============================================================
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppConstants.primaryColor,
          primary: AppConstants.primaryColor,
          error: AppConstants.errorColor,
        ),
        scaffoldBackgroundColor: AppConstants.backgroundColor,
        fontFamily: 'Roboto',
        useMaterial3: true,

        // AppBar theme
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppConstants.primaryColor,
          foregroundColor: Colors.white,
        ),

        // ElevatedButton theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          ),
        ),

        // Card theme
        cardTheme: CardThemeData(
          elevation: 2,
          shadowColor: AppConstants.cardShadowColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),

        // SnackBar theme
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),

      // ============================================================
      // NAVIGATION — NAMED ROUTES
      // ============================================================
      initialRoute: AppConstants.loginRoute,
      routes: {
        AppConstants.loginRoute: (context) => const LoginScreen(),
        AppConstants.forgotPasswordRoute: (context) =>
            const ForgotPasswordScreen(),
        AppConstants.dashboardRoute: (context) => const DashboardScreen(),
      },
    );
  }
}
