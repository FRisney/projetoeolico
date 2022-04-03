import 'package:flutter/material.dart';

import 'sensor.dart';

class SensorGrid extends StatelessWidget {
  const SensorGrid({
    Key? key,
    required this.grupo,
  }) : super(key: key);
  final MapEntry grupo;
  final int colCount = 2;
  @override
  Widget build(BuildContext context) {
    final List sensores = grupo.value.entries.toList();
    int cnt = (sensores.length / colCount).ceil();
    List<Widget> grid = List.generate(cnt, (index) {
      var rowItems = sensores.skip(colCount * index).take(colCount);
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(rowItems.length, (index) {
          var sensor = rowItems.elementAt(index);
          return SensorDisplay(
            grupo: grupo.key,
            sensor: sensor.key,
            initialValue: sensor.value,
          );
        }),
      );
    });
    return Column(
      children: grid,
    );
  }
}
