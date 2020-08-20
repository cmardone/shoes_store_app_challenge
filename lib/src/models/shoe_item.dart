import 'package:flutter/material.dart';

class ShoeItem {
  final String title;
  final String image;
  final double price;
  final bool isFavorite;

  ShoeItem(
      {@required this.title,
      @required this.image,
      @required this.price,
      this.isFavorite = false});
}

final shoes = <ShoeItem>[
  ShoeItem(
      title: 'NMD_R1 V2 Shoes Black',
      image: 'assets/images/NMD_R1_V2_Shoes_Black.png',
      price: 180.0),
  ShoeItem(
      title: 'Ultraboost 20 Shoes Black',
      image: 'assets/images/Ultraboost_20_Shoes_Black.png',
      price: 160.0,
      isFavorite: true),
  ShoeItem(
      title: 'NMD_R1 Shoes Black',
      image: 'assets/images/NMD_R1_Shoes_Black.png',
      price: 120.0),
  ShoeItem(
      title: 'ZX 750 Shoes Red',
      image: 'assets/images/ZX_750_HD_Shoes_Red.png',
      price: 90.0),
  ShoeItem(
      title: 'NMD_R1 Shoes Blue',
      image: 'assets/images/NMD_R1_Shoes_Blue.png',
      price: 120.0),
];
