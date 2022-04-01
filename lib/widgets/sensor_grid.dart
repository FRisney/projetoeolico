import 'package:flutter/material.dart';

import 'sensor.dart';

class SensorGrid extends StatelessWidget {
  const SensorGrid({
    Key? key,
    required this.sensores,
  }) : super(key: key);
  final List sensores;
  @override
  Widget build(BuildContext context) {
    int cnt = (sensores.length / 2).floor();
    var grid = List.generate(cnt, (index) {
      var sensorE = sensores.elementAt(index);
      var sensorD = sensores.elementAt(cnt + index);
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SensorDisplay(
            sensor: sensorE.key,
            valor: sensorE.value,
          ),
          SensorDisplay(
            sensor: sensorD.key,
            valor: sensorD.value,
          ),
        ],
      );
    });
    if (sensores.length.remainder(2) > 0) {
      final _sensor = sensores.last;
      grid.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SensorDisplay(sensor: _sensor.key, valor: _sensor.value),
        ],
      ));
    }
    return Column(
      children: grid,
    );
  }
}
