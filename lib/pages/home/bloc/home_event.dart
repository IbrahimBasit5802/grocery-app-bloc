part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeErrorEvent extends HomeEvent {}

class HomeLoadingEvent extends HomeEvent {}

class HomeLoadedEvent extends HomeEvent {}

class HomeCartNavigationButtonClickedEvent extends HomeEvent {}

class HomeWishlistNavigationButtonClickedEvent extends HomeEvent {}

class HomeCartButtonClickedEvent extends HomeEvent {
  final Product product;

  HomeCartButtonClickedEvent({required this.product});
}

class HomeWishlistButtonClickedEvent extends HomeEvent {
  final Product product;

  HomeWishlistButtonClickedEvent({required this.product});
}
