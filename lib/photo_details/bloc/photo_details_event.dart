part of 'photo_details_bloc.dart';

class PhotoDetailsEvent {
  const PhotoDetailsEvent();
}

class PhotoSelected extends PhotoDetailsEvent {
  final Jsonplaceholder jsonplaceholder;
  const PhotoSelected({required this.jsonplaceholder});
}
