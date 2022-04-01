import 'package:flutter/material.dart';

class SensorDisplay extends StatelessWidget {
  const SensorDisplay({Key? key, required this.sensor, required this.valor})
      : super(key: key);

  final String sensor;
  final num valor;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 90,
        width: MediaQuery.of(context).size.width / 20 * 7,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              valor.toString(),
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(sensor),
          ],
        ),
      ),
    );
  }
}
