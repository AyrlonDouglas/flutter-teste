import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop2/components/app_drawer.dart';
import 'package:shop2/components/badgee.dart';
import 'package:shop2/components/produc_grid.dart';
import 'package:shop2/models/cart.dart';
import 'package:shop2/models/product_list.dart';
import 'package:shop2/utils/app_routes.dart';

enum FilterOptions {
  favorite,
  all,
}

class ProductsOverviewPages extends StatefulWidget {
  const ProductsOverviewPages({super.key});

  @override
  State<ProductsOverviewPages> createState() => _ProductsOverviewPagesState();
}

class _ProductsOverviewPagesState extends State<ProductsOverviewPages> {
  bool showFavoriteOnly = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    Provider.of<ProductList>(context, listen: false)
        .loadProducts()
        .then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.favorite) {
                  showFavoriteOnly = true;
                } else {
                  showFavoriteOnly = false;
                }
              });
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.favorite,
                child: Text('Somente favoritos'),
              ),
              const PopupMenuItem(
                value: FilterOptions.all,
                child: Text('Todos'),
              ),
            ],
          ),
          Consumer<Cart>(
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.CART);
              },
              icon: const Icon(Icons.shopping_cart),
            ),
            builder: (ctx, cart, child) => Badgee(
              value: cart.itemsCount.toString(),
              child: child!,
            ),
          )
        ],
        title: const Text(
          'Minha loja',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ProducGrid(favoriteOnly: showFavoriteOnly),
      drawer: const AppDrawer(),
    );
  }
}
