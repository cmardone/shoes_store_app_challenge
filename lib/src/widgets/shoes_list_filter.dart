import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shoes_store_app/src/models/shoes_list_provider.dart';
import 'package:shoes_store_app/src/themes/app_theme.dart';

class ShoesListFilter extends StatelessWidget {
  const ShoesListFilter({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _ShoesListFilterBackground(),
        _ShoesListFilterContent(),
      ],
    );
  }
}

class _ShoesListFilterContent extends StatefulWidget {
  @override
  __ShoesListFilterContentState createState() =>
      __ShoesListFilterContentState();
}

class __ShoesListFilterContentState extends State<_ShoesListFilterContent> {
  Offset start;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShoesListProvider>(context);
    final height = MediaQuery.of(context).size.height;
    final double marginTop = provider.isFilterOpen ? 180 : height;
    return GestureDetector(
      onHorizontalDragStart: (details) {
        setState(() {
          start = details.globalPosition;
        });
      },
      onHorizontalDragUpdate: (details) {
        if (start.dy < details.globalPosition.dy) {
          provider.isFilterOpen = false;
        }
      },
      child: AnimatedContainer(
        curve: Curves.linear,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _ShoeListFilterContentTab(),
            SizedBox(height: 10),
            _ShoeListFilterContentTitle(),
            _ShoeListFilterContentSubtitle('Gender'),
            _ShoesListFilterContentOptions(items: ['Men', 'Women', 'Kids']),
            _ShoeListFilterContentSubtitle('Category'),
            _ShoesListFilterContentOptions(
                items: ['Shoes', 'Apparel', 'Accesories']),
            _ShoeListFilterContentSubtitle('Price'),
            _ShoesListContentRangeSlider(min: 0, max: 350, end: 250),
            _ShoeListFilterContentSubtitle('Brand'),
            _ShoesListFilterContentBrands(items: [
              'assets/images/nike.png',
              'assets/images/adidas.png',
              'assets/images/asics.png',
              'assets/images/avia.png',
            ], selected: 2),
            _ShoeListFilterContentSubtitle('Model'),
            _ShoesListFilterContentOptions(
                items: ['NMD R1', 'NMD R1 V2', 'NMD CS2'], selected: 2),
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: Colors.white,
        ),
        duration: Duration(milliseconds: 350),
        height: height,
        transform: Matrix4.translationValues(0.0, marginTop, 0.0),
        width: double.infinity,
      ),
    );
  }
}

class _ShoesListContentRangeSlider extends StatefulWidget {
  double min;
  double max;
  double start;
  double end;

  _ShoesListContentRangeSlider(
      {@required this.min, @required this.max, this.start = 0, this.end = 0});

  @override
  __ShoesListContentRangeSliderState createState() =>
      __ShoesListContentRangeSliderState();
}

class __ShoesListContentRangeSliderState
    extends State<_ShoesListContentRangeSlider> {
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        showValueIndicator: ShowValueIndicator.always,
      ),
      child: RangeSlider(
        activeColor: kAppBackgroundColor,
        inactiveColor: Color(0xFFE0E0E8),
        labels: RangeLabels('${widget.start.round()}', '${widget.end.round()}'),
        max: widget.max,
        min: widget.min,
        onChanged: (newValue) {
          setState(() {
            widget.start = newValue.start;
            widget.end = newValue.end;
          });
        },
        values: RangeValues(
            widget.start, widget.end == 0 ? widget.max : widget.end),
      ),
    );
  }
}

class _ShoesListFilterContentOptions extends StatelessWidget {
  final List<String> items;
  final int selected;

  const _ShoesListFilterContentOptions({this.items, this.selected = 1});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) =>
            _ShoesListFilterContentOption(items[index], index == selected - 1),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
      ),
      height: 60,
      margin: EdgeInsets.symmetric(horizontal: 10),
    );
  }
}

class _ShoesListFilterContentOption extends StatelessWidget {
  final String item;
  final bool selected;

  const _ShoesListFilterContentOption(this.item, this.selected);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Container(
        alignment: Alignment.center,
        child: Text(
          item,
          style: TextStyle(
            color: selected
                ? kAppBackgroundColor
                : kAppBackgroundColor.withOpacity(0.4),
            fontFamily: kAppFontFamily,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            color: selected
                ? kAppBackgroundColor
                : kAppBackgroundColor.withOpacity(0.4),
            width: 2,
          ),
        ),
        height: 60,
        margin: EdgeInsets.symmetric(horizontal: 5),
        width: 140,
      ),
      onPressed: () => print('$item button pressed'),
    );
  }
}

class _ShoesListFilterContentBrands extends StatelessWidget {
  final List<String> items;
  final int selected;

  const _ShoesListFilterContentBrands({this.items, this.selected = 1});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) =>
            _ShoesListFilterContentBrand(items[index], index == selected - 1),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
      ),
      height: 60,
      margin: EdgeInsets.symmetric(horizontal: 10),
    );
  }
}

class _ShoesListFilterContentBrand extends StatelessWidget {
  final String item;
  final bool selected;

  const _ShoesListFilterContentBrand(this.item, this.selected);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Container(
        alignment: Alignment.center,
        child: Image.asset(item, height: 50),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: selected ? kAppBackgroundColor : Color(0xFFF1F1F1),
        ),
        height: 60,
        margin: EdgeInsets.symmetric(horizontal: 5),
        width: 100,
      ),
      onPressed: () => print('$item button pressed'),
    );
  }
}

class _ShoeListFilterContentSubtitle extends StatelessWidget {
  final String subtitle;

  _ShoeListFilterContentSubtitle(this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        subtitle,
        style: TextStyle(
            fontFamily: kAppFontFamily,
            fontSize: 22,
            fontWeight: FontWeight.w900),
      ),
      padding: EdgeInsets.only(top: 25, bottom: 20),
    );
  }
}

class _ShoeListFilterContentTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Filters',
      style: TextStyle(
          color: kAppBackgroundColor,
          fontFamily: kAppFontFamily,
          fontSize: 40,
          fontWeight: FontWeight.w900),
    );
  }
}

class _ShoeListFilterContentTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        color: Colors.grey,
      ),
      height: 5,
      margin: EdgeInsets.symmetric(vertical: 10),
      width: 60,
    );
  }
}

class _ShoesListFilterBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<ShoesListProvider>(context);
    final display = provider.isFilterOpen ? 0.0 : size.height * -1;
    return Container(
      height: double.infinity,
      width: double.infinity,
      transform: Matrix4.translationValues(0.0, display, 0.0),
      color: Colors.black.withOpacity(0.7),
    );
  }
}
