// ignore_for_file: prefer_const_constructors
import 'package:jsonplaceholder_api/jsonplaceholder_api.dart';
import 'package:jsonplaceholder_repository/jsonplaceholder_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockJsonplaceholderApi extends Mock implements JsonplaceholderApi {}

void main() {
  group('JsonplaceholderRepository', () {
    late MockJsonplaceholderApi api;

    setUp(() {
      api = MockJsonplaceholderApi();
      when(() => api.getJsonplaceholders())
          .thenAnswer((_) async => Future.value([]));
    });

    JsonplaceholderRepository createSubject() =>
        JsonplaceholderRepository(jsonplaceholderApi: api);

    group('constructor', () {
      test('works properly', () {
        expect(
          createSubject,
          returnsNormally,
        );
      });
    });

    group('getJsonplaceholders', () {
      test('makes correct api request', () async {
        final subject = createSubject();

        expect(
          await subject.getJsonplaceholders(),
          isNot(throwsA(anything)),
        );

        verify(() => api.getJsonplaceholders()).called(1);
      });
    });
  });
}
