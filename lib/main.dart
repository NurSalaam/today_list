import 'package:flutter/material.dart';
import 'package:today_list/src/app.dart';
import 'package:today_list/src/features/today_list/application/today_list_manager.dart';

void main() {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure the binding is initialized
  TodayListManager();
  runApp(const MyApp());
}

// TODO: DISABLE DEBUG, ENABLE RELEASE