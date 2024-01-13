import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:grocery_app/data/cart_items.dart';
import 'package:grocery_app/data/grocery_data.dart';
import 'package:grocery_app/data/wishlist_items.dart';
import 'package:grocery_app/models/Product.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeWishlistNavigationButtonClickedEvent>(
        homeWishlistButtonNavigateEvent);
    on<HomeCartNavigationButtonClickedEvent>(homeCartButtonNavigateEvent);
    on<HomeWishlistButtonClickedEvent>(homeWishlistButtonClickedEvent);
    on<HomeCartButtonClickedEvent>(homeCartButtonClickedEvent);
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartNavigationButtonClickedEvent event, Emitter<HomeState> emit) {
    emit(HomeCartNavigationButtonClicked());
  }

  FutureOr<void> homeWishlistButtonNavigateEvent(
      HomeWishlistNavigationButtonClickedEvent event, Emitter<HomeState> emit) {
    emit(HomeWishlistNavigationButtonClicked());
  }

  Future<FutureOr<void>> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    await Future.delayed(const Duration(seconds: 2));
    emit(HomeLoaded(
        products: GroceryData.groceryProducts
            .map((e) => Product.fromJson(e))
            .toList()));
  }

  FutureOr<void> homeWishlistButtonClickedEvent(
      HomeWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
    if (!wishlistItems.any((p) => p.id == event.product.id)) {
      wishlistItems.add(event.product);
      emit(HomeWishlistButtonClickedState());
    } else {
      wishlistItems.removeWhere((p) => p.id == event.product.id);
      emit(HomeWishListRemovedState());
    }

    emit(HomeLoaded(
        products: GroceryData.groceryProducts
            .map((e) => Product.fromJson(e))
            .toList()));
  }

  FutureOr<void> homeCartButtonClickedEvent(
      HomeCartButtonClickedEvent event, Emitter<HomeState> emit) {
    cartItems.add(event.product);
    emit(HomeCartButtonClickedState());
  }
}
