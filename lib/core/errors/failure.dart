/// Represents a failure with an associated message.
///
/// This class is used to encapsulate error messages
/// in the application
class Failure {
  const Failure(this.message);

  /// The [message] parameter describes the error that occurred.
  final String message;

  @override
  String toString() => message;
}
