import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop2/components/app_drawer.dart';
import 'package:shop2/components/order.dart';
import 'package:shop2/models/order_list.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Meus Pedidos',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<OrderList>(
          context,
          listen: false,
        ).loadOrders(),
        builder: (ctx, snapshop) {
          if (snapshop.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshop.error != null) {
            return const Center(
              child: Text('Ocorreu um erro!'),
            );
          } else {
            return Consumer<OrderList>(
              builder: (ctx, orders, child) {
                return ListView.builder(
                  itemCount: orders.itemsCount,
                  itemBuilder: (ctx, index) =>
                      OrderWidget(order: orders.items[index]),
                );
              },
            );
          }
        },
      ),
      // body: RefreshIndicator(
      //   onRefresh: () => _refreshOrders(context),
      //   child: ListView.builder(
      //     itemCount: orders.itemsCount,
      //     itemBuilder: (ctx, index) =>
      //         OrderWidget(order: orders.items[index]),
      //   ),
      // ),
    );
  }
}
