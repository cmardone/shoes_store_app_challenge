import 'package:flutter/material.dart';
import 'package:shoes_store_app/src/models/shoe_item.dart';
import 'package:shoes_store_app/src/themes/app_theme.dart';

import 'package:shoes_store_app/src/widgets/shoes_list_header.dart';

class ShoesListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF1F5F8),
        body: Container(
          width: double.infinity,
          child: Stack(
            children: [
              ShoesListHeader(),
              ShoesList(),
            ],
          ),
        ));
  }
}

class ShoesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 135),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return _ShoesListItem(shoes[index], index + 1 == shoes.length);
          },
          itemCount: shoes.length,
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
        ),
      ),
    );
  }
}

class _ShoesListItem extends StatelessWidget {
  final ShoeItem shoeItem;
  final bool lastItem;

  const _ShoesListItem(this.shoeItem, this.lastItem);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin:
            EdgeInsets.only(left: 20, right: 20, bottom: lastItem ? 15 : 25),
        child: _ShoeItemCard(shoeItem),
        decoration: BoxDecoration(
          color: kAppForegroundColor,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            new BoxShadow(
              color: Colors.black54,
              blurRadius: 25.0,
            ),
          ],
        ),
        height: 250,
        width: double.infinity);
  }
}

class _ShoeItemCard extends StatelessWidget {
  final ShoeItem shoeItem;

  const _ShoeItemCard(this.shoeItem);

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      _ShoeItemCardAction(shoeItem: shoeItem),
      _ShoeItemCardImage(shoeItem: shoeItem),
      _ShoeItemCardText(shoeItem: shoeItem)
    ]);
  }
}

class _ShoeItemCardText extends StatelessWidget {
  const _ShoeItemCardText({
    Key key,
    @required this.shoeItem,
  }) : super(key: key);

  final ShoeItem shoeItem;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      left: 0,
      right: 0,
      child: Container(
        alignment: Alignment.bottomCenter,
        child: Column(
          children: [
            Text(shoeItem.title,
                style: TextStyle(
                    fontFamily: kAppFontFamily,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('\$${shoeItem.price.toStringAsFixed(2)}',
                style: TextStyle(
                    fontFamily: kAppFontFamily,
                    fontSize: 20,
                    fontWeight: FontWeight.normal)),
          ],
        ),
      ),
    );
  }
}

class _ShoeItemCardImage extends StatelessWidget {
  const _ShoeItemCardImage({
    Key key,
    @required this.shoeItem,
  }) : super(key: key);

  final ShoeItem shoeItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      alignment: Alignment.topCenter,
      child: Image.asset(
        shoeItem.image,
        height: 180,
      ),
    );
  }
}

class _ShoeItemCardAction extends StatelessWidget {
  const _ShoeItemCardAction({
    Key key,
    @required this.shoeItem,
  }) : super(key: key);

  final ShoeItem shoeItem;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 5,
      right: -10,
      child: RawMaterialButton(
        child:
            Icon(shoeItem.isFavorite ? Icons.favorite : Icons.favorite_border),
        onPressed: () => print('click favorite'),
        shape: CircleBorder(),
      ),
    );
  }
}
