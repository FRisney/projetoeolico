import 'package:flutter/material.dart';
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
                  var grupo = sensores.entries.elementAt(index);
                  var _sensoresColumn = Column(
                    children: List.generate(grupo.value.length, (index) {
                      var sensor = grupo.value.entries.elementAt(index);
                      return Row(
                        children: [
                          Text(sensor.key),
                          const SizedBox(
                            width: 25.0,
                          ),
                          Text(sensor.value.toString()),
                        ],
                      );
                    }),
                  );
                  return ListTile(
                    leading: Text(grupo.key.toString()),
                    title: _sensoresColumn,
                  );
                },
              ),
            ),
    );
  }
}
