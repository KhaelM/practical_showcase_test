import 'package:flutter/material.dart';

import '../../photo_details/view/photos_detail_view.dart';
import '../../photos/view/photos_view.dart';

class Navigation {
  static const String photosRoute = "photos";
  static const String photosDetailRoute = "photosDetail";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case photosRoute:
        return MaterialPageRoute(builder: (_) => const PhotosView());
      case photosDetailRoute:
        return MaterialPageRoute(builder: (_) => const PhotoDetailsView());

      default:
        throw const FormatException("Route not found! Check routes again!");
    }
  }
}
