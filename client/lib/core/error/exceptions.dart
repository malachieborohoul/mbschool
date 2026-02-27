class ServerException implements Exception {
  final String message;
  final String? statusCode;
  final String? code;

  ServerException({
    required this.message, 
    this.statusCode, 
    this.code,
  });

  @override
  String toString() => 'ServerException(code: $code, message: $message)';
}