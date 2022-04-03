import 'dart:developer' as dev;
import 'package:firebase_database/firebase_database.dart';

typedef OnValueUpdated = Function(String sensorPath, dynamic newValue);

Future<Map?> getSensors(String from) async {
  final _ref = FirebaseDatabase.instance.ref(from);
  final dbContent = await _ref.get();
  if (dbContent.value == null) return null;
  var rootValue = dbContent.value as Map;
  return rootValue;
}

Future<void> bindSensor(
    String sensorPath, OnValueUpdated onValueUpdated) async {
  final _ref = FirebaseDatabase.instance.ref();
  final ref = _ref.child(sensorPath);
  ref.onValue.listen((event) {
    var valor = event.snapshot.value;
    if (valor == null) return;
    onValueUpdated(sensorPath, valor);
  });
}
