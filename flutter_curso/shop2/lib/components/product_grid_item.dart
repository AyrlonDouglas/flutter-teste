import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop2/models/auth.dart';
import 'package:shop2/models/cart.dart';
import 'package:shop2/models/product.dart';
import 'package:shop2/utils/app_routes.dart';

class ProductGridItem extends StatelessWidget {
  const ProductGridItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: true);
    final cart = Provider.of<Cart>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);

    final msg = ScaffoldMessenger.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              onPressed: () async {
                try {
                  await product.toggleFavorite(
                    auth.token ?? '',
                    auth.userId ?? '',
                  );
                } catch (error) {
                  msg.showSnackBar(
                    SnackBar(
                      content: Text(error.toString()),
                    ),
                  );
                }
              },
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              msg.hideCurrentSnackBar();

              msg.showSnackBar(
                SnackBar(
                  content: const Text('Produto Adicionado com sucesso'),
                  duration: const Duration(
                    seconds: 2,
                  ),
                  action: SnackBarAction(
                      label: 'Desfazer',
                      onPressed: () {
                        cart.removeSingleItem(product.id);
                      }),
                ),
              );
              cart.addItem(product);
            },
            icon: Icon(Icons.shopping_cart,
                color: Theme.of(context).colorScheme.secondary),
          ),
          backgroundColor: Colors.black87,
          title: Text(
            product.name,
            textAlign: TextAlign.center,
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(AppRoutes.PRODUCT_DETAIL, arguments: product);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
