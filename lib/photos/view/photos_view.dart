import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsonplaceholder_api/jsonplaceholder_api.dart';
import 'package:practical_showcase_test/photos/bloc/photo_bloc.dart';

import '../../core/navigation/navigation.dart';
import '../../photo_details/bloc/photo_details_bloc.dart';

part 'photos_list.dart';
part 'bottom_loader.dart';
part 'photo_list_item.dart';
part 'search_bar.dart';

class PhotosView extends StatefulWidget {
  const PhotosView({super.key});

  @override
  State<PhotosView> createState() => _PhotosViewState();
}

class _PhotosViewState extends State<PhotosView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Photos')),
      body: Stack(
        children: const [
          _SearchBar(),
          Padding(
            padding: EdgeInsets.only(top: 80),
            child: _PhotosList(),
          ),
        ],
      ),
    );
  }
}
