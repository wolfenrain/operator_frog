import 'package:dart_frog/dart_frog.dart';
import 'package:operator_frog_server/src/internal/internal.dart';

/// GET method.
const get = HttpMethod.get;

/// POST method.
const post = HttpMethod.post;

/// PUT method.
const put = HttpMethod.put;

/// PATCH method.
const patch = HttpMethod.patch;

/// DELETE method.
const delete = HttpMethod.delete;

/// HEAD method.
const head = HttpMethod.head;

/// OPTIONS method.
const options = HttpMethod.options;

/// Allows for creating handlers for request of a specific HTTP method.
extension HttpMethodX on HttpMethod {
  /// Create a [RequestHandler] for the method.
  RequestHandler operator /(String other) {
    return RequestHandler(
      this,
      other.startsWith('/') ? other.substring(1, other.length) : other,
    );
  }
}
