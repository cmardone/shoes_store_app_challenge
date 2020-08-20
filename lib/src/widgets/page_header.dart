import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shoes_store_app/src/models/menu_item.dart';
import 'package:shoes_store_app/src/themes/app_theme.dart';
import 'package:shoes_store_app/src/widgets/horizontal_menu.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      _PageHeaderBackground(),
      _PageHeaderActionLeft(),
      _PageHeaderActionRight(),
      Positioned(
        top: 120,
        child: HorizontalMenu(items: <MenuItem>[
          MenuItem(title: 'Men Shoes', selected: true),
          MenuItem(title: 'Women Shoes'),
          MenuItem(title: 'Kids Shoes'),
          MenuItem(title: 'Equipment'),
        ]),
      )
    ]);
  }
}

class _PageHeaderActionLeft extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 60,
      left: -15,
      child: RawMaterialButton(
        child: Icon(
          FontAwesomeIcons.times,
          color: kAppForegroundColor,
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
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 60,
      right: -15,
      child: RawMaterialButton(
        child: Icon(
          FontAwesomeIcons.slidersH,
          color: kAppForegroundColor,
          size: kAppLargeIconSize,
        ),
        onPressed: () {},
        padding: EdgeInsets.all(15),
        shape: CircleBorder(),
      ),
    );
  }
}

class _PageHeaderBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: CustomPaint(painter: _CurvedHeaderPainter()),
    );
  }
}

class _CurvedHeaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Lápiz
    final paint = Paint();
    paint.color = kAppBackgroundColor;
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
