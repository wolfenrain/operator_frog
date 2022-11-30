import 'package:operator_frog_client/src/internal/internal.dart';

class _Http {
  const _Http();

  HttpClient operator >(String url) {
    return HttpClient(Uri.parse(url));
  }
}

/// The HTTP client creator.
const http = _Http();
