import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/date_display.dart';
import '../widgets/custom_grid.dart';
import '../widgets/sensor.dart';

class DetalhesGrupoPage extends StatefulWidget {
  const DetalhesGrupoPage({
    Key? key,
  }) : super(key: key);

  @override
  State<DetalhesGrupoPage> createState() => _DetalhesGrupoPageState();
}

class _DetalhesGrupoPageState extends State<DetalhesGrupoPage> {
  Map sensores = {};
  var date = DateTime.now();
  late Timer _timer;

  @override
  void initState() {
    if (mounted) {
      _timer = Timer.periodic(
        const Duration(seconds: 5),
        updateOnTimer,
      );
    }
    sensores = {
      "HOTEK": {
        "Vento": {"Unidade": "m/s", "Valor": 0.0, "Max": 16},
        "RPM": {"Unidade": "rpm", "Valor": 0, "Max": 400},
        "Potencia Instantanea": {"Unidade": "KW", "Valor": 0.0},
        "Potencia Acumulada": {"Unidade": "KW/h", "Valor": 0.0, "Max": 32},
        "Bateria": {"Unidade": "", "Valor": "Carregando"}
      }
    };
    super.initState();
  }

  void updateOnTimer(Timer timer) {
    setState(() => date = DateTime.now());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (sensores.isEmpty)
          ? const Center(child: CircularProgressIndicator())
          : _main(),
    );
  }

  Container _titleCard(String grupo, BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32.0, 32.0, 32.0, 16.0),
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: grupo.toUpperCase(),
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          TextSpan(
            text: ' Aerogeradores',
            style: Theme.of(context).textTheme.headlineSmall,
          )
        ]),
      ),
    );
  }

  _main() {
    return Container(
      margin: const EdgeInsets.only(top: 24.0),
      child: Stack(
        children: [
          ListView.builder(
            itemCount: sensores.length,
            itemBuilder: (BuildContext context, int index) {
              final grupo = sensores.entries.elementAt(index);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _titleCard(grupo.key.toString(), context),
                  CustomGrid(
                    grupo: grupo,
                    items: grupo.value.entries.toList(),
                    itemBuilder: (_, sensor) {
                      final sensorValue = sensor.value;
                      return SensorDisplay(
                        grupo: grupo.key,
                        sensor: sensor.key,
                        initialValue: sensorValue['Valor'],
                        unit: sensorValue['Unidade'],
                        max: sensorValue['Max'],
                        min: sensorValue['Min'],
                      );
                    },
                  ),
                ]..insert(0, const SizedBox(height: 35)),
              );
            },
          ),
          DateDisplay(date: date),
        ],
      ),
    );
  }
}
