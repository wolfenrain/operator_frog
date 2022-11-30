import 'package:operator_frog_server/operator_frog_server.dart';

final withRequestLogger = middleware >> requestLogger();

void main() => version | withRequestLogger(health);

final version = get / 'version' >>
    (RequestContext context) => Response.json(body: {'version': '1.0.0'});

final health = get / 'health' >>
    (RequestContext context) => Response.json(body: {'status': 'ok'});
