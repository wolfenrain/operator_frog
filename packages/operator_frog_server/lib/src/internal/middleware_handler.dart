import 'package:dart_frog/dart_frog.dart';
import 'package:operator_frog_server/src/internal/internal.dart';

/// {@template middleware_handler}
/// Handler for a middleware.
/// {@endtemplate}
class MiddlewareHandler extends OperatorHandler {
  /// {@macro middleware_handler}
  MiddlewareHandler(this.middleware);

  /// The middleware.
  final Middleware middleware;

  /// The direct child of this handler.
  late final OperatorHandler child;

  /// Add a child to this handler.
  OperatorHandler call(OperatorHandler handler) => this..child = handler;
}
