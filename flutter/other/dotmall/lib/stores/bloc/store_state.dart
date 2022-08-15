part of 'store_bloc.dart';

abstract class StoreState extends Equatable {
  const StoreState();

  @override
  List<Object> get props => [];
}

class StoreInitial extends StoreState {}

class StoreLoadingState extends StoreState {}

class StoreLoadedState extends StoreState {
  final PaginatedStore response;
  StoreLoadedState(this.response);

  @override
  List<Object> get props => [response];
}
