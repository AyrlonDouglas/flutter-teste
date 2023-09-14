import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop2/models/cart.dart';
import 'package:shop2/models/cart_item.dart';
import 'package:shop2/models/order.dart';
import 'package:shop2/utils/constants.dart';

class OrderList with ChangeNotifier {
  late String _token;
  late String _userId;
  late List<Order> _items = [];

  OrderList({
    String? token,
    String? userId,
    List<Order>? items,
  }) {
    _token = token ?? '';
    _userId = userId ?? '';
    _items = items ?? [];
  }

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadOrders() async {
    // _items.clear();
    List<Order> items = [];

    final response = await http.get(
      Uri.parse('${Constants.ORDER_BASE_URL}/$_userId.json?auth=$_token'),
    );
    if (response.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((orderId, orderData) {
      items.add(
        Order(
          id: orderId,
          date: DateTime.parse(orderData['date']),
          total: orderData['total'],
          products: (orderData['products'] as List<dynamic>).map((item) {
            return CartItem(
              id: item['id'],
              productId: item['productId'],
              name: item['name'],
              quantity:
                  item['quantity'] ?? 0, //TODO: Verificar o pq desse problema
              price: item['price'],
            );
          }).toList(),
        ),
      );
    });
    _items = items.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();

    final response = await http.post(
      Uri.parse('${Constants.ORDER_BASE_URL}/$_userId.json?auth=$_token'),
      body: jsonEncode(
        {
          'total': cart.totalAmount,
          'date': date.toIso8601String(),
          'products': cart.items.values
              .map(
                (cartItem) => {
                  'id': cartItem.id,
                  'productId': cartItem.productId,
                  'name': cartItem.name,
                  'quantity': cartItem.quantity,
                  'price': cartItem.price,
                },
              )
              .toList(),
        },
      ),
    );

    final id = jsonDecode(response.body)['name'];
    _items.insert(
      0,
      Order(
        id: id,
        total: cart.totalAmount,
        date: date,
        products: cart.items.values.toList(),
      ),
    );

    notifyListeners();
  }
}
