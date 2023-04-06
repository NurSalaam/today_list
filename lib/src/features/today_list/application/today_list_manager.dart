import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:today_list/src/features/today_list/data/today_item_repository.dart';

import '../domain/today_item.dart';

class TodayListManager {
  // Singleton instance
  static final TodayListManager _instance = TodayListManager._internal();

  factory TodayListManager() {
    return _instance;
  }

  TodayListManager._internal() {
    _loadLastCheckedDate();
    _saveFirstOpenDate();
    _setupPeriodicCheck();
  }

  DateTime _lastCheckedDate = DateTime.now();

  Future<void> _loadLastCheckedDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int lastCheckedTimestamp = prefs.getInt('lastCheckedDate') ?? 0;
    if (lastCheckedTimestamp != 0) {
      _lastCheckedDate =
          DateTime.fromMillisecondsSinceEpoch(lastCheckedTimestamp);
    }
  }

  Future<void> _saveLastCheckedDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
        'lastCheckedDate', _lastCheckedDate.millisecondsSinceEpoch);
  }

  void _setupPeriodicCheck() {
    // Run the check every minute
    Timer.periodic(const Duration(minutes: 1), (Timer timer) {
      _periodicCheck();
    });
  }

  void _periodicCheck() async {
    DateTime now = DateTime.now();
    if (now.day != _lastCheckedDate.day ||
        now.month != _lastCheckedDate.month ||
        now.year != _lastCheckedDate.year) {
      _clearTodays();
      _lastCheckedDate = now;
      _saveLastCheckedDate();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      DateTime firstOpenDate = DateTime.fromMillisecondsSinceEpoch(
          prefs.getInt('firstOpenDate') ??
              DateTime.now().millisecondsSinceEpoch);

      int dayOfMonth = firstOpenDate.day > 28 ? 1 : firstOpenDate.day;

      // Add the monthly item based on the user's first open date
      if (now.day == dayOfMonth && now.month != firstOpenDate.month) {
        _addMonthlyItem(now);
      }
    }
  }

  void _clearTodays() {
    TodayItemRepository().clearAllItems();
  }

  Future<void> _saveFirstOpenDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('firstOpenDate')) {
      await prefs.setInt(
          'firstOpenDate', DateTime.now().millisecondsSinceEpoch);

      // Add the monthly item immediately after saving the first open date
      _addMonthlyItem(DateTime.now());
    }
  }

  void _addMonthlyItem(DateTime now) async {
    String monthlyItemText =
        "Buy my dev a coffee ☕️✌️😁 | https://www.buymeacoffee.com/nusa"; // Customize the text
    TodayItem monthlyItem = TodayItem(text: monthlyItemText, dateCreated: now);
    await TodayItemRepository().addTodayItem(monthlyItem);
  }
}
