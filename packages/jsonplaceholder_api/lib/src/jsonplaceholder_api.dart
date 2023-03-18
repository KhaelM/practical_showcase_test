import 'package:jsonplaceholder_api/jsonplaceholder_api.dart';

/// {@template jsonplaceholder_api}
/// The interface and models for an API providing access to https://jsonplaceholder.typicode.com/photos
/// {@endtemplate}
abstract class JsonplaceholderApi {
  /// {@macro jsonplaceholder_api}
  const JsonplaceholderApi();

  /// Provides a [Stream] of all jsonplaceholders.
  Stream<List<Jsonplaceholder>> getJsonplaceholders();
}
