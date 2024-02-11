// Flutter imports:
import 'package:calender_application/view/calender_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'カレンダー',
          style: TextStyle(color: Colors.white),
          ),
        backgroundColor: Colors.blue,
        ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Calendar(date: DateTime(2022, 6)),
      ),
    );
  }
}
