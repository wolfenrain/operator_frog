/// A thought experiment on writing a strange API for Dart.
library operator_frog_client;

import 'package:operator_frog_client/src/internal/internal.dart';

export 'src/http.dart';

/// Body attribution of the type String.
const body = BodyAttribution<String>();

/// Body attribution of the type Map<String, String>.
const json = BodyAttribution<Map<String, dynamic>>();

/// Query attribution.
const query = QueryAttribution();

/// Header attribution.
const headers = HeaderAttribution();
