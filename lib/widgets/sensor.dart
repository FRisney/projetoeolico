import 'package:flutter/material.dart';
import 'gauge_painter.dart';
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

  void _onValueUpdated(_, newValue) {
    setState(() {
      updatedValue = newValue['Valor'];
    });
  }

  _valueDisplay() {
    if (updatedValue is String) {
      return Card(
        color:
            updatedValue.toUpperCase() == 'NORMAL' ? Colors.green : Colors.red,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            updatedValue,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      );
    } else if (updatedValue is num) {
      double _percentage =
          updatedValue / ((widget.max ?? 100) - (widget.min ?? 0));
      if (_percentage > 1.0) _percentage = 1.0;
      return Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size.fromHeight(60),
            painter: GaugePainter(
              percentage: _percentage,
              fillColor: Colors.grey.shade700,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 35),
            child: RichText(
              textAlign: TextAlign.center,
              text: _text(context),
            ),
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
        width: MediaQuery.of(context).size.width / 20 * 7,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _valueDisplay(),
            const SizedBox(height: 14),
            Text(widget.sensor),
          ],
        ),
      ),
    );
  }

  _text(context) {
    if (widget.unit == null) {
      return TextSpan(
        text: updatedValue.toString(),
        style: Theme.of(context).textTheme.titleLarge,
      );
    } else {
      return TextSpan(
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
      );
    }
  }
}
