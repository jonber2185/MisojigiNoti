import 'package:flutter/material.dart';

class AlarmCardWidget extends StatelessWidget {
  final String title;
  final bool status;

  const AlarmCardWidget({super.key, required this.title, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: status ? Colors.blue : Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(title),
    );
  }
}
