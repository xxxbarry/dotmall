import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dotmall_sdk/dotmall_sdk.dart';
import 'package:equatable/equatable.dart';

import '../../core/repositories/repositories.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  Configs configs = Configs();
  HomeBloc() : super(HomeInitial()) {
    on<HomeUpdateConfigsEvent>(_onHomeUpdateConfigsEvent);
  }

  FutureOr<void> _onHomeUpdateConfigsEvent(
      HomeUpdateConfigsEvent event, Emitter<HomeState> emit) async {
    configs = event.configs;
    emit(HomeUpdateConfigsState(event.configs));
  }
}
