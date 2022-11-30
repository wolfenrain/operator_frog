import 'package:operator_frog_client/src/internal/internal.dart';

/// {@template query_attribution}
/// A attribution for the query of a request.
/// {@endtemplate}
class QueryAttribution extends RequestAttribution<Map<String, String>> {
  /// {@macro query_attribution}
  const QueryAttribution() : super('query');

  const QueryAttribution._(Map<String, String> data) : super('query', data);

  @override
  RequestAttribution<Map<String, String>> operator >>(
    Map<String, String> data,
  ) {
    return QueryAttribution._(data);
  }
}
