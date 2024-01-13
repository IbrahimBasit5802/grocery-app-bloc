import 'package:flutter/material.dart';
import 'package:grocery_app/data/wishlist_items.dart';
import 'package:grocery_app/models/Product.dart';
import 'package:grocery_app/pages/home/bloc/home_bloc.dart';

class ProductTileWidget extends StatelessWidget {
  final Product product;
  final HomeBloc homeBloc;
  const ProductTileWidget(
      {super.key, required this.product, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black)),
      margin: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 300,
            width: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(product.imageUrl))),
          ),
          Text(
            product.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(product.description),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("\$" + product.price.toString()),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      homeBloc.add(
                          HomeWishlistButtonClickedEvent(product: product));
                    },
                    icon: wishlistItems.any((p) => p.id == product.id)
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : const Icon(Icons.favorite_border_outlined),
                  ),
                  IconButton(
                    onPressed: () {
                      homeBloc
                          .add(HomeCartButtonClickedEvent(product: product));
                    },
                    icon: const Icon(Icons.shopping_cart),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
