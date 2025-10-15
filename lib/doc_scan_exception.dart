/// Exception thrown when the document scanning fails.
class DocScanException implements Exception {
  /// Creates a [DocScanException] with the given message.
  DocScanException(this.message);

  /// The error message.
  final String message;

  @override
  String toString() => 'DocumentScannerException: $message';
}
