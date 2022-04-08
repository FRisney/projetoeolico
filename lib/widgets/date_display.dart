import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateDisplay extends StatelessWidget {
  const DateDisplay({Key? key, required this.date}) : super(key: key);
  final DateTime date;
  @override
  Widget build(BuildContext context) {
    final _tema = Theme.of(context).textTheme.titleLarge;
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
