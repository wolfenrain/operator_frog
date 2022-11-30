import 'package:dart_frog/dart_frog.dart';
import 'package:operator_frog_server/src/internal/internal.dart';

class _Middleware {
  const _Middleware();

  MiddlewareHandler operator >>(Middleware middleware) {
    return MiddlewareHandler(middleware);
  }
}

/// Middleware constructor.
const middleware = _Middleware();
