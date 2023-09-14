import 'package:shop2/models/cart_item.dart';

class Order {
  final String id;
  final double total;
  final List<CartItem> products;
  final DateTime date;

  const Order({
    required this.id,
    required this.date,
    required this.products,
    required this.total,
  });
}
