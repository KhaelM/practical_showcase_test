// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'photo_bloc.dart';

@immutable
abstract class PhotoEvent extends Equatable {
  const PhotoEvent();
}

class PhotoFetched extends PhotoEvent {
  const PhotoFetched();
  @override
  List<Object> get props => [];
}

class FilterRequested extends PhotoEvent {
  final String searchInput;
  const FilterRequested({
    required this.searchInput,
  });

  @override
  List<Object> get props => [searchInput];
}
