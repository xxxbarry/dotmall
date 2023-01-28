import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dotmall_sdk/dotmall_sdk.dart';
import 'package:equatable/equatable.dart';

import '../../core/repositories/repositories.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  Configs configs = Configs();
  CategoryBloc() : super(CategoryInitial()) {
    on<CategoryUpdateConfigsEvent>(_onCategoryUpdateConfigsEvent);
  }

  FutureOr<void> _onCategoryUpdateConfigsEvent(
      CategoryUpdateConfigsEvent event, Emitter<CategoryState> emit) async {
    configs = event.configs;
    emit(CategoryUpdateConfigsState(event.configs));
  }
}
