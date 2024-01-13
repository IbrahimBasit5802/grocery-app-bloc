part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeError extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Product> products;

  HomeLoaded({required this.products});
}

class HomeCartNavigationButtonClicked extends HomeActionState {}

class HomeWishlistNavigationButtonClicked extends HomeActionState {}

class HomeWishlistButtonClickedState extends HomeActionState {}

class HomeWishListRemovedState extends HomeActionState {}

class HomeCartButtonClickedState extends HomeActionState {}
