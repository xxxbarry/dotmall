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

class CategoryUpdateConfigsEvent extends CategoryEvent {
  final Configs configs;
  CategoryUpdateConfigsEvent(this.configs);
  @override
  List<Object> get props => [configs];
}
