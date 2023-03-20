import 'package:jsonplaceholder_api/jsonplaceholder_api.dart';

/// {@template jsonplaceholder_repository}
/// A repository that handles jsonplaceholder related requests.
/// {@endtemplate}
class JsonplaceholderRepository {
  /// {@macro jsonplaceholder_repository}
  const JsonplaceholderRepository({
    required JsonplaceholderApi jsonplaceholderApi,
  }) : _jsonplaceholderApi = jsonplaceholderApi;

  final JsonplaceholderApi _jsonplaceholderApi;

  /// Provides a [Future] of all jsonplaceholders.
  ///
  /// Throws a [ServerDownException] when response code
  /// differs from 200
  Future<List<Jsonplaceholder>> getJsonplaceholders() =>
      _jsonplaceholderApi.getJsonplaceholders();
}
