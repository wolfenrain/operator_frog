import 'package:dart_frog/dart_frog.dart';
import 'package:operator_frog_server/src/internal/internal.dart';

/// {@template request_handler}
/// A handler for a request.
/// {@endtemplate}
class RequestHandler extends OperatorHandler {
  /// {@macro request_handler}
  RequestHandler(this.method, this.path);

  /// The HTTP method.
  final HttpMethod method;

  /// The path.
  late final String path;

  /// The true handler.
  late final Function handler;

  /// Add a true handler to this handler.
  RequestHandler operator >>(Function handler) => this..handler = handler;
}
