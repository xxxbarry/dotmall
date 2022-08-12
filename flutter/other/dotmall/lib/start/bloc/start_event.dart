part of 'start_bloc.dart';

abstract class StartEvent extends Equatable {
  const StartEvent();

  @override
  List<Object> get props => [];
}

// [StartRequestEvent]
class StartRequestEvent extends StartEvent {
  const StartRequestEvent();
}

/// [StartLoadingEvent] event is used to indicate that the authentication is loading.
class StartLoadingEvent extends StartEvent {
  const StartLoadingEvent();
}

/// [StartLoadedEvent] is the event to get token and model
class StartLoadedEvent extends StartEvent {
  const StartLoadedEvent();
}

// StartChangesConfigsEvent
class StartChangesConfigsEvent extends StartEvent {
  final Configs configs;
  const StartChangesConfigsEvent(this.configs);
}
