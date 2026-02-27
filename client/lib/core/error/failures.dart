class Failure {
  final String message;    // "Email déjà utilisé"
  final String statusCode; // "409"
  final String code;       // "AUTH_EMAIL_TAKEN" (The "Machine Key")

  const Failure({
    required this.message,
    this.statusCode = '',
    this.code = '',
  });
}