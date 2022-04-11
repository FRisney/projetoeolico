import 'package:flutter/material.dart';

typedef GridItemBuilder = Function(BuildContext context, dynamic item);

class CustomGrid extends StatelessWidget {
  const CustomGrid({
    Key? key,
    required this.grupo,
    required this.items,
    required this.itemBuilder,
  }) : super(key: key);
  final MapEntry grupo;
  final int colCount = 2;
  final List items;
  final GridItemBuilder itemBuilder;

  @override
  Widget build(BuildContext context) {
    int cnt = (items.length / colCount).ceil();
    List<Widget> grid = List.generate(cnt, (index) {
      var rowItems = items.skip(colCount * index).take(colCount);
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List<Widget>.generate(rowItems.length, (index) {
          var item = rowItems.elementAt(index);
          return itemBuilder(context, item);
        }),
      );
    });
    return Column(
      children: grid,
    );
  }
}
