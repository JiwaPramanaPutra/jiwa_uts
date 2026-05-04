import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../utils/constants.dart';
import '../utils/validators.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/loading_button.dart';

/// Halaman 1 — Login Screen.
///
/// StatefulWidget yang mengimplementasikan:
/// - Form login dengan validasi email dan password
/// - State management: isLoading, errorMessage, isPasswordVisible
/// - Navigasi ke Lupa Password dan Dashboard
/// - Mock login dengan hardcoded credential
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  // GlobalKey untuk mengelola state Form
  final _formKey = GlobalKey<FormState>();

  // Controller untuk input field — dibuat di initState, dibersihkan di dispose
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  // Animation controller untuk efek visual
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  // ============================================================
  // STATE MANAGEMENT
  // ============================================================
  bool _isLoading = false;
  String? _errorMessage;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    // Setup animasi masuk
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    // Membersihkan resource untuk mencegah memory leak
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  /// Proses login.
  ///
  /// 1. Validasi form menggunakan GlobalKey dan FormState
  /// 2. Set isLoading = true
  /// 3. Simulasi delay network call (2 detik)
  /// 4. Cek credential mock
  /// 5. Navigate ke Dashboard jika sukses, atau tampilkan error
  Future<void> _handleLogin() async {
    // Hilangkan error message sebelumnya
    setState(() {
      _errorMessage = null;
    });

    // Validasi form — memanggil validator pada setiap TextFormField
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Set loading state
    setState(() {
      _isLoading = true;
    });

    // Simulasi network call
    await Future.delayed(AppConstants.loadingDuration);

    // Cek apakah widget masih mounted setelah async operation
    if (!mounted) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    // Verifikasi credential mock
    if (email == AppConstants.mockEmail &&
        password == AppConstants.mockPassword) {
      // Login berhasil
      setState(() {
        _isLoading = false;
        _errorMessage = null;
      });

      // Tampilkan SnackBar sukses
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 12),
              Text('Login berhasil! Selamat datang.'),
            ],
          ),
          backgroundColor: AppConstants.successColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          duration: AppConstants.snackBarDuration,
        ),
      );

      // Buat data user dari credential yang berhasil login
      final user = UserModel(
        email: email,
        name: AppConstants.mockUserName,
      );

      // Navigasi ke Dashboard menggunakan named route
      // pushReplacementNamed agar user tidak bisa kembali ke login via back button
      Navigator.pushReplacementNamed(
        context,
        AppConstants.dashboardRoute,
        arguments: user,
      );
    } else {
      // Login gagal — set error message
      setState(() {
        _isLoading = false;
        _errorMessage = 'Email atau password salah. Silakan coba lagi.';
      });

      // Tampilkan SnackBar error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(child: Text(_errorMessage!)),
            ],
          ),
          backgroundColor: AppConstants.errorColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          duration: AppConstants.snackBarDuration,
        ),
      );
    }
  }

  /// Toggle visibilitas password
  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppConstants.backgroundGradient,
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ============================================================
                      // LOGO & HEADER
                      // ============================================================
                      _buildHeader(),
                      const SizedBox(height: 40),

                      // ============================================================
                      // FORM CARD
                      // ============================================================
                      _buildFormCard(),
                      const SizedBox(height: 24),

                      // ============================================================
                      // FOOTER
                      // ============================================================
                      _buildFooter(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Header section — logo dan teks selamat datang
  Widget _buildHeader() {
    return Column(
      children: [
        // Logo container dengan gradient
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: AppConstants.primaryGradient,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppConstants.primaryColor.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(
            Icons.lock_outline_rounded,
            size: 40,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Selamat Datang!',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppConstants.textPrimary,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Masuk ke akun Anda untuk melanjutkan',
          style: TextStyle(
            fontSize: 15,
            color: AppConstants.textSecondary,
          ),
        ),
      ],
    );
  }

  /// Form card section — berisi input fields dan tombol
  Widget _buildFormCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppConstants.surfaceColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppConstants.cardShadowColor,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Email field
            CustomTextField(
              label: 'Email',
              hintText: 'Masukkan email Anda',
              controller: _emailController,
              validator: Validators.validateEmail,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: const Icon(
                Icons.email_outlined,
                color: AppConstants.textSecondary,
                size: 20,
              ),
            ),
            const SizedBox(height: 20),

            // Password field dengan toggle visibility
            CustomTextField(
              label: 'Password',
              hintText: 'Masukkan password Anda',
              controller: _passwordController,
              validator: Validators.validatePassword,
              obscureText: !_isPasswordVisible,
              textInputAction: TextInputAction.done,
              prefixIcon: const Icon(
                Icons.lock_outline,
                color: AppConstants.textSecondary,
                size: 20,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppConstants.textSecondary,
                  size: 20,
                ),
                onPressed: _togglePasswordVisibility,
              ),
            ),
            const SizedBox(height: 12),

            // Link Lupa Password — navigasi ke Halaman 2
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppConstants.forgotPasswordRoute,
                  );
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                ),
                child: const Text(
                  'Lupa Password?',
                  style: TextStyle(
                    color: AppConstants.primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Error message display
            if (_errorMessage != null)
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: AppConstants.errorColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppConstants.errorColor.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.warning_amber_rounded,
                      color: AppConstants.errorColor,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(
                          color: AppConstants.errorColor,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // Tombol Login dengan loading indicator
            LoadingButton(
              text: 'Masuk',
              isLoading: _isLoading,
              onPressed: _handleLogin,
              icon: Icons.login_rounded,
            ),
          ],
        ),
      ),
    );
  }

  /// Footer section — info tambahan
  Widget _buildFooter() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 1,
              color: AppConstants.textSecondary.withValues(alpha: 0.3),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Demo Credential',
                style: TextStyle(
                  color: AppConstants.textSecondary,
                  fontSize: 12,
                ),
              ),
            ),
            Container(
              width: 40,
              height: 1,
              color: AppConstants.textSecondary.withValues(alpha: 0.3),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: AppConstants.primaryColor.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'admin@test.com  /  Admin123',
            style: TextStyle(
              color: AppConstants.primaryColor,
              fontSize: 13,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    );
  }
}
