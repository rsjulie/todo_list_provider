import 'package:flutter/material.dart';

class Task extends StatelessWidget {
  const Task({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.grey),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: IntrinsicHeight(
          child: ListTile(
        leading: Checkbox(
          value: true,
          onChanged: (value) {},
        ),
        title: const Text(
          'Descrição da TASK',
          style: TextStyle(decoration: TextDecoration.lineThrough),
        ),
        subtitle: const Text(
          '10/05/2022',
          style: TextStyle(decoration: TextDecoration.lineThrough),
        ),
        contentPadding: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(width: 1)),
      )),
    );
  }
}
