import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dotmall_sdk/dotmall_sdk.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  Configs configs;
  AppBloc({required this.configs}) : super(AppInitial()) {
    on<AppConfigsUpdatedEvent>(_onAppConfigsUpdated);
  }

  FutureOr<void> _onAppConfigsUpdated(
      AppConfigsUpdatedEvent event, Emitter<AppState> emit) {
    configs = event.configs;
    emit(AppConfigsUpdatedState(configs));
  }
}
