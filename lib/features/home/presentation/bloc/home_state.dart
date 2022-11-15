part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class CategoriesState extends HomeState {
  final List<String> categories;
  final ResponseStatus status;
  const CategoriesState({
    required this.categories,
    required this.status,
  });

  @override
  List<Object> get props => [
        ...categories,
        status,
      ];
}
