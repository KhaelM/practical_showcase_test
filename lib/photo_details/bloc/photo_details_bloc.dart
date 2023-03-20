import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jsonplaceholder_api/jsonplaceholder_api.dart';

part 'photo_details_event.dart';
part 'photo_details_state.dart';

class PhotoDetailsBloc extends Bloc<PhotoDetailsEvent, PhotoDetailsState> {
  PhotoDetailsBloc() : super(const PhotoDetailsState()) {
    on<PhotoSelected>(_onPhotoDetailsEvent);
  }

  void _onPhotoDetailsEvent(
      PhotoSelected event, Emitter<PhotoDetailsState> emit) {
    emit(state.copyWith(jsonplaceholder: event.jsonplaceholder));
  }
}
