part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeUpdateConfigsState extends HomeState {
  final Configs configs;
  HomeUpdateConfigsState(this.configs);
  @override
  List<Object> get props => [configs];
}
