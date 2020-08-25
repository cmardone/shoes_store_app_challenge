import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:shoes_store_app/src/themes/app_theme.dart';

class ShoppingCartHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Stack(children: <Widget>[
        _PageHeaderActionLeft(),
        _PageHeaderActionRight(),
        _PageHeaderTitle()
      ]),
    );
  }
}

class _PageHeaderTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 60,
        child: Container(
          child: Text(
            'My Cart',
            style: TextStyle(
                color: kAppBackgroundColor,
                // fontFamily: kAppFontFamily,
                fontSize: 40,
                fontWeight: FontWeight.w900),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20),
        ));
  }
}

class _PageHeaderActionLeft extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      left: -15,
      child: RawMaterialButton(
        child: Icon(
          FontAwesomeIcons.times,
          color: kAppBackgroundColor,
          size: kAppLargeIconSize,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        padding: EdgeInsets.all(15),
        shape: CircleBorder(),
      ),
    );
  }
}

class _PageHeaderActionRight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 10,
        right: -5,
        child: RawMaterialButton(
          onPressed: () {},
          child: Text(
            'Edit',
            style: TextStyle(
                fontFamily: kAppFontFamily,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          shape: CircleBorder(),
          padding: EdgeInsets.all(15),
        ));
  }
}
