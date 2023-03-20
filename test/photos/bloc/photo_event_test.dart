// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:practical_showcase_test/photos/bloc/photo_bloc.dart';

void main() {
  group('PhotoEvent', () {
    group('PhotoFetched', () {
      test('supports value comparisons', () {
        expect(PhotoFetched(), PhotoFetched());
      });
    });

    group('FilterRequested', () {
      const String searchInput = "mockSearchInput";
      test('supports value comparisons', () {
        expect(
          FilterRequested(searchInput: searchInput),
          FilterRequested(searchInput: searchInput),
        );
      });
    });
  });
}
