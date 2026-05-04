/// Model data user yang digunakan dalam aplikasi.
///
/// Menyimpan informasi email dan nama user setelah login berhasil.
class UserModel {
  final String email;
  final String name;

  const UserModel({
    required this.email,
    required this.name,
  });

  @override
  String toString() => 'UserModel(email: $email, name: $name)';
}
