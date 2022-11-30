import 'package:http/http.dart' as http;
import 'package:operator_frog_client/src/internal/internal.dart';

/// {@template http_method}
/// The HTTP method for a request.
/// {@endtemplate}
class HttpMethod {
  /// {@macro http_method}
  const HttpMethod(this.name, this.baseUri, this._client);

  /// The name of the method.
  final http.Client _client;

  /// The base URL.
  final Uri baseUri;

  /// The name of the method.
  final String name;

  /// Creates a new request with the given [path].
  HttpRequest operator /(String path) {
    return HttpRequest(this, _client, baseUri.resolve(path));
  }
}
