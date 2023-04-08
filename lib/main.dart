import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:today_list/src/app.dart';
import 'package:today_list/src/features/today_list/application/today_list_manager.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding
      .ensureInitialized(); // Ensure the binding is initialized
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  TodayListManager();
  FlutterNativeSplash.remove();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(const MyApp());
  });
}
