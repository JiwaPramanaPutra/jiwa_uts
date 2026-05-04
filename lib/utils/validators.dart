/// Kumpulan fungsi validasi untuk form input.
///
/// Digunakan pada halaman Login dan Lupa Password
/// bersama dengan Form + GlobalKey<FormState>.

class Validators {
  // Regex pattern untuk validasi format email
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  // Regex pattern untuk mengecek apakah mengandung huruf
  static final RegExp _hasLetter = RegExp(r'[a-zA-Z]');

  // Regex pattern untuk mengecek apakah mengandung angka
  static final RegExp _hasDigit = RegExp(r'[0-9]');

  /// Validasi input email.
  ///
  /// Mengembalikan pesan error jika:
  /// - Field kosong
  /// - Format email tidak valid
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email tidak boleh kosong';
    }
    if (!_emailRegex.hasMatch(value.trim())) {
      return 'Format email tidak valid';
    }
    return null;
  }

  /// Validasi input password.
  ///
  /// Mengembalikan pesan error jika:
  /// - Field kosong
  /// - Kurang dari 8 karakter
  /// - Tidak mengandung huruf
  /// - Tidak mengandung angka
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (value.length < 8) {
      return 'Password minimal 8 karakter';
    }
    if (!_hasLetter.hasMatch(value)) {
      return 'Password harus mengandung huruf';
    }
    if (!_hasDigit.hasMatch(value)) {
      return 'Password harus mengandung angka';
    }
    return null;
  }
}
