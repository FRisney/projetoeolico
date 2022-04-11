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
      return Text(
        updatedValue,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
        textAlign: TextAlign.center,
      );
    } else if (widget.sensor == 'Potencia AC') {
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: <InlineSpan>[
                TextSpan(
                  text: updatedValue.toString(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextSpan(
                  text: '\n${widget.unit}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Text(
            widget.sensor,
            textAlign: TextAlign.center,
          ),
        ],
      );
    } else if (updatedValue is num) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GaugeDisplay(
            updatedValue: updatedValue,
            min: widget.min,
            max: widget.max,
            unit: widget.unit,
            fillColor: Colors.grey.shade700,
            pointerInset: 3.0,
            pointerLength: 8.0,
            lineWidths: 3.0,
          ),
          const SizedBox(height: 14),
          Text(
            widget.sensor,
            textAlign: TextAlign.center,
          ),
        ],
      );
    }
    throw Exception('tipo nao suportado');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width / 20 * 8,
        padding: const EdgeInsets.all(16.0),
        child: trataSensor(),
      ),
    );
  }
}
