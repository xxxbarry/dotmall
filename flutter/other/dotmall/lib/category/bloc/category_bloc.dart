import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dotmall_sdk/dotmall_sdk.dart';
import 'package:equatable/equatable.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final Categories repository;
  CategoryBloc(this.repository) : super(CategoryInitial()) {
    on<CategoryLoadEvent>(_onCategoryLoad);
    on<CategoryLoadingEvent>(_onCategoryLoading);
  }

  FutureOr<void> _onCategoryLoad(event, Emitter<CategoryState> emit) async {
    emit(CategoryLoadingState());
    add(CategoryLoadedEvent(await repository.list()));
  }

  FutureOr<void> _onCategoryLoading(event, Emitter<CategoryState> emit) async {
    emit(CategoryLoadingState());
  }
}
