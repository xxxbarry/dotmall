part of 'store_bloc.dart';

abstract class StoreEvent extends Equatable {
  const StoreEvent();

  @override
  List<Object> get props => [];
}

// loading
class StoreLoadingEvent extends StoreEvent {}

class StoreLoadEvent extends StoreEvent {
  final StoreListOptions? options;
  StoreLoadEvent({this.options});
}

class StoreLoadedEvent extends StoreEvent {
  final PaginatedStore response;
  StoreLoadedEvent(this.response);
  @override
  List<Object> get props => [response];
}
