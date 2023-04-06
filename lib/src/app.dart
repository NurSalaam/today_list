import 'package:flutter/material.dart';
import 'package:today_list/src/features/today_list/presentation/today_list_screen/today_list_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Today List',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        colorScheme: ColorScheme.fromSwatch(
          accentColor: Colors.black,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          toolbarTextStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontFamily: 'SourceCodePro',
          ),
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontFamily: 'SourceCodePro',
          ),
        ),
        textTheme: const TextTheme(
          titleSmall: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'SourceCodePro',
          ),
          bodyLarge: TextStyle(
              fontSize: 16, color: Colors.black, fontFamily: 'SourceCodePro'),
          bodyMedium: TextStyle(
              fontSize: 14, color: Colors.black, fontFamily: 'SourceCodePro'),
        ),
      ),
      home: const TodayListScreen(),
    );
  }
}
