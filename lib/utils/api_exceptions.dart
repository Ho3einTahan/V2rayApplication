class ApiException implements Exception {
  int? code;
  String? message;

  ApiException({required this.message, required this.code});
}
