import 'package:flutter/material.dart';
import 'package:shoes_store_app/src/pages/shoes_list_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShoesListPage(),
      title: 'Shoes Store App',
    );
  }
}
