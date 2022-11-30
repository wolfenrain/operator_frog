/// {@template request_attribution}
/// An attribution for a request.
/// {@endtemplate}
abstract class RequestAttribution<T> {
  /// {@macro request_attribution}
  const RequestAttribution(this.type, [this.data]);

  /// The type of the attribution.
  final String type;

  /// The data of the attribution.
  final T? data;

  /// Returns a new attribution with the given [data].
  RequestAttribution<T> operator >>(T data);
}
