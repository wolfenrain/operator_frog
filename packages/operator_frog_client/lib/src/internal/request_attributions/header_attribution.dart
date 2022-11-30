import 'package:operator_frog_client/src/internal/internal.dart';

/// {@template header_attribution}
/// A attribution for the headers of a request.
/// {@endtemplate}
class HeaderAttribution extends RequestAttribution<Map<String, String>> {
  /// {@macro header_attribution}
  const HeaderAttribution() : super('headers');

  const HeaderAttribution._(Map<String, String> data) : super('headers', data);

  @override
  RequestAttribution<Map<String, String>> operator >>(
    Map<String, String> data,
  ) {
    return HeaderAttribution._(data);
  }
}
