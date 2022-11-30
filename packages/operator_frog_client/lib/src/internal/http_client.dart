import 'package:http/http.dart' as http;
import 'package:operator_frog_client/src/internal/internal.dart';

/// {@template http_client}
/// The HTTP client.
/// {@endtemplate}
class HttpClient {
  /// {@macro http_client}
  HttpClient(this.baseUrl) : _client = http.Client();

  final http.Client _client;

  /// The base URL.
  final Uri baseUrl;

  /// The HTTP GET method.
  HttpMethod get get => HttpMethod('get', baseUrl, _client);

  /// The HTTP POST method.
  HttpMethod get post => HttpMethod('post', baseUrl, _client);

  /// The HTTP PUT method.
  HttpMethod get put => HttpMethod('put', baseUrl, _client);

  /// The HTTP PATCH method.
  HttpMethod get patch => HttpMethod('patch', baseUrl, _client);

  /// The HTTP DELETE method.
  HttpMethod get delete => HttpMethod('delete', baseUrl, _client);

  /// The HTTP HEAD method.
  HttpMethod get head => HttpMethod('head', baseUrl, _client);

  /// The HTTP OPTIONS method.
  HttpMethod get options => HttpMethod('options', baseUrl, _client);

  /// Closes the client.
  void close() => _client.close();
}
