import 'package:flutter/material.dart';
import 'package:projetoeolico/widgets/date_display.dart';
import 'package:projetoeolico/widgets/sensor_grid.dart';
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
      body: (sensores.isEmpty)
          ? const Center(child: CircularProgressIndicator())
          : _main(),
    );
  }

  Container cardTitle(String grupo, BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32.0, 32.0, 32.0, 16.0),
      child: Text(
        grupo.toUpperCase(),
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }

  _main() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(top: 32.0),
      child: Column(
        children: [
          const DateDisplay(),
          Expanded(
            child: ListView.builder(
              itemCount: sensores.length,
              itemBuilder: (BuildContext context, int index) {
                final grupo = sensores.entries.elementAt(index);
                final grupoElem = grupo.value.entries.toList();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    cardTitle(grupo.key.toString(), context),
                    SensorGrid(sensores: grupoElem),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
