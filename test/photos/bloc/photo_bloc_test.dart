import 'package:flutter_test/flutter_test.dart';
import 'package:jsonplaceholder_repository/jsonplaceholder_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:practical_showcase_test/photos/bloc/photo_bloc.dart';
import 'package:bloc_test/bloc_test.dart';

class MockJsonplaceholderRepository extends Mock
    implements JsonplaceholderRepository {}

void main() {
  group('PhotoBloc', () {
    late JsonplaceholderRepository jsonplaceholderRepository;

    setUp(() {
      jsonplaceholderRepository = MockJsonplaceholderRepository();
    });

    test('initial state is LoginState', () {
      final loginBloc = PhotoBloc(
        jsonplaceholderRepository,
      );
      expect(loginBloc.state, const PhotoState());
    });

    group("OnPhotoFetched", () {
      blocTest<PhotoBloc, PhotoState>(
        'emits [success] '
        'when getJsonplaceholders succeeds',
        setUp: () {
          when(
            () => jsonplaceholderRepository.getJsonplaceholders(),
          ).thenAnswer((_) async {
            return Future.value([
              const Jsonplaceholder(
                id: 1,
                title: "title",
                albumId: 2,
                url: '3',
                thumbnailUrl: 'thumbnailUrl',
              ),
            ]);
          });
        },
        build: () => PhotoBloc(
          jsonplaceholderRepository,
        ),
        act: (bloc) {
          bloc.add(const PhotoFetched());
        },
        expect: () => <PhotoState>[
          const PhotoState(
            status: PhotoStatus.success,
            photos: [
              Jsonplaceholder(
                id: 1,
                title: "title",
                albumId: 2,
                url: '3',
                thumbnailUrl: 'thumbnailUrl',
              ),
            ],
            hasReachedMax: true,
          ),
        ],
      );

      blocTest<PhotoBloc, PhotoState>(
        'hasReachedMax'
        'when there\'s no more data',
        setUp: () {
          when(
            () => jsonplaceholderRepository.getJsonplaceholders(),
          ).thenAnswer((_) async {
            return Future.value([
              for (int i = 0; i < 9; i++)
                const Jsonplaceholder(
                  id: 1,
                  title: "title",
                  albumId: 2,
                  url: '3',
                  thumbnailUrl: 'thumbnailUrl',
                ),
            ]);
          });
        },
        build: () => PhotoBloc(jsonplaceholderRepository, itemPerScroll: 5),
        act: (bloc) async {
          bloc.add(const PhotoFetched());
          await Future.delayed(const Duration(seconds: 2));
          bloc.add(const PhotoFetched());
        },
        wait: const Duration(seconds: 2),
        expect: () => <PhotoState>[
          PhotoState(
            status: PhotoStatus.success,
            photos: [
              for (int i = 0; i < 5; i++)
                const Jsonplaceholder(
                  id: 1,
                  title: "title",
                  albumId: 2,
                  url: '3',
                  thumbnailUrl: 'thumbnailUrl',
                ),
            ],
            hasReachedMax: false,
          ),
          PhotoState(
            status: PhotoStatus.success,
            photos: [
              for (int i = 0; i < 9; i++)
                const Jsonplaceholder(
                  id: 1,
                  title: "title",
                  albumId: 2,
                  url: '3',
                  thumbnailUrl: 'thumbnailUrl',
                ),
            ],
            hasReachedMax: true,
          ),
        ],
      );

      blocTest<PhotoBloc, PhotoState>(
        'has not reached Max'
        'when there\'s more data to be loaded',
        setUp: () {
          when(
            () => jsonplaceholderRepository.getJsonplaceholders(),
          ).thenAnswer((_) async {
            return Future.value([
              for (int i = 0; i < 11; i++)
                const Jsonplaceholder(
                  id: 1,
                  title: "title",
                  albumId: 2,
                  url: '3',
                  thumbnailUrl: 'thumbnailUrl',
                ),
            ]);
          });
        },
        build: () => PhotoBloc(jsonplaceholderRepository, itemPerScroll: 5),
        act: (bloc) async {
          bloc.add(const PhotoFetched());
          await Future.delayed(const Duration(seconds: 2));
          bloc.add(const PhotoFetched());
        },
        wait: const Duration(seconds: 2),
        expect: () => <PhotoState>[
          PhotoState(
            status: PhotoStatus.success,
            photos: [
              for (int i = 0; i < 5; i++)
                const Jsonplaceholder(
                  id: 1,
                  title: "title",
                  albumId: 2,
                  url: '3',
                  thumbnailUrl: 'thumbnailUrl',
                ),
            ],
            hasReachedMax: false,
          ),
          PhotoState(
            status: PhotoStatus.success,
            photos: [
              for (int i = 0; i < 10; i++)
                const Jsonplaceholder(
                  id: 1,
                  title: "title",
                  albumId: 2,
                  url: '3',
                  thumbnailUrl: 'thumbnailUrl',
                ),
            ],
            hasReachedMax: false,
          ),
        ],
      );

      blocTest<PhotoBloc, PhotoState>(
        'emits [Failure]'
        'when repository throws Exception',
        setUp: () {
          when(
            () => jsonplaceholderRepository.getJsonplaceholders(),
          ).thenAnswer((_) async {
            throw Exception();
          });
        },
        build: () => PhotoBloc(jsonplaceholderRepository, itemPerScroll: 5),
        act: (bloc) async {
          bloc.add(const PhotoFetched());
        },
        wait: const Duration(seconds: 2),
        expect: () => <PhotoState>[
          const PhotoState(
            status: PhotoStatus.failure,
          ),
        ],
      );
    });

    group("OnFilterRequested", () {
      blocTest(
        'filters search correctly',
        setUp: () {
          when(
            () => jsonplaceholderRepository.getJsonplaceholders(),
          ).thenAnswer((_) async {
            return Future.value([
              const Jsonplaceholder(
                id: 1,
                title: "title",
                albumId: 2,
                url: '3',
                thumbnailUrl: 'thumbnailUrl',
              ),
              const Jsonplaceholder(
                id: 1,
                title: "Naruto",
                albumId: 2,
                url: '3',
                thumbnailUrl: 'thumbnailUrl',
              ),
            ]);
          });
        },
        build: () => PhotoBloc(jsonplaceholderRepository, itemPerScroll: 5),
        act: (bloc) async {
          bloc.add(const PhotoFetched());
          await Future.delayed(const Duration(seconds: 2));
          bloc.add(const FilterRequested(searchInput: "Naru"));
        },
        wait: const Duration(seconds: 2),
        expect: () => <PhotoState>[
          const PhotoState(
            status: PhotoStatus.success,
            photos: [
              Jsonplaceholder(
                id: 1,
                title: "title",
                albumId: 2,
                url: '3',
                thumbnailUrl: 'thumbnailUrl',
              ),
              Jsonplaceholder(
                id: 1,
                title: "Naruto",
                albumId: 2,
                url: '3',
                thumbnailUrl: 'thumbnailUrl',
              ),
            ],
            hasReachedMax: true,
          ),
          const PhotoState(
            status: PhotoStatus.success,
            photos: [
              Jsonplaceholder(
                id: 1,
                title: "Naruto",
                albumId: 2,
                url: '3',
                thumbnailUrl: 'thumbnailUrl',
              ),
            ],
            hasReachedMax: true,
          ),
        ],
      );

      blocTest(
        'emits empty photos when PhotoFetched event not triggered before',
        build: () => PhotoBloc(jsonplaceholderRepository, itemPerScroll: 5),
        act: (bloc) async {
          bloc.add(const FilterRequested(searchInput: "Naru"));
        },
        expect: () => <PhotoState>[
          const PhotoState(
            status: PhotoStatus.success,
            photos: [],
            hasReachedMax: true,
          ),
        ],
      );

      blocTest(
        'emits all data when search input is empty',
        build: () => PhotoBloc(jsonplaceholderRepository, itemPerScroll: 5),
        setUp: () {
          when(
            () => jsonplaceholderRepository.getJsonplaceholders(),
          ).thenAnswer((_) async {
            return Future.value([
              const Jsonplaceholder(
                id: 1,
                title: "title",
                albumId: 2,
                url: '3',
                thumbnailUrl: 'thumbnailUrl',
              ),
              const Jsonplaceholder(
                id: 1,
                title: "Naruto",
                albumId: 2,
                url: '3',
                thumbnailUrl: 'thumbnailUrl',
              ),
            ]);
          });
        },
        act: (bloc) async {
          bloc.add(const PhotoFetched());
          await Future.delayed(const Duration(seconds: 2));
          bloc.add(const FilterRequested(searchInput: ""));
        },
        wait: const Duration(seconds: 2),
        expect: () => <PhotoState>[
          const PhotoState(
            status: PhotoStatus.success,
            photos: [
              Jsonplaceholder(
                id: 1,
                title: "title",
                albumId: 2,
                url: '3',
                thumbnailUrl: 'thumbnailUrl',
              ),
              Jsonplaceholder(
                id: 1,
                title: "Naruto",
                albumId: 2,
                url: '3',
                thumbnailUrl: 'thumbnailUrl',
              ),
            ],
            hasReachedMax: true,
          ),
        ],
      );
    });
  });
}
