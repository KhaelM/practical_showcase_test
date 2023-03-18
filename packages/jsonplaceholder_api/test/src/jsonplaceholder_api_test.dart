import 'package:jsonplaceholder_api/jsonplaceholder_api.dart';
import 'package:test/test.dart';

class TestJsonplaceholderApi extends JsonplaceholderApi {
  TestJsonplaceholderApi() : super();

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
  }
}

void main() {
  group('JsonplaceholderApi', () {
    test('can be constructed', () {
      expect(TestJsonplaceholderApi.new, returnsNormally);
    });
  });
}
