import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:shoes_store_app/src/models/menu_item.dart';
import 'package:shoes_store_app/src/models/shoes_list_provider.dart';
import 'package:shoes_store_app/src/themes/app_theme.dart';
import 'package:shoes_store_app/src/widgets/horizontal_menu.dart';

class ShoesListHeader extends StatelessWidget {
  final bool isDark = true;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShoesListProvider>(context);
    return Stack(children: [
      _PageHeaderBackground(provider.isDark),
      _PageHeaderActionLeft(provider.isDark),
      _PageHeaderActionRight(provider.isDark),
      _PageHeaderStripes(provider.isDark),
      Positioned(
        top: 120,
        child: HorizontalMenu(
          isDark: provider.isDark,
          items: <MenuItem>[
            MenuItem(title: 'Men Shoes', selected: true),
            MenuItem(title: 'Women Shoes'),
            MenuItem(title: 'Kids Shoes'),
            MenuItem(title: 'Equipment'),
          ],
        ),
      )
    ]);
  }
}

class _PageHeaderStripes extends StatelessWidget {
  final bool isDark;
  const _PageHeaderStripes(this.isDark);

  @override
  Widget build(BuildContext context) {
    final stripe = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(1)),
        color: isDark
            ? Colors.white.withOpacity(0.045)
            : Colors.black.withOpacity(0.1),
      ),
      height: 150,
      margin: EdgeInsets.symmetric(horizontal: 15),
      width: 40,
    );
    return Positioned(
      top: 120,
      right: 45,
      child: Transform.rotate(
        angle: math.pi / 8,
        child: Row(
          children: [stripe, stripe, stripe],
        ),
      ),
    );
  }
}

class _PageHeaderActionLeft extends StatelessWidget {
  final bool isDark;

  const _PageHeaderActionLeft(this.isDark);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 60,
      left: -15,
      child: RawMaterialButton(
        child: Icon(
          FontAwesomeIcons.times,
          color: isDark ? kAppForegroundColor : kAppBackgroundColor,
          size: kAppLargeIconSize,
        ),
        onPressed: () {},
        padding: EdgeInsets.all(15),
        shape: CircleBorder(),
      ),
    );
  }
}

class _PageHeaderActionRight extends StatelessWidget {
  final bool isDark;

  const _PageHeaderActionRight(this.isDark);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShoesListProvider>(context);
    return Positioned(
      top: 60,
      right: -15,
      child: RawMaterialButton(
        child: Icon(
          FontAwesomeIcons.slidersH,
          color: isDark ? kAppForegroundColor : kAppBackgroundColor,
          size: kAppLargeIconSize,
        ),
        onPressed: () {
          provider.isFilterOpen = !provider.isFilterOpen;
        },
        padding: EdgeInsets.all(15),
        shape: CircleBorder(),
      ),
    );
  }
}

class _PageHeaderBackground extends StatelessWidget {
  final bool isDark;

  _PageHeaderBackground(this.isDark);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: CustomPaint(painter: _CurvedHeaderPainter(isDark)),
    );
  }
}

class _CurvedHeaderPainter extends CustomPainter {
  final bool isDark;

  _CurvedHeaderPainter(this.isDark);

  @override
  void paint(Canvas canvas, Size size) {
    // Lápiz
    final paint = Paint();
    paint.color = isDark ? kAppBackgroundColor : kAppForegroundColor;
    paint.style = PaintingStyle.fill;

    // Trazos
    final path = Path();
    path.lineTo(0, size.height * 0.24);
    path.quadraticBezierTo(
        size.width / 2, size.height * 0.4, size.width, size.height * 0.31);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
