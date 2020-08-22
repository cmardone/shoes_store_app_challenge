import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:shoes_store_app/src/models/shoe_item.dart';
import 'package:shoes_store_app/src/themes/app_theme.dart';
import 'package:shoes_store_app/src/widgets/shopping_cart_header.dart';

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F5F8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ShoppingCartHeader(),
              _ShoppingCartList(),
              _ShoppingCartSummary(),
              _ShoppingCartCheckout()
            ],
          ),
          physics: BouncingScrollPhysics(),
        ),
      ),
    );
  }
}

class _ShoppingCartCheckout extends StatelessWidget {
  const _ShoppingCartCheckout({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Container(
        alignment: Alignment.center,
        child: Text(
          'Proceed to checkout',
          style: TextStyle(
              color: Color(0xFFF1F5F8),
              fontFamily: kAppFontFamily,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        decoration: BoxDecoration(
          color: kAppBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        height: 70,
        margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
        width: double.infinity,
      ),
      onPressed: () {},
    );
  }
}

class _ShoppingCartSummary extends StatelessWidget {
  const _ShoppingCartSummary({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total',
            style: TextStyle(
              fontFamily: kAppFontFamily,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            '\$${shoes.fold<double>(0, (t, e) => t + e.price).toStringAsFixed(2)}',
            style: TextStyle(
              fontFamily: kAppFontFamily,
              fontSize: 26,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 35),
    );
  }
}

class _ShoppingCartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: shoes.length,
        itemBuilder: (context, index) => _ShoppingCartItem(shoes[index]),
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
      ),
    );
  }
}

class _ShoppingCartItem extends StatelessWidget {
  final ShoeItem shoeItem;

  const _ShoppingCartItem(this.shoeItem);

  @override
  Widget build(BuildContext context) {
    final double horizontalMargin = 20;
    final double verticalMargin = 10;
    final double height = 130.0;
    return Stack(children: [
      _ShoppingCartItemBackground(
        horizontalMargin: horizontalMargin,
        verticalMargin: verticalMargin,
        height: height,
      ),
      _ShoppingCartItemCard(
        this.shoeItem,
        height: height,
        verticalMargin: verticalMargin,
      ),
    ]);
  }
}

class _ShoppingCartItemCard extends StatefulWidget {
  final ShoeItem shoeItem;
  final double height;
  final double horizontalMargin;
  final double verticalMargin;

  _ShoppingCartItemCard(this.shoeItem,
      {this.height = 140.0,
      this.horizontalMargin = 20,
      this.verticalMargin = 12.5});

  @override
  __ShoppingCartItemCardState createState() => __ShoppingCartItemCardState();
}

class __ShoppingCartItemCardState extends State<_ShoppingCartItemCard> {
  Offset start;
  double leftMargin = 0;

  @override
  Widget build(BuildContext context) {
    final double width =
        MediaQuery.of(context).size.width - (widget.horizontalMargin * 2);
    return GestureDetector(
      onHorizontalDragStart: (details) {
        setState(() {
          start = details.globalPosition;
        });
      },
      onHorizontalDragUpdate: (details) {
        if (start.dx > details.globalPosition.dx) {
          leftMargin = -80;
        } else {
          if (leftMargin < 0) {
            leftMargin = 0;
          }
        }
        setState(() {});
      },
      child: AnimatedContainer(
        curve: Curves.linear,
        duration: Duration(milliseconds: 200),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    widget.shoeItem.image,
                    height: 90,
                    width: 140,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.shoeItem.title,
                      style: TextStyle(
                        fontFamily: kAppFontFamily,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      widget.shoeItem.category,
                      style: TextStyle(
                        fontFamily: kAppFontFamily,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '\$${widget.shoeItem.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontFamily: kAppFontFamily,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(
                  onPressed: () {},
                  child: Icon(FontAwesomeIcons.minusSquare,
                      size: 30, color: Colors.grey),
                ),
                Text(
                  '1',
                  style: TextStyle(
                    fontFamily: kAppFontFamily,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Icon(FontAwesomeIcons.plusSquare, size: 30),
                )
              ],
            )
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: kAppForegroundColor,
        ),
        height: widget.height,
        transform: Matrix4.translationValues(leftMargin, 0.0, 0.0),
        margin: EdgeInsets.symmetric(
          horizontal: widget.horizontalMargin,
          vertical: widget.verticalMargin,
        ),
        width: width,
      ),
    );
  }
}

class _ShoppingCartItemBackground extends StatelessWidget {
  final double horizontalMargin;
  final double verticalMargin;
  final double height;

  const _ShoppingCartItemBackground(
      {this.height = 140.0,
      this.horizontalMargin = 20,
      this.verticalMargin = 12.5});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: RawMaterialButton(
        onPressed: () {},
        shape: CircleBorder(),
        padding: EdgeInsets.all(15),
        child: Icon(Icons.delete_outline, size: 36, color: Colors.red),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: kAppBackgroundColor,
        boxShadow: [
          new BoxShadow(
            color: Colors.black26,
            blurRadius: verticalMargin,
          ),
        ],
      ),
      height: height,
      margin: EdgeInsets.symmetric(
        vertical: verticalMargin,
        horizontal: horizontalMargin,
      ),
      padding: EdgeInsets.only(left: 20.0),
      width: double.infinity,
    );
  }
}
