/// {@template echo_data_source}
/// A data source that stores data it is given and returns it when asked.
/// {@endtemplate}
class EchoDataSource {
  final List<String> _previouslyEchoed = [];

  /// Returns the list of data that has been echoed.
  Future<List<String>> readAll() async {
    return _previouslyEchoed;
  }

  /// Echoes the given data and stores it.
  Future<String> add(String echo) async {
    _previouslyEchoed.add(echo);
    return echo;
  }
}
