import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop2/components/product_grid_item.dart';
import 'package:shop2/models/product.dart';
import 'package:shop2/models/product_list.dart';

class ProducGrid extends StatelessWidget {
  final bool favoriteOnly;

  const ProducGrid({
    super.key,
    required this.favoriteOnly,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    final List<Product> loadedProducts =
        favoriteOnly ? provider.favoriteItems : provider.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: loadedProducts[i],
        child: const ProductGridItem(),
      ),
      itemCount: loadedProducts.length,
    );
  }
}
