import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:operator_frog_client/operator_frog_client.dart';
import 'package:operator_frog_client/src/internal/internal.dart';

/// {@template http_request}
/// The HTTP request.
/// {@endtemplate}
class HttpRequest implements Future<http.Response> {
  /// {@macro http_request}
  HttpRequest(this._method, this._client, this.uri);

  final HttpMethod _method;

  final http.Client _client;

  /// The URI of the request.
  final Uri uri;

  final List<RequestAttribution<dynamic>> _attributions = [];

  @override
  Stream<http.Response> asStream() => throw UnimplementedError();

  @override
  Future<http.Response> catchError(
    Function onError, {
    bool Function(Object error)? test,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<R> then<R>(
    FutureOr<R> Function(http.Response value) onValue, {
    Function? onError,
  }) async {
    final queryParameters = <String, String>{
      ...uri.queryParameters,
      for (final query in _attributions.whereType<QueryAttribution>())
        for (final pair in query.data!.entries) pair.key: pair.value,
    };

    final requestUri = Uri(
      scheme: uri.scheme,
      userInfo: uri.userInfo,
      host: uri.host,
      port: uri.port,
      path: uri.path,
      query: Uri(queryParameters: queryParameters).query,
      fragment: uri.fragment,
    );

    final request = http.Request(_method.name, requestUri);
    request.headers.addAll({
      for (final header in _attributions.whereType<HeaderAttribution>())
        for (final pair in header.data!.entries) pair.key: pair.value,
    });

    final data = (_attributions.firstWhere(
      (e) => e is BodyAttribution,
      orElse: () => body,
    )).data;

    if (data != null) {
      if (data is String) {
        request.body = data;
      } else if (data is Map || data is List) {
        request.body = jsonEncode(data);
      } else {
        throw ArgumentError.value(data, 'data');
      }
    }

    return onValue(await http.Response.fromStream(await _client.send(request)));
  }

  @override
  Future<http.Response> timeout(
    Duration timeLimit, {
    FutureOr<http.Response> Function()? onTimeout,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<http.Response> whenComplete(FutureOr<void> Function() action) {
    throw UnimplementedError();
  }

  /// Add an attribution to the request.
  HttpRequest operator &(RequestAttribution<dynamic> value) {
    _attributions.add(value);
    return this;
  }
}
