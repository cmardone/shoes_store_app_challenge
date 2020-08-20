import 'package:flutter/material.dart';

import 'package:shoes_store_app/src/themes/app_theme.dart';
import 'package:shoes_store_app/src/models/menu_item.dart';

class HorizontalMenu extends StatelessWidget {
  final List<MenuItem> items;

  const HorizontalMenu({@required this.items});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: kBottomNavigationBarHeight,
      width: width,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) => _HorizontalMenuItem(items[index]),
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
      ),
    );
  }
}

class _HorizontalMenuItem extends StatelessWidget {
  final MenuItem menuItem;

  _HorizontalMenuItem(this.menuItem);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Text(menuItem.title,
            style: TextStyle(
                fontFamily: kAppFontFamily,
                color: menuItem.selected
                    ? kAppMenuActiveColor
                    : kAppMenuInactiveColor,
                fontSize: kAppMenuFontSize,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
