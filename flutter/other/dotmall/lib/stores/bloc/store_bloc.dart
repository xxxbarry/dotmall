import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dotmall_sdk/dotmall_sdk.dart';
import 'package:equatable/equatable.dart';

import '../../core/repositories/repositories.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final Stores repository;
  final CachePaginatedModel<Store> cache = CachePaginatedModel();
  StoreBloc(this.repository) : super(StoreInitial()) {
    on<StoreLoadEvent>(_onStoreLoad);
    on<StoreLoadingEvent>(_onStoreLoading);
    on<StoreLoadedEvent>(_onStoreLoaded);
  }

  FutureOr<void> _onStoreLoad(
      StoreLoadEvent event, Emitter<StoreState> emit) async {
    emit(StoreLoadingState());
    await Future.delayed(Duration(seconds: 1));
    var response = await repository.list(
        options: event.options,
        load: [StoreRelations.translations, StoreRelations.photos]);
    add(StoreLoadedEvent(response));
  }

  FutureOr<void> _onStoreLoading(
      StoreLoadingEvent event, Emitter<StoreState> emit) async {
    emit(StoreLoadingState());
  }

  FutureOr<void> _onStoreLoaded(
      StoreLoadedEvent event, Emitter<StoreState> emit) async {
    cache.add(event.response);
    emit(StoreLoadedState(event.response));
  }
}
