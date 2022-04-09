import 'package:flutter/material.dart';
import 'package:gauge_display/gauge_display.dart';
import '../stores/detalhes_grupo.dart';

class SensorDisplay extends StatefulWidget {
  const SensorDisplay(
      {Key? key,
      required this.grupo,
      required this.sensor,
      required this.initialValue,
      this.unit,
      this.max,
      this.min})
      : super(key: key);

  final String? unit;
  final String grupo;
  final String sensor;
  final dynamic initialValue;
  final num? min;
  final num? max;

  @override
  State<SensorDisplay> createState() => _SensorDisplayState();
}

class _SensorDisplayState extends State<SensorDisplay> {
  late dynamic updatedValue;

  @override
  void initState() {
    updatedValue = widget.initialValue;
    bindSensor(
      "${widget.grupo}/${widget.sensor}",
      onValueUpdated: _onValueUpdated,
    );
    super.initState();
  }

  void _onValueUpdated(_, nv) => setState(() => updatedValue = nv['Valor']);

  trataSensor() {
    if (updatedValue is String) {
      return _text();
    } else if (widget.sensor == 'Potencia AC') {
      return _void();
    } else if (updatedValue is num) {
      return _gauge();
    }
    throw Exception('tipo nao suportado');
  }

  _text() => Text(
        updatedValue,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
      );

  _void() => GaugeDisplay(
        updatedValue: updatedValue,
        min: widget.min,
        max: widget.max,
        unit: widget.unit,
        fillColor: Colors.black.withOpacity(0.0),
        pointerColor: Colors.black.withOpacity(0.0),
        bgOpacity: 0.0,
        shadowOpacity: 0.0,
      );

  _gauge() => GaugeDisplay(
        updatedValue: updatedValue,
        min: widget.min,
        max: widget.max,
        unit: widget.unit,
        fillColor: Colors.grey.shade700,
      );

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width / 20 * 7,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            trataSensor(),
            const SizedBox(height: 14),
            Text(widget.sensor),
          ],
        ),
      ),
    );
  }
}
