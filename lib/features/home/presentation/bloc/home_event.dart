part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetCategories extends HomeEvent {
  @override
  List<Object> get props => [];
}

class NavigateToCategoryPage extends HomeEvent {
  final String category;
  const NavigateToCategoryPage({
    required this.category,
  });
  @override
  List<Object> get props => [category];
}
