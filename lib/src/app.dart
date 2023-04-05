import 'package:flutter/material.dart';
import 'package:today_list/src/features/today_list/presentation/today_list_screen/today_list_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Today List',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const TodayListScreen(),
    );
  }
}
