part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

// loading
class HomeLoadingEvent extends HomeEvent {}

class HomeLoadEvent extends HomeEvent {
  HomeLoadEvent();
}

class HomeUpdateConfigsEvent extends HomeEvent {
  final Configs configs;
  HomeUpdateConfigsEvent(this.configs);
  @override
  List<Object> get props => [configs];
}
