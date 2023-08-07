base class SignupRequest {
  const SignupRequest({
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.password,
  });

  final String firstname;
  final String lastname;
  final String username;
  final String password;
}
