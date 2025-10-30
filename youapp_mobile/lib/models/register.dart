/// Registration request model for user registration
class RegisterRequest {
  final String email;
  final String username;
  final String password;

  const RegisterRequest({
    required this.email,
    required this.username,
    required this.password,
  });

  /// Converts RegisterRequest to JSON for API calls
  Map<String, dynamic> toJson() => {
        'email': email,
        'username': username,
        'password': password,
      };

  /// Creates a copy of RegisterRequest with optional new values
  RegisterRequest copyWith({
    String? email,
    String? username,
    String? password,
  }) {
    return RegisterRequest(
      email: email ?? this.email,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  String toString() {
    return 'RegisterRequest(email: $email, username: $username, password: [HIDDEN])';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RegisterRequest &&
        other.email == email &&
        other.username == username &&
        other.password == password;
  }

  @override
  int get hashCode {
    return email.hashCode ^ username.hashCode ^ password.hashCode;
  }
}
