import 'dart:io';

import 'package:operator_frog_client/operator_frog_client.dart';

void main() async {
  // Set up the client.
  final client = http > 'http://localhost:8080';

  // Make a request to the echo route.
  final echo = await (client.post / 'echos' & body >> 'Hello, World!');
  stdout.writeln(echo.body);

  // Get all echos.
  final echos = await (client.get / 'echos' &
      headers >> {'Content-Type': 'application/json'} &
      query >> {'contains': 'Hello'});

  // Print the response body.
  stdout.writeln(echos.body);

  // Close the client.
  client.close();
}
