class EmailApi {
  final String fromEmail;
  final String toEmail;
  final String subject;
  final String html;

  EmailApi({
    required this.fromEmail,
    required this.toEmail,
    required this.subject,
    required this.html,
  });
}
