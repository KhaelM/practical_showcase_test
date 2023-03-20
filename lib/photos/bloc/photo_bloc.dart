import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:jsonplaceholder_repository/jsonplaceholder_repository.dart';
import 'package:meta/meta.dart';
import 'package:stream_transform/stream_transform.dart';

part 'photo_event.dart';
part 'photo_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  PhotoBloc(
    this._jsonplaceholderRepository, {
    int itemPerScroll = 20,
  })  : _itemPerScroll = itemPerScroll,
        super(const PhotoState()) {
    on<PhotoFetched>(
      _onPhotoFetched,
      transformer: throttleDroppable(throttleDuration),
    );
    on<FilterRequested>(
      _onFilterRequested,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final JsonplaceholderRepository _jsonplaceholderRepository;

  List<Jsonplaceholder> _allData = [];
  List<Jsonplaceholder> _currentData = [];
  int _itemsLength = 0;
  final int _itemPerScroll;

  _onFilterRequested(
    FilterRequested event,
    Emitter<PhotoState> emit,
  ) {
    if (event.searchInput.isNotEmpty) {
      _currentData = _allData
          .where((element) => element.title
              .toUpperCase()
              .contains(event.searchInput.toUpperCase()))
          .toList();
    } else {
      _currentData = _allData;
    }
    _itemsLength = _itemPerScroll;
    bool noMoreData = false;
    if (_itemPerScroll >= _currentData.length) {
      _itemsLength = _currentData.length;
      noMoreData = true;
    }
    emit(state.copyWith(
      status: PhotoStatus.success,
      photos: _currentData.sublist(0, min(_itemPerScroll, _currentData.length)),
      hasReachedMax: noMoreData ? true : false,
    ));
  }

  Future<void> _onPhotoFetched(
    PhotoFetched event,
    Emitter<PhotoState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PhotoStatus.initial) {
        _allData = await _jsonplaceholderRepository.getJsonplaceholders();
        _currentData = _allData;
        _itemsLength = min(_itemPerScroll, _allData.length);
        return emit(state.copyWith(
          status: PhotoStatus.success,
          photos: _currentData.sublist(0, _itemsLength),
          hasReachedMax: _allData.length <= _itemPerScroll ? true : false,
        ));
      }

      bool noMoreData = false;
      _itemsLength += _itemPerScroll;
      if (_itemsLength >= _currentData.length) {
        _itemsLength = _currentData.length;
        noMoreData = true;
      }
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(
        status: PhotoStatus.success,
        photos: _currentData.sublist(0, _itemsLength),
        hasReachedMax: noMoreData ? true : false,
      ));
    } catch (_) {
      emit(state.copyWith(status: PhotoStatus.failure));
    }
  }
}
