import 'dart:developer' as dev;
import 'package:firebase_database/firebase_database.dart';

typedef OnValueUpdated = Function(
    String grupo, String sensor, dynamic newValue);

Future<Map?> bindSensors(String from, OnValueUpdated onValueUpdated) async {
  final _ref = FirebaseDatabase.instance.ref(from);
  final dbContent = await _ref.get();
  if (dbContent.value == null) return null;
  var rootValue = dbContent.value as Map;
  rootValue.forEach((grupo, _sensores) {
    if (_sensores == null) return;
    _sensores.forEach((sensor, valor) {
      final ref = _ref.child("$grupo/$sensor");
      ref.onValue.listen((event) {
        var valor = event.snapshot.value;
        if (valor == null) return;
        onValueUpdated(grupo, sensor, valor);
      });
      dev.log(sensor.toString() + ': ' + valor.toString());
    });
  });
  return rootValue;
}
