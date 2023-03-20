import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jsonplaceholder_api/jsonplaceholder_api.dart';

/// {@template online_jsonplaceholder_api}
/// Implementation of the [JsonplaceholderApi] which interacts with the real
/// endpoint
/// {@endtemplate}
class OnlineJsonplaceholderApi extends JsonplaceholderApi {
  /// {@macro online_jsonplaceholder_api}
  OnlineJsonplaceholderApi({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  @override
  Future<List<Jsonplaceholder>> getJsonplaceholders() async {
    final url = Uri.https(
      'jsonplaceholder.typicode.com',
      '/photos',
    );
    final response = await _httpClient.get(url);
    if (response.statusCode != 200) {
      throw ServerDownException();
    }
    return List<Map<dynamic, dynamic>>.from(
      json.decode(response.body) as List,
    )
        .map(
          (jsonMap) =>
              Jsonplaceholder.fromJson(Map<String, dynamic>.from(jsonMap)),
        )
        .toList();
  }
}
