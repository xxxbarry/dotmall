part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

/// Configs updated event
class AppConfigsUpdatedEvent extends AppEvent {
  final Configs configs;
  AppConfigsUpdatedEvent({required this.configs});
}
