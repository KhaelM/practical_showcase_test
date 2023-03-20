// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'photo_bloc.dart';

@immutable
abstract class PhotoEvent {}

class PhotoFetched extends PhotoEvent {}

class FilterRequested extends PhotoEvent {
  final String searchInput;
  FilterRequested({
    required this.searchInput,
  });
}
