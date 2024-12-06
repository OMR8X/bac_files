class SignUpRequest {
  final String name;
  final String email;
  final String password;
  final bool keepLoggedIn;

  SignUpRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.keepLoggedIn,
  });

  Map<String, dynamic> toBody() {
    return {
      "name": name,
      "email": email,
      "password": password,
    };
  }
}
