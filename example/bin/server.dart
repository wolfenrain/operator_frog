import 'dart:io';

import 'package:example/example.dart';
import 'package:operator_frog_server/operator_frog_server.dart';

final withEchoDataSource =
    middleware >> provider<EchoDataSource>((_) => echoDataSource);
final echoDataSource = EchoDataSource();

// Register the routes for the example.
void main() => version | withEchoDataSource(listEchos | addEcho);

// Route for `GET /version`.
final version = get / 'version' >>
    (RequestContext context) => Response.json(body: {'version': '1.0.0'});

// Route for `GET /echos`.
final listEchos = get / 'echos' >>
    (RequestContext context) async {
      final contains = context.request.uri.queryParameters['contains'] ?? '';
      final echos = await context.read<EchoDataSource>().readAll();
      return Response.json(
        body: echos.where((e) => e.contains(contains)).toList(),
      );
    };

// Route for `POST /echos`.
final addEcho = post / 'echos' >>
    (RequestContext context) async {
      return Response.json(
        statusCode: HttpStatus.created,
        body: await context
            .read<EchoDataSource>()
            .add(await context.request.body()),
      );
    };
