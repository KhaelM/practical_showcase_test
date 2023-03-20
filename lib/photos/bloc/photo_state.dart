part of 'photo_bloc.dart';

enum PhotoStatus { initial, success, failure }

class PhotoState extends Equatable {
  const PhotoState({
    this.status = PhotoStatus.initial,
    this.photos = const <Jsonplaceholder>[],
    this.hasReachedMax = false,
  });

  final PhotoStatus status;
  final List<Jsonplaceholder> photos;
  final bool hasReachedMax;

  PhotoState copyWith({
    PhotoStatus? status,
    List<Jsonplaceholder>? photos,
    bool? hasReachedMax,
  }) {
    return PhotoState(
      status: status ?? this.status,
      photos: photos ?? this.photos,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, photos, hasReachedMax];
}
