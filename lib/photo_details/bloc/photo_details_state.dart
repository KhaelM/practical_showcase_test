part of 'photo_details_bloc.dart';

class PhotoDetailsState extends Equatable {
  final Jsonplaceholder? jsonplaceholder;
  const PhotoDetailsState({
    this.jsonplaceholder,
  });

  @override
  List<Object?> get props => [jsonplaceholder];

  PhotoDetailsState copyWith({
    Jsonplaceholder? jsonplaceholder,
  }) {
    return PhotoDetailsState(
      jsonplaceholder: jsonplaceholder ?? this.jsonplaceholder,
    );
  }
}
