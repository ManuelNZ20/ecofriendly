class EmailErrors implements Exception {
  final String message;

  EmailErrors(this.message);
}
