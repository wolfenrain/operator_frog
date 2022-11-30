import 'dart:io';

import 'package:operator_frog_client/operator_frog_client.dart';

void main() async {
  final client = http > 'http://localhost:8080';

  await (client.post / 'todos' &
      json >>
          {
            'title': 'Hello World',
            'description': 'This is a description',
            'isCompleted': false,
          });

  final response = await (client.get / 'todos' &
      query >> {'isCompleted': 'true'} &
      headers >> {'Content-Type': 'application/json'});

  stdout.writeln(response.body);

  client.close();
}
