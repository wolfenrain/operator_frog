import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:operator_frog_server/src/internal/internal.dart';

/// {@template operator_handler}
/// The core handler for the operator frog server.
/// {@endtemplate}
class OperatorHandler {
  /// {@macro operator_handler}
  OperatorHandler() {
    _root ??= this;
  }

  /// The siblings of this handler.
  List<OperatorHandler> siblings = [];

  /// Add a sibling to this handler.
  OperatorHandler operator |(OperatorHandler handler) {
    _serveTimer?.cancel();
    _serveTimer = Timer(const Duration(milliseconds: 1), _serve);

    siblings.add(handler);

    return this;
  }
}

Timer? _serveTimer;
OperatorHandler? _root;

Future<void> _serve() async {
  final router = Router();
  const pipeline = Pipeline();
  var cascade = _addHandler(_root!, Cascade(), router: router);
  cascade = cascade.add(pipeline.addHandler(router));

  await serve(cascade.handler, InternetAddress.anyIPv4, 8080);
  stdout.writeln('Listening on localhost:8080');
}

Cascade _addHandler(
  OperatorHandler handler,
  Cascade cascade, {
  required Router router,
  int indent = 0,
}) {
  final indenting = '  ' * indent;
  var result = cascade;

  if (handler is RequestHandler) {
    stdout.writeln(
      '${indenting}route ${handler.method.name} / ${handler.path}',
    );
    router.add(handler.method.name, '/${handler.path}', handler.handler);
  }

  if (handler is MiddlewareHandler) {
    stdout.writeln('${indenting}middleware');

    final middlewareRouter = Router();
    final pipeline = const Pipeline().addMiddleware(handler.middleware);

    result = _addHandler(
      handler.child,
      result,
      router: middlewareRouter,
      indent: indent + 1,
    );
    result = result.add(pipeline.addHandler(middlewareRouter));
  }

  for (final sibling in handler.siblings) {
    result = _addHandler(sibling, result, indent: indent, router: router);
  }

  return result;
}
