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
    getSensors(widget.child).then((value) {
      if (value == null) return;
      setState(() {
        sensores = value;
      });
    });
    super.initState();
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
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _titleCard(grupo.key.toString(), context),
                    SensorGrid(grupo: grupo),
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
