class AuthResult {
  final bool success;
  final String message;
  final String? accessToken;

  AuthResult({
    required this.success,
    required this.message,
    this.accessToken,
  });
}
