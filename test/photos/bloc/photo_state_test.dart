// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:practical_showcase_test/photos/bloc/photo_bloc.dart';

void main() {
  group('PhotoState', () {
    test('supports value comparisons', () {
      expect(PhotoState(), PhotoState());
    });

    test('returns same object when no properties are passed', () {
      expect(PhotoState().copyWith(), PhotoState());
    });

    test('returns object with updated status when status is passed', () {
      expect(
        PhotoState().copyWith(status: PhotoStatus.initial),
        PhotoState(),
      );
    });

    test('returns object with updated photos when photos is passed', () {
      expect(
        PhotoState().copyWith(photos: []),
        PhotoState(photos: const []),
      );
    });

    test(
        'returns object with updated hasReachedMax when hasReachedMax is passed',
        () {
      expect(
        PhotoState().copyWith(hasReachedMax: false),
        PhotoState(hasReachedMax: false),
      );
    });
  });
}
