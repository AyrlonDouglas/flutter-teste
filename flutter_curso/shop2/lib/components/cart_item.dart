import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop2/models/cart.dart';
import 'package:shop2/models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget({
    super.key,
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (_) {
        return showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text('Tem Certeza?'),
                content: const Text('Quer remover o item do carrinho?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      return Navigator.of(ctx).pop(false);
                    },
                    child: const Text('Não'),
                  ),
                  TextButton(
                    onPressed: () {
                      return Navigator.of(ctx).pop(true);
                    },
                    child: const Text('Sim'),
                  ),
                ],
              );
            });
      },
      onDismissed: (_) {
        Provider.of<Cart>(
          context,
          listen: false,
        ).removeItem(cartItem.productId);
      },
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Icon(
          Icons.delete,
          color: Theme.of(context).colorScheme.onError,
          size: 40,
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: ListTile(
          title: Text(cartItem.name),
          subtitle: Text('Total: R\$ ${cartItem.price * cartItem.quantity}'),
          trailing: Text('${cartItem.quantity}X'),
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                child: Text(
                  '${cartItem.price}',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
