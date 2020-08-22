import 'package:flutter/material.dart';

import 'package:shoes_store_app/src/pages/shopping_cart_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShoppingCartPage(),
      title: 'Shoes Store App',
    );
  }
}
