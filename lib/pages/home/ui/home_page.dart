import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/pages/cart/ui/cart_page.dart';
import 'package:grocery_app/pages/home/bloc/home_bloc.dart';
import 'package:grocery_app/pages/home/widgets/product_tile.dart';
import 'package:grocery_app/pages/wishlist/ui/wishlist_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeCartNavigationButtonClicked) {
          // navigate to cart page
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CartPage()));
        } else if (state is HomeWishlistNavigationButtonClicked) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const WishListPage()));
        } else if (state is HomeCartButtonClickedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Added to cart'),
            ),
          );
        } else if (state is HomeWishlistButtonClickedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Added to wishlist'),
            ),
          );
        } else if (state is HomeWishListRemovedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Removed from wishlist'),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is HomeLoaded) {
          final successState = state as HomeLoaded;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Grocery App'),
              actions: [
                IconButton(
                  onPressed: () {
                    homeBloc.add(HomeWishlistNavigationButtonClickedEvent());
                  },
                  icon: const Icon(Icons.favorite),
                ),
                IconButton(
                  onPressed: () {
                    homeBloc.add(HomeCartNavigationButtonClickedEvent());
                  },
                  icon: const Icon(Icons.shopping_cart),
                ),
              ],
            ),
            body: ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = successState.products[index];
                return ProductTileWidget(
                  product: product,
                  homeBloc: homeBloc,
                );
              },
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: Text('Error'),
            ),
          );
        }
      },
    );
  }
}
