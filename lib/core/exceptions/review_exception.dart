class ReviewException implements Exception {
  final String message;
  final dynamic cause;

  ReviewException(this.message, [this.cause]);

  @override
  String toString() => 'ReviewException: $message ${cause != null ? cause.toString() : ""}';
}

