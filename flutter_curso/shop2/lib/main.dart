import 'package:flutter/material.dart';
import 'package:shop2/models/auth.dart';
import 'package:shop2/models/cart.dart';
import 'package:shop2/models/order_list.dart';
import 'package:shop2/models/product_list.dart';
import 'package:shop2/pages/auth_or_home_page.dart';
import 'package:shop2/pages/cart_page.dart';
import 'package:shop2/pages/orders_page.dart';
import 'package:shop2/pages/product_details_page.dart';
import 'package:shop2/pages/product_form_page.dart';
import 'package:shop2/pages/products_page.dart';
import 'package:shop2/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductList>(
          create: (_) => ProductList(token: '', items: []),
          update: (ctx, auth, previous) {
            return ProductList(
              token: auth.token,
              items: previous?.items,
              userId: auth.userId,
            );
          },
        ),
        ChangeNotifierProxyProvider<Auth, OrderList>(
          create: (_) => OrderList(),
          update: (ctx, auth, previous) {
            return OrderList(
              token: auth.token,
              items: previous?.items,
              userId: auth.userId,
            );
          },
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
      ],
      child: MaterialApp(
        title: 'shop',
        theme: ThemeData(
          textTheme: const TextTheme(
            titleLarge: TextStyle(color: Colors.white),
          ),
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.purple, secondary: Colors.deepOrange),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            centerTitle: true,
            backgroundColor: Colors.purple,
            elevation: 4,
            shadowColor: Colors.black,
          ),
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.AUTH_OR_HOME: (ctx) => const AuthOrHomePage(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => const ProductDetailPage(),
          AppRoutes.CART: (ctx) => const CartPage(),
          AppRoutes.ORDERS: (ctx) => const OrdersPage(),
          AppRoutes.PRODUCTS: (ctx) => const ProductsPage(),
          AppRoutes.PRODUCT_FORM: (ctx) => const ProductFormPage(),
        },
      ),
    );
  }
}
