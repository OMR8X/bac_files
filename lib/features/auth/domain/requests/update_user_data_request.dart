class UpdateUserDataRequest {
  final String? name;
  final String? email;
  final String? password;

  UpdateUserDataRequest({
    required this.name,
    required this.email,
    required this.password,
  });
  Map<String, dynamic> toBody() {
    return {
      "name": name,
      "email": email,
      "password": password,
    };
  }
}
