part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategoryLoadedState extends CategoryState {
  final PaginatedCategory response;
  CategoryLoadedState(this.response);

  @override
  List<Object> get props => [response];
}
