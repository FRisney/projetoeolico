import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_database/firebase_database.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _sensores = {};

  @override
  void initState() {
    _bindSensors();
    super.initState();
  }

  void _bindSensors() async {
    final DatabaseReference _ref = GetIt.I.get<DatabaseReference>();
    final snap = await _ref.get();
    final Map lol = snap.value! as Map;

    lol.forEach((comodo, sensores) {
      var sensorMap = {comodo: {}};

      (sensores as Map).forEach((sensor, valor) {
        sensorMap[comodo]![sensor] = valor as double;
        _sensores.addAll(sensorMap);

        _ref.child("$comodo/$sensor").onValue.listen((event) {
          var newValor = event.snapshot.value;
          if (newValor == null) return;
          setState(() => _sensores[comodo][sensor] = newValor as double);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: _sensores.length,
        itemBuilder: (BuildContext context, int index) {
          final comodo = _sensores.entries.toList().elementAt(index);
          final sensores = (comodo.value as Map).entries.toList();
          return ListTile(
            contentPadding: const EdgeInsets.all(16.0),
            leading: Text("${comodo.key}:"),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List.generate(
                sensores.length,
                (index) {
                  final sensor = sensores.elementAt(index);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${sensor.key} : ${sensor.value}"),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
