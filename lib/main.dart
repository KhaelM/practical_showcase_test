import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsonplaceholder_repository/jsonplaceholder_repository.dart';
import 'package:online_jsonplaceholder_api/online_jsonplaceholder_api.dart';
import 'package:practical_showcase_test/core/navigation/navigation.dart';
import 'package:practical_showcase_test/photo_details/bloc/photo_details_bloc.dart';
import 'package:practical_showcase_test/photos/bloc/photo_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => JsonplaceholderRepository(
          jsonplaceholderApi: OnlineJsonplaceholderApi()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PhotoBloc(
                context.read<JsonplaceholderRepository>(),
                itemPerScroll: 20)
              ..add(const PhotoFetched()),
          ),
          BlocProvider(
            create: (context) => PhotoDetailsBloc(),
          ),
        ],
        child: MaterialApp(
          initialRoute: Navigation.photosRoute,
          onGenerateRoute: Navigation.generateRoute,
          theme: ThemeData(
            primarySwatch: Colors.amber,
            textTheme: const TextTheme(
              titleLarge: TextStyle(
                fontSize: 28.0,
              ),
              titleMedium: TextStyle(
                fontSize: 20.0,
              ),
              bodyLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              bodyMedium: TextStyle(fontSize: 20.0),
            ),
          ),
        ),
      ),
    );
  }
}
