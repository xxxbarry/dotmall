part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

// loading
class CategoryLoadingEvent extends CategoryEvent {}

class CategoryLoadEvent extends CategoryEvent {
  final CategoryListOptions? options;
  CategoryLoadEvent({this.options});
}

class CategoryLoadedEvent extends CategoryEvent {
  final PaginatedCategory response;
  CategoryLoadedEvent(this.response);
  @override
  List<Object> get props => [response];
}
