import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jsonplaceholder_api/jsonplaceholder_api.dart';
import 'package:mockingjay/mockingjay.dart'
    show MockNavigator, MockNavigatorProvider;
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:practical_showcase_test/core/navigation/navigation.dart';
import 'package:practical_showcase_test/photo_details/bloc/photo_details_bloc.dart';

import 'package:practical_showcase_test/photos/bloc/photo_bloc.dart';
import 'package:practical_showcase_test/photos/view/photos_view.dart';

class MockPhotoBloc extends MockBloc<PhotoEvent, PhotoState>
    implements PhotoBloc {}

class MockPhotoDetailsBloc
    extends MockBloc<PhotoDetailsEvent, PhotoDetailsState>
    implements PhotoDetailsBloc {}

void main() {
  group('PhotosView', () {
    final navigator = MockNavigator();

    late PhotoBloc photoBloc;
    late PhotoDetailsBloc photoDetailsBloc;
    setUp(() {
      photoBloc = MockPhotoBloc();
      photoDetailsBloc = MockPhotoDetailsBloc();
    });

    setUpAll(() {
      registerFallbackValue(const Jsonplaceholder(
          id: 1,
          title: "title",
          albumId: 2,
          url: "url",
          thumbnailUrl: "thumbnailUrl"));
      registerFallbackValue(const PhotoDetailsEvent());
      when(() => navigator.pushNamed(any())).thenAnswer((_) async {
        return null;
      });
    });

    testWidgets("renders a circular progress indicator on initial state",
        (widgetTester) async {
      when(() => photoBloc.state).thenReturn(const PhotoState());
      await widgetTester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: BlocProvider.value(
          value: photoBloc,
          child: const PhotosView(),
        )),
      ));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets("renders a failure text on failure state",
        (widgetTester) async {
      when(() => photoBloc.state)
          .thenReturn(const PhotoState(status: PhotoStatus.failure));
      await widgetTester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: BlocProvider.value(
          value: photoBloc,
          child: const PhotosView(),
        )),
      ));

      expect(find.textContaining("Failed to fetch photos"), findsOneWidget);
    });

    testWidgets('renders "No photos" text on success state with empty data',
        (widgetTester) async {
      when(() => photoBloc.state).thenReturn(
          const PhotoState(status: PhotoStatus.success, photos: []));
      await widgetTester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: BlocProvider.value(
          value: photoBloc,
          child: const PhotosView(),
        )),
      ));

      expect(find.textContaining("No photos"), findsOneWidget);
    });

    testWidgets('renders "No photos" text on success state with empty data',
        (widgetTester) async {
      when(() => photoBloc.state).thenReturn(
          const PhotoState(status: PhotoStatus.success, photos: []));
      await widgetTester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: BlocProvider.value(
          value: photoBloc,
          child: const PhotosView(),
        )),
      ));

      expect(find.textContaining("No photos"), findsOneWidget);
    });

    testWidgets(
        'renders a list on success state with non empty data and has reached max',
        (widgetTester) async {
      when(() => photoBloc.state).thenReturn(const PhotoState(
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
      ));
      await widgetTester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: BlocProvider.value(
          value: photoBloc,
          child: const PhotosView(),
        )),
      ));

      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets(
        'renders a list and bottomLoader on success state with non empty data and still more data to be loaded',
        (widgetTester) async {
      when(() => photoBloc.state).thenReturn(PhotoState(
        status: PhotoStatus.success,
        photos: [
          for (int i = 0; i < 21; i++)
            const Jsonplaceholder(
              id: 1,
              title: "title",
              albumId: 2,
              url: '3',
              thumbnailUrl: 'thumbnailUrl',
            ),
        ],
        hasReachedMax: false,
      ));
      when(() => photoBloc.add(const PhotoFetched())).thenReturn(null);

      mockNetworkImagesFor(() async {
        await widgetTester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: BlocProvider.value(
            value: photoBloc,
            child: const PhotosView(),
          )),
        ));

        // Wait for the CachedNetworImage images to show error
        for (var i = 0; i < 10; i++) {
          await widgetTester.pump(const Duration(seconds: 10));
        }

        // Scroll down
        await widgetTester.drag(
            find.byKey(const Key('ListViewKey')), const Offset(0.0, -100000));

        // Refresh frame to allow BottomLoader appearing
        for (var i = 0; i < 10; i++) {
          await widgetTester.pump(const Duration(seconds: 10));
        }

        await expectLater(find.byKey(const Key('BottomLoader')), findsWidgets);
      });
    });

    testWidgets(
        'renders a list and bottomLoader on success state with non empty data and still more data to be loaded',
        (widgetTester) async {
      when(() => photoBloc.state).thenReturn(PhotoState(
        status: PhotoStatus.success,
        photos: [
          for (int i = 0; i < 21; i++)
            const Jsonplaceholder(
              id: 1,
              title: "title",
              albumId: 2,
              url: '3',
              thumbnailUrl: 'thumbnailUrl',
            ),
        ],
        hasReachedMax: false,
      ));
      when(() => photoBloc.add(const PhotoFetched())).thenReturn(null);

      mockNetworkImagesFor(() async {
        await widgetTester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: BlocProvider.value(
            value: photoBloc,
            child: const PhotosView(),
          )),
        ));

        // Wait for the CachedNetworImage images to show error
        for (var i = 0; i < 10; i++) {
          await widgetTester.pump(const Duration(seconds: 10));
        }

        // Scroll down
        await widgetTester.drag(
            find.byKey(const Key('ListViewKey')), const Offset(0.0, -100000));

        // Refresh frame to allow BottomLoader appearing
        for (var i = 0; i < 10; i++) {
          await widgetTester.pump(const Duration(seconds: 10));
        }

        await expectLater(find.byKey(const Key('BottomLoader')), findsWidgets);
      });
    });

    testWidgets('clicking on photo_item triggers navigation',
        (widgetTester) async {
      when(() => photoDetailsBloc.state).thenReturn(const PhotoDetailsState());
      when(() => photoBloc.state).thenReturn(PhotoState(
        status: PhotoStatus.success,
        photos: [
          for (int i = 0; i < 21; i++)
            const Jsonplaceholder(
              id: 1,
              title: "title",
              albumId: 2,
              url: '3',
              thumbnailUrl: 'thumbnailUrl',
            ),
        ],
        hasReachedMax: false,
      ));
      when(() => photoBloc.add(const PhotoFetched())).thenReturn(null);

      when(
        () => photoDetailsBloc.add(
          any(that: isA<PhotoSelected>()),
        ),
      ).thenReturn(null);

      mockNetworkImagesFor(() async {
        await widgetTester.pumpWidget(
          MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: photoBloc,
              ),
              BlocProvider.value(
                value: photoDetailsBloc,
              ),
            ],
            child: MaterialApp(
              home: MockNavigatorProvider(
                navigator: navigator,
                child: const PhotosView(),
              ),
            ),
          ),
        );

        // Wait for the CachedNetworImage images to show error
        for (var i = 0; i < 10; i++) {
          await widgetTester.pump(const Duration(seconds: 10));
        }

        Finder finder = find.byKey(const Key("jsonplaceholder0"));
        expect(finder.hitTestable(), findsOneWidget);
        await widgetTester.tap(finder);

        verify(
          () => navigator.pushNamed(Navigation.photosDetailRoute),
        ).called(1);

        verify(() => photoDetailsBloc.add(any(that: isA<PhotoSelected>())))
            .called(1);
      });
    });

    group("SearchBar", () {
      testWidgets("renders a TextField", (widgetTester) async {
        when(() => photoBloc.state).thenReturn(const PhotoState());
        await widgetTester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: BlocProvider.value(
            value: photoBloc,
            child: const PhotosView(),
          )),
        ));

        expect(widgetTester.firstWidget(find.byKey(const Key('SearchBar'))),
            isA<TextField>());
      });

      testWidgets("triggers FilterRequested on input", (widgetTester) async {
        when(() => photoBloc.state).thenReturn(const PhotoState());
        await widgetTester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: photoBloc,
              ),
              BlocProvider.value(
                value: photoDetailsBloc,
              ),
            ],
            child: const PhotosView(),
          )),
        ));

        await widgetTester.enterText(
            find.byKey(const Key("SearchBar")), "smth");
        verify(() => photoBloc.add(const FilterRequested(searchInput: "smth")))
            .called(1);
      });
    });
  });
}
