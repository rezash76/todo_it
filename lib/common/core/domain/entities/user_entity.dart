abstract base class UserEntity {
  final String name;
  final String family;
  final String username;
  final String password;
  bool isLogin;

  UserEntity(
    this.name,
    this.family,
    this.username,
    this.password,
    this.isLogin,
  );
}
