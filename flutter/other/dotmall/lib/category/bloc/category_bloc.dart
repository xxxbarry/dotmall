import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dotmall_sdk/dotmall_sdk.dart';
import 'package:equatable/equatable.dart';

import '../../core/repositories/repositories.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final Categories repository;
  final CachePaginatedModel<Category> cache = CachePaginatedModel();
  CategoryBloc(this.repository) : super(CategoryInitial()) {
    on<CategoryLoadEvent>(_onCategoryLoad);
    on<CategoryLoadingEvent>(_onCategoryLoading);
    on<CategoryLoadedEvent>(_onCategoryLoaded);
  }

  FutureOr<void> _onCategoryLoad(
      CategoryLoadEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryLoadingState());
    await Future.delayed(Duration(seconds: 1));
    var response = await repository.list(
        options: event.options,
        load: [CategoryRelations.translations, CategoryRelations.photos]);
    add(CategoryLoadedEvent(response));
  }

  FutureOr<void> _onCategoryLoading(
      CategoryLoadingEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryLoadingState());
  }

  FutureOr<void> _onCategoryLoaded(
      CategoryLoadedEvent event, Emitter<CategoryState> emit) async {
    cache.add(event.response);
    emit(CategoryLoadedState(event.response));
  }
}
