import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateDisplay extends StatefulWidget {
  const DateDisplay({Key? key}) : super(key: key);

  @override
  State<DateDisplay> createState() => _DateDisplayState();
}

class _DateDisplayState extends State<DateDisplay> {
  late DateTime date = DateTime.now();
  late Timer _timer;
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _tema = Theme.of(context).textTheme.titleLarge;
    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (timer) => setState(() {
        date = DateTime.now();
      }),
    );
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 8,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(DateFormat('dd/MM/yyyy').format(date), style: _tema),
            Text(DateFormat('HH:mm').format(date), style: _tema),
          ],
        ),
      ),
    );
  }
}
