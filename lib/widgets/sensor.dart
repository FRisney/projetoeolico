import 'package:flutter/material.dart';
import '../stores/detalhes_grupo.dart';

class SensorDisplay extends StatefulWidget {
  const SensorDisplay(
      {Key? key,
      required this.grupo,
      required this.sensor,
      required this.initialValue})
      : super(key: key);

  final String grupo;
  final String sensor;
  final num initialValue;

  @override
  State<SensorDisplay> createState() => _SensorDisplayState();
}

class _SensorDisplayState extends State<SensorDisplay> {
  late num updatedValue;

  @override
  void initState() {
    updatedValue = widget.initialValue;
    bindSensor("${widget.grupo}/${widget.sensor}", _onValueUpdated);
    super.initState();
  }

  void _onValueUpdated(_, newValue) {
    setState(() {
      updatedValue = newValue;
    });
  }

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
              updatedValue.toString(),
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(widget.sensor),
          ],
        ),
      ),
    );
  }
}
