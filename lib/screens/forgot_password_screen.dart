import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/validators.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/loading_button.dart';

/// Halaman 2 — Lupa Password Screen.
///
/// StatefulWidget yang mengimplementasikan:
/// - Form input email dengan validasi format email
/// - Loading state saat tombol "Kirim Link Reset" ditekan
/// - Feedback visual via SnackBar/Dialog
/// - Navigasi kembali ke Login menggunakan Navigator.pop
/// - Layout: Column, Padding, SizedBox, SafeArea
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with SingleTickerProviderStateMixin {
  // GlobalKey untuk mengelola state Form
  final _formKey = GlobalKey<FormState>();

  // Controller untuk input email — dibersihkan di dispose
  late final TextEditingController _emailController;

  // Animation controller
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  // ============================================================
  // STATE MANAGEMENT
  // ============================================================
  bool _isLoading = false;
  bool _isEmailSent = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();

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
    _animationController.dispose();
    super.dispose();
  }

  /// Proses kirim link reset password.
  ///
  /// 1. Validasi form
  /// 2. Set isLoading = true
  /// 3. Simulasi kirim email (2 detik)
  /// 4. Tampilkan Dialog sukses
  Future<void> _handleSendResetLink() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulasi network call
    await Future.delayed(AppConstants.loadingDuration);

    if (!mounted) return;

    setState(() {
      _isLoading = false;
      _isEmailSent = true;
    });

    final email = _emailController.text.trim();

    // Tampilkan Dialog sukses
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              // Ikon sukses
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: AppConstants.successColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.mark_email_read_outlined,
                  size: 36,
                  color: AppConstants.successColor,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Email Terkirim!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Link reset password telah dikirim ke\n$email',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppConstants.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Silakan cek inbox atau folder spam Anda.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: AppConstants.textSecondary,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstants.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'Mengerti',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    // Tampilkan juga SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 12),
            Expanded(
              child: Text('Link reset telah dikirim ke email Anda'),
            ),
          ],
        ),
        backgroundColor: AppConstants.successColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: AppConstants.snackBarDuration,
      ),
    );
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
                      // HEADER
                      // ============================================================
                      _buildHeader(),
                      const SizedBox(height: 40),

                      // ============================================================
                      // FORM CARD
                      // ============================================================
                      _buildFormCard(),
                      const SizedBox(height: 24),

                      // ============================================================
                      // KEMBALI KE LOGIN
                      // ============================================================
                      _buildBackButton(),
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

  /// Header section — ikon dan teks instruksi
  Widget _buildHeader() {
    return Column(
      children: [
        // Ikon container
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF6B6B).withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(
            Icons.lock_reset_rounded,
            size: 40,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Lupa Password?',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppConstants.textPrimary,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Masukkan email Anda dan kami akan mengirimkan link untuk mereset password',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: AppConstants.textSecondary,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  /// Form card section
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
              hintText: 'Masukkan email terdaftar',
              controller: _emailController,
              validator: Validators.validateEmail,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              prefixIcon: const Icon(
                Icons.email_outlined,
                color: AppConstants.textSecondary,
                size: 20,
              ),
            ),
            const SizedBox(height: 24),

            // Status email terkirim
            if (_isEmailSent)
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: AppConstants.successColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppConstants.successColor.withValues(alpha: 0.3),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: AppConstants.successColor,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Link reset telah dikirim! Cek email Anda.',
                        style: TextStyle(
                          color: AppConstants.successColor,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // Tombol Kirim Link Reset
            LoadingButton(
              text: _isEmailSent ? 'Kirim Ulang' : 'Kirim Link Reset',
              isLoading: _isLoading,
              onPressed: _handleSendResetLink,
              icon: Icons.send_rounded,
            ),
          ],
        ),
      ),
    );
  }

  /// Tombol kembali ke login — menggunakan Navigator.pop
  Widget _buildBackButton() {
    return TextButton.icon(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(
        Icons.arrow_back_rounded,
        size: 18,
        color: AppConstants.primaryColor,
      ),
      label: const Text(
        'Kembali ke Login',
        style: TextStyle(
          color: AppConstants.primaryColor,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
    );
  }
}
