// ignore_for_file: avoid_redundant_argument_values

import 'package:jsonplaceholder_api/jsonplaceholder_api.dart';
import 'package:test/test.dart';

void main() {
  group('Todo', () {
    Jsonplaceholder createSubject({
      int id = 1,
      String title = 'title',
      int albumId = 1,
      String url = 'url',
      String thumbnailUrl = 'thumbnailUrl',
    }) {
      return Jsonplaceholder(
        id: id,
        title: title,
        albumId: albumId,
        url: url,
        thumbnailUrl: thumbnailUrl,
      );
    }

    group('constructor', () {
      test('works correctly', () {
        expect(
          createSubject,
          returnsNormally,
        );
      });

      test('supports value equality', () {
        expect(
          createSubject(),
          equals(createSubject()),
        );
      });

      test('props are correct', () {
        expect(
          createSubject().props,
          equals([
            1, // id
            'title', // title
            1, // albumId
            'url', // url
            'thumbnailUrl', // thumbnailUrl
          ]),
        );
      });

      group('copyWith', () {
        test('returns the same object if not arguments are provided', () {
          expect(
            createSubject().copyWith(),
            equals(createSubject()),
          );
        });

        test('retains the old value for every parameter if null is provided',
            () {
          expect(
            createSubject().copyWith(
              id: null,
              title: null,
              albumId: null,
              url: null,
              thumbnailUrl: null,
            ),
            equals(createSubject()),
          );
        });

        test('replaces every non-null parameter', () {
          expect(
            createSubject().copyWith(
              id: 2,
              title: 'new title',
              url: 'new url',
              thumbnailUrl: 'new thumbnailUrl',
            ),
            equals(
              createSubject(
                id: 2,
                title: 'new title',
                url: 'new url',
                thumbnailUrl: 'new thumbnailUrl',
              ),
            ),
          );
        });
      });

      group('fromJson', () {
        test('works correctly', () {
          expect(
            Jsonplaceholder.fromJson(<String, dynamic>{
              'id': 1,
              'title': 'title',
              'albumId': 1,
              'url': 'url',
              'thumbnailUrl': 'thumbnailUrl',
            }),
            equals(createSubject()),
          );
        });
      });

      group('toJson', () {
        test('works correctly', () {
          expect(
            createSubject().toJson(),
            equals(<String, dynamic>{
              'id': 1,
              'title': 'title',
              'albumId': 1,
              'url': 'url',
              'thumbnailUrl': 'thumbnailUrl',
            }),
          );
        });
      });
    });
  });
}
