import 'package:operator_frog_client/src/internal/internal.dart';

/// {@template body_attribution}
/// A attribution for the body of a request.
/// {@endtemplate}
class BodyAttribution<T> extends RequestAttribution<T> {
  /// {@macro body_attribution}
  const BodyAttribution() : super('body', null);

  const BodyAttribution._(T data) : super('body', data);

  @override
  RequestAttribution<T> operator >>(T data) {
    return BodyAttribution._(data);
  }
}
