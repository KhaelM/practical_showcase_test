part of 'photo_details_bloc.dart';

abstract class PhotoDetailsEvent {
  const PhotoDetailsEvent();
}

class PhotoSelected extends PhotoDetailsEvent {
  final Jsonplaceholder jsonplaceholder;
  const PhotoSelected(
    this.jsonplaceholder,
  );
}
