import 'package:flutter/material.dart';
import 'package:gauge_display/gauge_display.dart';
import '../stores/detalhes_grupo.dart';

class SensorDisplay extends StatefulWidget {
  const SensorDisplay({
    Key? key,
    required this.grupo,
    required this.sensor,
    required this.initialValue,
    this.unit = '',
    this.max = 100,
    this.min = 0,
  }) : super(key: key);

  final String unit;
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
  late num _min;
  late num _max;
  late String _unit;

  @override
  void initState() {
    updatedValue = widget.initialValue;
    _min = widget.min ?? 0;
    _max = widget.max ?? 100;
    _unit = widget.unit;
    bindSensor(
      "${widget.grupo}/${widget.sensor}",
      onValueUpdated: _onValueUpdated,
    );
    super.initState();
  }

  void _onValueUpdated(_, nv) {
    setState(() {
      updatedValue = nv['Valor'] ?? widget.initialValue;
      _min = nv['Min'] ?? (widget.min ?? 0);
      _max = nv['Max'] ?? (widget.max ?? 100);
      _unit = nv['Unidade'] ?? '';
    });
  }

  trataSensor() {
    if (updatedValue is String) {
      return Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 72,
          child: Text(
            updatedValue,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else if (widget.sensor == 'Potencia AC') {
      return Container(
        constraints: BoxConstraints.loose(Size(
          MediaQuery.of(context).size.height / 5 - 16,
          MediaQuery.of(context).size.width / 2,
        )),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 14),
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
        ),
      );
    } else if (updatedValue is num) {
      return Container(
        constraints: BoxConstraints.loose(Size(
          MediaQuery.of(context).size.height / 5 - 16,
          MediaQuery.of(context).size.width / 2,
        )),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GaugeDisplay(
              updatedValue: updatedValue,
              min: _min,
              max: _max,
              unit: _unit,
              fillColor: Colors.grey.shade700,
              useWidth: false,
            ),
            const SizedBox(height: 14),
            Text(
              widget.sensor,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
    throw Exception('tipo nao suportado');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: trataSensor(),
      ),
    );
  }
}
