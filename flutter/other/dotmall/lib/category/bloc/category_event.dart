part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

// loading
class CategoryLoadingEvent extends CategoryEvent {}

class CategoryLoadEvent extends CategoryEvent {}

class CategoryLoadedEvent extends CategoryEvent {
  final PaginatedCategory categories;
  CategoryLoadedEvent(this.categories);
  @override
  List<Object> get props => [categories];
}
