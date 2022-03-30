import 'package:flutter/material.dart';
import '../widgets/sensor.dart';
import '../stores/detalhes_grupo.dart';

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

  @override
  void initState() {
    bindSensors(widget.child, _onValueUpdated).then((value) {
      if (value == null) return;
      sensores = value;
    });
    super.initState();
  }

  void _onValueUpdated(grupo, sensor, newValue) {
    setState(() {
      sensores[grupo]![sensor] = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
      ),
      body: (sensores.isEmpty)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: sensores.length,
                itemBuilder: (BuildContext context, int index) {
                  final grupo = sensores.entries.elementAt(index);
                  final grupoElem = grupo.value.entries;
                  int cnt = (grupoElem.length / 2).round();
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(32.0, 32.0, 32.0, 8.0),
                      child: Column(
                        children: [
                          cardTitle(grupo.key.toString(), context),
                          Column(
                            children: List.generate(cnt, (index) {
                              var sensorE = grupoElem.elementAt(index);
                              var sensorD = grupoElem.elementAt(cnt + index);
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
                            }),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }

  Container cardTitle(String grupo, BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(height: 45.0),
      child: Text(
        grupo,
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }
}
