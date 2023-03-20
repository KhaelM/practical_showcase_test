import 'package:http/http.dart' as http;
import 'package:jsonplaceholder_api/jsonplaceholder_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:online_jsonplaceholder_api/online_jsonplaceholder_api.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('OnlineJsonplaceholderApi', () {
    late http.Client httpClient;
    late OnlineJsonplaceholderApi onlineJsonplaceholderApi;
    setUpAll(() {
      registerFallbackValue(FakeUri());
    });
    setUp(() {
      httpClient = MockHttpClient();
      onlineJsonplaceholderApi =
          OnlineJsonplaceholderApi(httpClient: httpClient);
    });
    test('does not require an httpClient', () {
      expect(OnlineJsonplaceholderApi(), isNotNull);
    });

    test('makes correct http request', () async {
      final response = MockResponse();
      when(() => response.statusCode).thenReturn(200);
      when(() => response.body).thenReturn('[{}]');
      when(
        () => httpClient.get(
          any(),
        ),
      ).thenAnswer((_) async => response);
      try {
        await onlineJsonplaceholderApi.getJsonplaceholders();
      } catch (_) {}
      verify(
        () => httpClient.get(
          Uri.https(
            'jsonplaceholder.typicode.com',
            '/photos',
          ),
        ),
      ).called(1);
    });

    test('throws exception when response is different from 200', () {
      final response = MockResponse();
      when(() => response.statusCode).thenReturn(503);
      when(() => response.body).thenReturn('{}');
      when(
        () => httpClient.get(
          any(),
        ),
      ).thenAnswer((_) async => response);
      expectLater(
        onlineJsonplaceholderApi.getJsonplaceholders(),
        throwsA(isA<ServerDownException>()),
      );
    });
  });
}
