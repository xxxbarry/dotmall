part of 'start_bloc.dart';

abstract class StartState extends Equatable {
  const StartState();

  @override
  List<Object> get props => [];
}

class StartInitial extends StartState {}

/// [StartLoadingState] is the state that is used when the authentication is loading.
class StartLoadingState extends StartState {}

/// [StartCacheLoadedState] is the state that is used when the authentication is loaded from cache.
class StartCacheLoadedState extends StartState {}

/// [StartCheckingState] is the state that is used when the authentication is checking.
class StartCheckingState extends StartState {}

/// [StartLoadedState] is the state that is used when the authentication is loaded.
class StartLoadedState extends StartState {
  const StartLoadedState();
}

class StartChangesConfigsState extends StartState {
  final Configs configs;
  const StartChangesConfigsState(this.configs);
}
