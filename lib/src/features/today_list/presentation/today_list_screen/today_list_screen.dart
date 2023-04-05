import 'package:flutter/material.dart';

class TodayListScreen extends StatelessWidget {
  const TodayListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Today List'),
      ),
      body: const Center(
        child: Text('Today List'),
      ),
    );
  }
}
