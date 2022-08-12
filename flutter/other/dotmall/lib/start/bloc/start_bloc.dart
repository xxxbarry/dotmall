import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dotmall_sdk/dotmall_sdk.dart';
import 'package:equatable/equatable.dart';

import '../../app/app.dart';

part 'start_event.dart';
part 'start_state.dart';

class StartBloc extends Bloc<StartEvent, StartState> {
  Configs configs;

  StartBloc(this.configs) : super(StartInitial()) {
    on<StartRequestEvent>(_onStartRequest);
    on<StartLoadingEvent>(_onStartLoading);
    on<StartLoadedEvent>(_onStartLoaded);
  }

  FutureOr<void> _onStartLoading(
      StartLoadingEvent event, Emitter<StartState> emit) async {
    emit(StartLoadingState());
    await Future.delayed(Duration(seconds: 3));
    add(StartLoadedEvent());
  }

  FutureOr<void> _onStartLoaded(
      StartLoadedEvent event, Emitter<StartState> emit) async {
    emit(StartLoadedState());
    // var authResponse = await App.router.push<AuthResponse>("/auth").result;
    // await Future.delayed(Duration(seconds: 3));
    App.router.push("/");
  }

  FutureOr<void> _onStartRequest(
      StartRequestEvent event, Emitter<StartState> emit) {
    emit(StartLoadingState());
    add(StartLoadingEvent());
    // App.router.push("/");
  }
}
