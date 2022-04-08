import 'dart:async';

import 'package:flutter/material.dart';
import '../stores/detalhes_grupo.dart';
import '../widgets/date_display.dart';
import '../widgets/custom_grid.dart';
import '../widgets/sensor.dart';

class DetalhesGrupoPage extends StatefulWidget {
  const DetalhesGrupoPage({
    Key? key,
    this.child = '/',
  }) : super(key: key);

  final String child;

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
    getSensors(widget.child).then((value) {
      if (value == null) return;
      setState(() {
        sensores = value;
      });
    });
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
      child: Text(
        grupo.toUpperCase(),
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }

  _main() {
    return Container(
      margin: const EdgeInsets.only(top: 32.0),
      child: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 35),
              Expanded(
                child: ListView.builder(
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
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
          DateDisplay(date: date),
        ],
      ),
    );
  }
}
